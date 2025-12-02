module "lb" {
  source                = "./modules/lb-instance/"
  env                   = var.env
  ami_name              = var.ami_name
  public-subnets-for-lb = var.public-subnets-for-lb
  region                = var.region
  instance-type         = var.instance-type
  availability-zone     = var.availability-zone
  dns-name              = var.dns-name
  common_tags           = local.common_tags
  ssm_instance_profile_name = module.ssm_ec2_role.instance_profile_name
  #data var block
  vpc-cidr-block            = data.aws_vpc.account-vpc.cidr_block
  public-route-table-id     = data.aws_route_table.public-route-table.id
  private-route-table-id    = data.aws_route_table.private-route-table.id
  vpc-id                    = data.aws_vpc.account-vpc.id
  allocation-id-for-nat-eip = data.aws_eip.nat-eip.id
  public-jenkins-key        = data.aws_key_pair.jenkins-key-pair.key_name
}

module "db" {
  source                  = "./modules/db-instance/"
  env                     = var.env
  ami_name                = var.ami_name
  private-subnets-for-db  = var.private-subnets-for-db
  region                  = var.region
  instance-type           = var.instance-type
  private-subnets-for-web = var.private-subnets-for-web
  availability-zone       = var.availability-zone
  common_tags             = local.common_tags
  ssm_instance_profile_name = module.ssm_ec2_role.instance_profile_name
  #data var block
  vpc-cidr-block         = data.aws_vpc.account-vpc.cidr_block
  public-jenkins-key     = data.aws_key_pair.jenkins-key-pair.key_name
  private-route-table-id = data.aws_route_table.private-route-table.id
  vpc-id                 = data.aws_vpc.account-vpc.id
}

module "web-servers-instances" {
  source                  = "./modules/web-server-instances"
  env                     = var.env
  web_ami_name            = var.web_ami_name
  private-subnets-for-web = var.private-subnets-for-web
  region                  = var.region
  instance-type           = var.instance-type
  availability-zone       = var.availability-zone
  common_tags             = local.common_tags
  #data var block
  vpc-cidr-block         = data.aws_vpc.account-vpc.cidr_block
  public-jenkins-key     = data.aws_key_pair.jenkins-key-pair.key_name
  photosaver_profile     = data.aws_iam_instance_profile.photosaver_profile.name
  private-route-table-id = data.aws_route_table.private-route-table.id
  vpc-id                 = data.aws_vpc.account-vpc.id
}

module "ssm_ec2_role" {
  source      = "./modules/ssm-ec2-role"
  region      = var.region
  env         = var.env
  common_tags = local.common_tags
}