variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster"
  default     = "illuminti-eks-cluster"
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EKS cluster"
  type        = list(string)
}

variable "cluster-name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "kubernetes-version" {
  description = "Version of Kubernetes to use for the EKS cluster"
  type        = string
}

variable "subnet_ids_public" {
  description = "List of public subnet IDs for EKS cluster"
  type        = list(string)
}

variable "subnet_ids_private" {
  description = "List of private subnet IDs for EKS cluster"
  type        = list(string)
}
