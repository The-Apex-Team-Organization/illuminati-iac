output "repository_url" {
  value       = module.enviroment-ecr.repository_url
  description = "our repository urls"
}

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = module.environment-eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = module.environment-eks.cluster_endpoint
}

output "cluster_id" {
  description = "EKS Cluster ID"
  value       = module.environment-eks.cluster_id
}

output "illuminati-eks-nodes-id" {
  description = "EKS node id"
  value       = module.environment-eks.illuminati-eks-nodes-id
}

output "db_connection_info" {
  description = "Database connection info "
  value       = module.rds_mariadb.db_connection_info
  sensitive   = true
}

output "secrets_manager_arn" {
  description = "ARN of the Secrets Manager secret containing the password"
  value       = module.rds_mariadb.secrets_manager_arn
}

output "acm_certificate_arn" {
  value = module.dns.acm_certificate_arn
}