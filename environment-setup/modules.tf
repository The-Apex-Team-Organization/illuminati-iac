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
  module.environment-vpc.public-us-east-1b, ]
  subnet_ids = [
    module.environment-vpc.private-us-east-1a,
    module.environment-vpc.private-us-east-1b,
    module.environment-vpc.public-us-east-1a,
    module.environment-vpc.public-us-east-1b
  ]
}

module "rds_mariadb" {
  source = "./modules/rds"

  cluster-name               = var.cluster-name
  private_cluster_cidr_block_1 = var.private_cluster_cidr_block_1
  private_cluster_cidr_block_2 = var.private_cluster_cidr_block_2

  db_username                = var.db_username
  db_password                = var.db_password

  vpc_id                     = data.aws_vpc.account-vpc.id
  public_route_table_id      = data.aws_route_table.rtb.id

  db_private_subnet_1        = var.db_private_subnet_1
  db_private_subnet_2        = var.db_private_subnet_2
  db_availability_zone_1     = var.db_availability_zone_1
  db_availability_zone_2     = var.db_availability_zone_2
}

module "dns" {
  source      = "./modules/dns"
  domain-name = var.domain-name
}