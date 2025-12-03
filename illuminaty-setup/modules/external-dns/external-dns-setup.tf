resource "helm_release" "external_dns" {
  name       = "external-dns"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "external-dns"
  namespace  = "kube-system"
  version    = "8.3.0"

  set {
    name  = "provider"
    value = "aws"
  }

  set {
    name  = "aws.region"
    value = var.region
  }
  set {
    name  = "image.registry"
    value = "registry.k8s.io"
  }
  set {
    name  = "image.repository"
    value = "external-dns/external-dns"
  }
  set {
    name  = "image.tag"
    value = "v0.14.2"
  }
  set {
    name  = "txtOwnerId"
    value = var.eks_cluster_name
  }

  set {
    name  = "policy"
    value = "sync"
  }

  set {
    name  = "domainFilters[0]"
    value = var.domain-name
  }

  set {
    name  = "serviceAccount.create"
    value = "true"
  }
  set {
    name  = "serviceAccount.name"
    value = "external-dns-service"
  }
}