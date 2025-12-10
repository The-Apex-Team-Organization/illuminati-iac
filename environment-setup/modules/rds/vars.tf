variable "db_username_base64" {
  description = "Base64 encoded database username"
  type        = string
  sensitive   = true
}

variable "db_name_base64" {
  description = "Base64 encoded database name"
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

variable "subnet_ids_private" {
  description = "List of private subnet IDs for RDS to associate"
  type        = list(string)
}

variable "private-subnet-cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "vpc-id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}