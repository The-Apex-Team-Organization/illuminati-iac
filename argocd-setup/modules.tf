module "eks-node-for-argocd-consul" {
  source = "./modules/eks-node-for-argocd"

  cluster-name       = data.aws_eks_cluster.illuminati_eks.name
  private-subnet-ids = data.aws_subnets.private_subnets.ids

  env = var.env
}

module "argocd-deployment" {
  source = "./modules/argocd-deployment"

  env          = var.env
  cluster-name = data.aws_eks_cluster.illuminati_eks.name


  argocd-version = var.argocd-chart-version
  region         = var.region

  depends_on    = [module.eks-node-for-argocd-consul]
  app-namespace = var.app-namespace
}
