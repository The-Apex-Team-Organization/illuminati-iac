resource "aws_eks_node_group" "example_node_group" {
  cluster_name    = var.cluster-name
  node_group_name = "argocd-consul-node-group-${var.env}"
  node_role_arn   = aws_iam_role.eks_node_group_role.arn
  subnet_ids      = var.private-subnet-ids
  instance_types  = ["t3.medium"]

  scaling_config {
    desired_size = 3 # it needs for consul the best availability
    min_size     = 3
    max_size     = 4
  }
  tags = {
    Name        = "argocd-consul-node-group-${var.env}"
    Project     = "illuminati"
    Environment = var.env
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_group_worker_node_policy,
    aws_iam_role_policy_attachment.eks_node_group_cni_policy,
    aws_iam_role_policy_attachment.eks_node_group_ecr_policy,
  ]

}