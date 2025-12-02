env               = "stage-01"
vpc-id            = "vpc-0ff1c205c39ef6fc5" #pass existing value
region            = "us-east-1"
availability-zone = "us-east-1a"

private-subnets-for-jenkins = "10.0.2.0/24"
instance-type               = "t3.micro"
ami                         = "ami-0341d95f75f311023"

dev_deployment_role_arn   = "arn:aws:iam::997221415658:role/dev-01-jenkins-deployment-role"
prod_deployment_role_arn  = "arn:aws:iam::145065858657:role/prod-01-jenkins-deployment-role"
stage_deployment_role_arn = "arn:aws:iam::606207925787:role/stage-01-jenkins-deployment-role"