locals {
  common_tags = {
    CreatedBy   = "Terraform"
    Project     = "Birdwatching"
    Environment = var.env
    Repository  = "https://github.com/Code-Illuminators/Illuminators_infra"
    Module      = "birdwatching-setup"
  }
}