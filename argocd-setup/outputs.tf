output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argocd-deployment.argocd_namespace
}

output "argocd_release_status" {
  description = "ArgoCD Helm release status"
  value       = module.argocd-deployment.argocd_release_status
}
