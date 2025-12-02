variable "domain-name" {
  description = "Domain name for illuminati app"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}