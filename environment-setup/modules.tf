module "environment-vpc" {
  source                    = "./modules/vpc/"
  vpc-id                    = data.aws_vpc.account-vpc.id
  env                       = var.env
  availability-zone         = var.availability-zone
  region                    = var.region
  public-subnet-for-jenkins = var.public-subnet-for-jenkins
  private-subnet-cidrs      = var.private-subnet-cidrs
  public-subnet-cidrs       = var.public-subnet-cidrs
  private-subnet-azs        = var.private-subnet-azs
  public-subnet-azs         = var.public-subnet-azs
}

module "enviroment-ecr" {
  source = "./modules/ecr/"
  region = var.region
  env    = var.env
}

module "environment-eks" {
  source             = "./modules/eks/"
  region             = var.region
  env                = var.env
  cluster-name       = var.cluster-name
  kubernetes-version = var.kubernetes-version
  subnet_ids_private = [
    module.environment-vpc.private-us-east-1a,
  module.environment-vpc.private-us-east-1b, ]
  subnet_ids_public = [
    module.environment-vpc.public-us-east-1a,
  module.environment-vpc.public-us-east-1b,]
  subnet_ids = [
    module.environment-vpc.private-us-east-1a,
    module.environment-vpc.private-us-east-1b,
    module.environment-vpc.public-us-east-1a,
    module.environment-vpc.public-us-east-1b
  ]
}

module "rds_mariadb" {
  source             = "./modules/rds"
  db_name_base64     = var.db_name_base64
  db_username_base64 = var.db_username_base64
  env                = var.env
  region             = var.region
  subnet_ids_private = [
    module.environment-vpc.private-us-east-1a,
  module.environment-vpc.private-us-east-1b, ]
  private-subnet-cidrs = var.private-subnet-cidrs
  vpc-id               = data.aws_vpc.account-vpc.id
}

module "dns" {
  source      = "./modules/dns"
  domain-name = var.domain-name
}