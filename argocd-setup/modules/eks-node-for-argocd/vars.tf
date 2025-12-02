variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "cluster-name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "private-subnet-ids" {
  description = "ids for private subnets"
  type        = list(string)
}