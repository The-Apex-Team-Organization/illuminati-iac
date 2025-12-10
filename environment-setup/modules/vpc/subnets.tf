resource "aws_subnet" "private-us-east-1a" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnet-cidrs[0]
  availability_zone = var.private-subnet-azs[0]

  tags = {
    Name                                   = "private-us-east-1a-${var.env}"
    Project                                = "illuminati"
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/illuminati-eks" = "shared"
  }
}

resource "aws_subnet" "private-us-east-1b" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnet-cidrs[1]
  availability_zone = var.private-subnet-azs[1]

  tags = {
    Name                                   = "private-us-east-1b-${var.env}"
    Project                                = "illuminati"
    "kubernetes.io/role/internal-elb"      = "1"
    "kubernetes.io/cluster/illuminati-eks" = "shared"
  }
}

resource "aws_subnet" "public-us-east-1a" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.public-subnet-cidrs[0]
  availability_zone       = var.public-subnet-azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name                                   = "public-us-east-1a-${var.env}"
    Project                                = "illuminati"
    "kubernetes.io/role/elb"               = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/illuminati-eks" = "shared"
  }
}

resource "aws_subnet" "public-us-east-1b" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.public-subnet-cidrs[1]
  availability_zone       = var.public-subnet-azs[1]
  map_public_ip_on_launch = true

  tags = {
    Name                                   = "public-us-east-1b-${var.env}"
    Project                                = "illuminati"
    "kubernetes.io/role/elb"               = "1" #this instruct the kubernetes to create public load balancer in these subnets
    "kubernetes.io/cluster/illuminati-eks" = "shared"
  }
}
