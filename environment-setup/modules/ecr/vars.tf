variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"   = "Terraform"
    "Project"     = "illuminati"
    "Environment" = "dev-01"
    "Repository"  = "terraform-state-illuminati-the-apex-team"
    "Module"      = "environment-setup"
  }
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "illuminati"
  }
}