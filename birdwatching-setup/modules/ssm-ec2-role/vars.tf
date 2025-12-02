variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"  
  type = string
}

variable "common_tags" {
  type = map(string)
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}