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

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "frontend_image_repository" {
  description = "ECR repository URL for frontend"
  type        = string
}

variable "frontend_image_tag" {
  description = "Docker image tag for frontend"
  type        = string
}

variable "frontend_replicas" {
  description = "Number of frontend pod replicas"
  type        = number
}


variable "app_namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
}

variable "illuminati-eks-nodes-id" {
  description = "EKS node id"
  type        = string
}

variable "domain-name" {
  description = "Domain name for illuminati app"
  type        = string
}