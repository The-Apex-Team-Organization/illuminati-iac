variable "region" {
  description = "The region to create the resources in"
  type        = string
}
variable "vpc-id" {
  description = "The VPC ID where Jenkins will be deployed"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "ami" {
  description = "Machine Image that provides the software necessary to configure and launch an EC2 instance"
  type        = string
}

variable "private-subnets-for-jenkins" {
  description = "The subnet where Jenkins will be deployed"
  type        = string
}

variable "instance-type" {
  description = "default instance type for our project"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "dev_deployment_role_arn" {
  description = "ARN of the deployment role in dev account"
  type        = string
}

variable "prod_deployment_role_arn" {
  description = "ARN of the deployment role in prod account"
  type        = string
}
variable "stage_deployment_role_arn" {
  description = "ARN of the deployment role in stage account"
  type        = string
}