provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "illuminati"
      "Environment" = var.env
      "Repository"  = "https://github.com/the-apex-team/illuminati-iac.git"
      "Module"      = "lambda-setup"
    }
  }
}
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.2"
    }
  }

  backend "s3" {
    # Usage: terraform init -backend-config=backends/dev.tfbackend
  }
}

