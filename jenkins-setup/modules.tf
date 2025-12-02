
module "Jenkins" {
  source                      = "./modules/jenkins"
  vpc-id                      = var.vpc-id
  private-subnets-for-jenkins = var.private-subnets-for-jenkins
  env                         = var.env
  region                      = var.region
  ami                         = var.ami
  availability-zone           = var.availability-zone
  dev_deployment_role_arn     = var.dev_deployment_role_arn
  prod_deployment_role_arn    = var.prod_deployment_role_arn
  stage_deployment_role_arn   = var.stage_deployment_role_arn
}
