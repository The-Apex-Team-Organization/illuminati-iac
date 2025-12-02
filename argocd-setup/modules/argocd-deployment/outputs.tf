output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = kubernetes_namespace.argocd.metadata[0].name
}

output "argocd_release_name" {
  description = "ArgoCD Helm release name"
  value       = helm_release.argocd.name
}

output "argocd_release_status" {
  description = "ArgoCD Helm release status"
  value       = helm_release.argocd.status
}