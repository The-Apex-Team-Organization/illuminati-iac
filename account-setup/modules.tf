module "iam" {
  source             = "./modules/iam"
  username           = var.username
  region             = var.region
  env                = var.env
  jenkins_account_id = var.jenkins_account_id
}

module "vpc" {
  source      = "./modules/vpc"
  region      = var.region
  common_tags = {}
}


module "Prometheus" {
  source                         = "./modules/prometheus-setup"
  vpc-id                         = module.vpc.vpc-id
  private-subnets-for-prometheus = var.private-subnets-for-prometheus
  env                            = var.env
  region                         = var.region
  instance-type                  = var.instance-type
  ami                            = var.ami
  availability-zone              = var.availability-zone
}