output "lambda_function_name" {
  value = aws_lambda_function.entry_pass.function_name
}

output "lambda_role_arn" {
  value = aws_iam_role.lambda_exec.arn
}

output "lambda_function_url" {
  value = aws_lambda_function_url.entry_pass_url.function_url
}