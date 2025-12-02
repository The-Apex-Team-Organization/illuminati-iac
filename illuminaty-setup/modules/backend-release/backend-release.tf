
data "kubernetes_namespace" "app_namespace" {
  metadata {
    name = var.app_namespace
  }
}

# resource "helm_release" "backend" {
#   name      = "release-backend"
#   namespace = var.app_namespace
#   chart     = "${path.module}/../helm-charts/backend"
#
#
#   depends_on = [
#     data.kubernetes_namespace.app_namespace,
#     var.illuminati-eks-nodes-id
#   ]
#
#   atomic          = true
#   cleanup_on_fail = true
#   timeout         = 600
#   wait            = true
# }
