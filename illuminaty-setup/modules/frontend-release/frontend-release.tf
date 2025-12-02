
resource "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.app_namespace
    labels = {
      name                                  = var.app_namespace
      environment                           = var.env
      "consul.hashicorp.com/connect-inject" = "enabled"
    }
  }
}

# resource "helm_release" "frontend" {
#   name      = "release-frontend"
#   namespace = kubernetes_namespace.app_namespace.metadata[0].name
#   chart     = "${path.module}/../helm-charts/frontend"
#
#   depends_on = [
#     kubernetes_namespace.app_namespace,
#     var.illuminati-eks-nodes-id
#   ]
#   values = [
#     file("./modules/helm-charts/frontend/values-stage-01.yaml")
#   ]
#   atomic          = true
#   cleanup_on_fail = true
#   timeout         = 600
#   wait            = true
# }
