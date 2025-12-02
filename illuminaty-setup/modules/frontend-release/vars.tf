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

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "app_namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
}

variable "illuminati-eks-nodes-id" {
  description = "EKS node id"
  type        = string
}