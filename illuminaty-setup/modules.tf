
module "aws-lb-controller" {
  source           = "./modules/aws-lb-controller"
  vpc-id           = var.vpc-id
  region           = var.region
  eks_cluster_name = var.eks_cluster_name
}

module "external-dns" {
  source           = "./modules/external-dns"
  domain-name      = var.domain-name
  eks_cluster_name = var.eks_cluster_name
  region           = var.region
}

module "helm_releases" {
  source                    = "./modules/frontend-release"
  env                       = var.env
  app_namespace             = var.app_namespace
  frontend_image_repository = var.frontend_image_repository
  frontend_image_tag        = var.frontend_image_tag
  frontend_replicas         = var.frontend_replicas
  illuminati-eks-nodes-id   = var.illuminati-eks-nodes-id
  depends_on                = [module.aws-lb-controller, module.external-dns]
}


module "backend_release" {
  source                  = "./modules/backend-release"
  app_namespace           = var.app_namespace
  illuminati-eks-nodes-id = var.illuminati-eks-nodes-id
}