variable "app_namespace" {
  description = "The Kubernetes namespace to deploy the app into"
  type        = string
}


variable "illuminati-eks-nodes-id" {
  description = "EKS node id"
  type        = string
}