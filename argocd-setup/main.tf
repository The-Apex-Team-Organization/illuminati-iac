provider "aws" {
  region = var.region
  default_tags {
    tags = {
      "CreatedBy"   = "Terraform"
      "Project"     = "illuminati"
      "Environment" = var.env
      "Repository"  = "https://github.com/Red-I3ull/illuminati-iac.git"
      "Module"      = "argocd-setup"
    }
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.illuminati_eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.illuminati_eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.illuminati_eks.token
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.illuminati_eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.illuminati_eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.illuminati_eks.token
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.14.1"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.23"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.11"
    }
  }

  backend "s3" {
    # Usage: terraform init -backend-config=backends/dev.tfbackend
  }
}