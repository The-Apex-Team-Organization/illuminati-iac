output "lambda_function_name" {
  value = module.aws_lambda_function.lambda_function_name
}

output "lambda_role_arn" {
  value = module.aws_lambda_function.lambda_role_arn
}

output "lambda_function_url" {
  value = module.aws_lambda_function.lambda_function_url
}
