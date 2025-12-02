env                       = "stage-01"
region                    = "us-east-1"
availability-zone         = "us-east-1a"
public-subnet-for-jenkins = "10.0.5.0/24"
cluster-name              = "stage-01-illuminti-eks-cluster"
kubernetes-version        = "1.33"
private-subnet-cidrs      = ["10.0.6.0/24", "10.0.7.0/24"]
public-subnet-cidrs       = ["10.0.8.0/24", "10.0.9.0/24"]
private-subnet-azs        = ["us-east-1a", "us-east-1b"]
public-subnet-azs         = ["us-east-1a", "us-east-1b"]

db_username_base64 = "aWxsdW1pbmF0eQ=="
db_name_base64     = "aWxsdW1pbmF0eQ=="

domain-name = "buymeadoor.pp.ua"