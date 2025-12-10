resource "aws_iam_role" "illuminati-eks-node-role" {
  name = "illuminati-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })

  tags = {
    Name = "illuminati-eks-node-role"
  }
}

# Required Policies for Worker Nodes
resource "aws_iam_role_policy_attachment" "illuminati-eks-AmazonEKSWorkerNodePolicy" {
  role       = aws_iam_role.illuminati-eks-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "illuminati-eks-AmazonEKS_CNI_Policy" {
  role       = aws_iam_role.illuminati-eks-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "illuminati-eks-AmazonEC2ContainerRegistryReadOnly" {
  role       = aws_iam_role.illuminati-eks-node-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}


resource "aws_eks_node_group" "illuminati-eks-nodes" {
  cluster_name    = aws_eks_cluster.illuminati-eks.name
  node_group_name = "illuminati-node-group-${var.env}"
  node_role_arn   = aws_iam_role.illuminati-eks-node-role.arn
  subnet_ids      = var.subnet_ids_private

  instance_types = ["c7i-flex.large"]
  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  disk_size = 20


  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.illuminati-eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.illuminati-eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.illuminati-eks-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "illuminati-eks-nodes-${var.env}"
  }
}