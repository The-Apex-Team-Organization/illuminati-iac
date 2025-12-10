env                       = "dev-01"
region                    = "us-east-1"
availability-zone         = "us-east-1a"
public-subnet-for-jenkins = "10.0.5.0/24"
cluster-name              = "illuminati-eks"
kubernetes-version        = "1.33"
private-subnet-cidrs      = ["10.0.6.0/24", "10.0.7.0/24"]
public-subnet-cidrs       = ["10.0.8.0/24", "10.0.9.0/24"]
private-subnet-azs        = ["us-east-1a", "us-east-1b"]
public-subnet-azs         = ["us-east-1a", "us-east-1b"]

domain-name = "buymeadoor.pp.ua"



db_availability_zone_1 = "us-east-1a"
db_availability_zone_2 = "us-east-1b"
private_cluster_cidr_block_1 = "10.0.12.0/24"
private_cluster_cidr_block_2 = "10.0.13.0/24"


db_private_subnet_1 = "10.0.16.0/24"
db_private_subnet_2 = "10.0.17.0/24"

