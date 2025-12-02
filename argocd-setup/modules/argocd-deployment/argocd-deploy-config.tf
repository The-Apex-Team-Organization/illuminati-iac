resource "kubernetes_namespace" "argocd" {
  metadata {
    name = var.app-namespace
    labels = {
      name        = var.app-namespace
      environment = var.env
    }
  }
}

resource "helm_release" "argocd" {
  name       = "argocd"
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  namespace  = kubernetes_namespace.argocd.metadata[0].name
  version    = var.argocd-version

  set {
    name  = "server.service.type"
    value = "LoadBalancer"
  }

  # Wait for all resources to be ready
  wait            = true
  wait_for_jobs   = true
  cleanup_on_fail = true
  timeout         = 600

  depends_on = [kubernetes_namespace.argocd]
}
