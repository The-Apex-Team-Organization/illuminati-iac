variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "cluster-name" {
  description = "name of transferred EKS cluster"
}

variable "argocd-chart-version" {
  description = "version of argoCD helm chart"
  type        = string
}

variable "app-namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
}
