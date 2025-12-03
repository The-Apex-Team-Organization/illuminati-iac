data "aws_eks_cluster" "illuminati_eks" {
  name = var.cluster-name
}

data "aws_subnets" "private_subnets" {
  filter {
    name   = "tag:Name"
    values = ["private-us-east-1a-${var.env}", "private-us-east-1b-${var.env}"]
  }
}

data "aws_eks_cluster_auth" "illuminati_eks" {
  name = var.cluster-name
}