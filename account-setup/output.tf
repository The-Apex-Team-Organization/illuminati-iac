output "iam_user_credentials" {
  description = "all creds of our users"
  value       = module.iam.user_credentials
  sensitive   = true
}

# uncomment this when you need to see the output
# were commented out to avoid leaking sensitive data

output "vpc_id" {
  description = "VPC id"
  value       = module.vpc.vpc-id
}

output "jenkins_deployment_role_arn" {
  description = "ARN of the role that Jenkins can assume"
  value       = module.iam.jenkins_deployment_role_arn
}

output "jenkins_deployment_role_name" {
  description = "Name of the deployment role"
  value       = module.iam.jenkins_deployment_role_name
}