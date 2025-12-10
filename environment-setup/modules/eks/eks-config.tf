resource "aws_iam_role" "illuminati-eks-iam-role" {
  name = "illuminati-eks-cluster-iam-role"
  tags = {
    tag-key = "illuminati-eks-cluster-iam-role"
  }

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": [
                    "eks.amazonaws.com"
                ]
            },
            "Action": "sts:AssumeRole"
        }
    ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "illuminati-eks-AmazonEKSClusterPolicy" {
  role       = aws_iam_role.illuminati-eks-iam-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# bare minimum requirement of eks

resource "aws_eks_cluster" "illuminati-eks" {
  name     = "illuminati-eks"
  role_arn = aws_iam_role.illuminati-eks-iam-role.arn

  version = 1.33

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true

    subnet_ids = var.subnet_ids
  }

  depends_on = [aws_iam_role_policy_attachment.illuminati-eks-AmazonEKSClusterPolicy]
}
