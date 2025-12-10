

data "aws_route_table" "rtb" {
  vpc_id = data.aws_vpc.account-vpc.id

  tags = {
    Name = "public-route-table-dev-01" 
  }
}

data "aws_eks_cluster" "this" {
  name = var.cluster-name
}

data "aws_eks_cluster_auth" "this" {
  name = var.cluster-name
}