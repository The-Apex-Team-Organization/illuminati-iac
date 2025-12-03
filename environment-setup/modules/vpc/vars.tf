variable "vpc-id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"  = "Terraform"
    "Project"    = "illuminati"
    "Repository" = "terraform-state-illuminati-the-apex-team"
    "Module"     = "environment-setup"
  }
}

variable "public-subnet-for-jenkins" {
  description = "The subnet where nat gateway for Jenkins will be deployed"
  type        = string
}

variable "private-subnet-cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "public-subnet-cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private-subnet-azs" {
  description = "Availability zones for private subnets"
  type        = list(string)
}

variable "public-subnet-azs" {
  description = "Availability zones for public subnets"
  type        = list(string)
}

# data "aws_subnet" "jenkins-subnet" {
#   tags = {
#     Name = "private-${var.availability-zone}-jenkins"
#   }
# }
