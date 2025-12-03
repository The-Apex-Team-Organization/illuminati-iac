output "db_connection_info" {
  description = "Database connection info "
  value = {
    id       = aws_db_instance.mariadb.id
    endpoint = aws_db_instance.mariadb.endpoint
    host     = aws_db_instance.mariadb.address
    port     = aws_db_instance.mariadb.port
    username = local.db_username
    database = local.db_name
    password = local.db_password
  }
  sensitive = true
}

output "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret containing the password"
  value       = aws_secretsmanager_secret.rds_creds.arn
}

output "secrets_manager_name" {
  description = "Name of the Secrets Manager secret"
  value       = aws_secretsmanager_secret.rds_creds.name
}

