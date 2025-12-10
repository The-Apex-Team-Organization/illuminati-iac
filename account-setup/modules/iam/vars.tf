variable "username" {
  description = "List of users that must be created and added to the Administrators group"
  type        = list(string)
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "jenkins_account_id" {
  description = "AWS Account ID where Jenkins is running (stage account)"
  type        = string
}