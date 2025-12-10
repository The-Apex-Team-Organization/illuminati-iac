resource "aws_iam_role" "jenkins_deployment" {
  name = "${var.env}-jenkins-deployment-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${var.jenkins_account_id}:root" # acount id where jenkins be deployed 
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name        = "${var.env}-jenkins-deployment-role"
    Environment = var.env
  }
}

resource "aws_iam_role_policy" "jenkins_deployment" {
  name = "jenkins-deployment-policy"
  role = aws_iam_role.jenkins_deployment.id

  policy = file("./modules/iam/jenkins-policy.json")
}