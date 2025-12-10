variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
  default     = "us-east-1a"
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "public-subnet-for-jenkins" {
  description = "The subnet where nat gateway for Jenkins will be deployed"
  type        = string
}

variable "cluster-name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes-version" {
  description = "Version of Kubernetes to use for the EKS cluster"
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

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "illuminati"
  }
}


variable "db_username_base64" {
  description = "Base64 encoded database username"
  type        = string
  sensitive   = true
}

variable "db_name_base64" {
  description = "Base64 encoded database name"
  type        = string
}

variable "domain-name" {
  description = "Domain name for illuminati app"
  type        = string
}