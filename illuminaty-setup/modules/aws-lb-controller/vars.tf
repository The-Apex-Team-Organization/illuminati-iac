variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "vpc-id" {
  description = "The VPC ID where Jenkins will be deployed"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}