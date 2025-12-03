output "private-subnet-jenkins-id" {
  description = "The id subnet Jenkins"
  value       = aws_subnet.private-subnet-jenkins.id
}

output "public-jenkins-key-name" {
  value = aws_key_pair.jenkins-key-pair.key_name
}
