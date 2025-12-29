resource "aws_iam_role" "lambda_exec" {
  name = "bird_lambda_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

# ------- Build Lambda Function-------

resource "null_resource" "install_dependencies" {
  provisioner "local-exec" {
    command = "pip install -r ${path.module}/src/requirements.txt -t ${path.module}/lambda_build/ --upgrade"
  }

  triggers = {
    requirements_diff = filemd5("${path.module}/src/requirements.txt")
  }
}

resource "null_resource" "copy_source" {
  depends_on = [null_resource.install_dependencies]

  provisioner "local-exec" {
    command = "cp ${path.module}/src/*.py ${path.module}/src/*.jpg ${path.module}/lambda_build/"
  }

  triggers = {
    always_run = timestamp() # Ensures code updates are always captured
  }
}

# Create ZIP archive from the build folder
data "archive_file" "lambda_zip" {
  depends_on  = [null_resource.copy_source]
  type        = "zip"
  source_dir  = "${path.module}/lambda_build"
  output_path = "${path.module}/lambda_function.zip"
}

resource "aws_lambda_function" "entry_pass" {
  filename         = data.archive_file.lambda_zip.output_path
  function_name    = "entry_pass_function"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256
  runtime          = "python3.9"
  timeout          = 30 # Increased timeout for network requests

  environment {
    variables = {
      BIRD_APP_URL       = var.bird_app_url
      BIRD_USER          = var.bird_user
      BIRD_PASS          = var.bird_pass
      ILLUMINATI_API_URL = var.illuminati_api_url
    }
  }
}

# Create Lambda Function URL
resource "aws_lambda_function_url" "entry_pass_url" {
  function_name      = aws_lambda_function.entry_pass.function_name
  authorization_type = "NONE" # Use "AWS_IAM" for authenticated access

  cors {
    allow_credentials = true
    allow_origins     = ["*"]
    allow_methods     = ["POST", "GET"]
    allow_headers     = ["*"]
    max_age           = 86400
  }
}
