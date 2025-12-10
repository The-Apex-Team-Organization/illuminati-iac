output "repository_url" {
  value = {
    for key, repo in aws_ecr_repository.repositories : key => repo.repository_url
  }
  description = "Rpo url for our maria-db images"
}
