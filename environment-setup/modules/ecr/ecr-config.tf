locals {
  ecr_repositories = {
    mariadb = {
      name = "illuminati-mariadb-img"
    }
    frontend = {
      name = "illuminati-react-frontend"
    }
    backend = {
      name = "illuminati-django-backend"
    }
    helm = {
      name = "illuminati-helm-charts"
    }
  }
}

resource "aws_ecr_repository" "repositories" {
  for_each = local.ecr_repositories

  name                 = each.value.name
  image_tag_mutability = "IMMUTABLE"
  region               = var.region

  encryption_configuration {
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }

  tags = merge(var.common_tags, {
    Name    = "ecr-repo-for-${each.value.name}-${var.env}"
    Project = "illuminati"
  })
}