variable "vpc-id" {
  description = "The VPC ID where Jenkins will be deployed"
  type        = string
}

variable "private-subnets-for-prometheus" {
  description = "The subnet where Prometheus will be deployed"
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

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}

variable "common_tags" {
  type = map(string)
  default = {
    "CreatedBy"  = "Terraform"
    "Project"    = "Birdwatching"
    "Repository" = "https://github.com/The-Apex-Team-Organization "
    "Module"     = "account-setup"
  }
}

variable "instance-type" {
  description = "default instance type for our project"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
}