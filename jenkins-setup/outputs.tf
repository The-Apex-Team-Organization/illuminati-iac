output "public-jenkins-key-name" {
  value = module.Jenkins.public-jenkins-key-name
}

output "private-subnet-jenkins-id" {
  description = "The id subnet Jenkins"
  value       = module.Jenkins.private-subnet-jenkins-id
}
