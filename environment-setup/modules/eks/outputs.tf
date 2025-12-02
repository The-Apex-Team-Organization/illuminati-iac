output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.illuminati-eks.name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = aws_eks_cluster.illuminati-eks.endpoint
}

output "cluster_id" {
  description = "EKS Cluster ID"
  value       = aws_eks_cluster.illuminati-eks.id
}

output "illuminati-eks-nodes-id" {
  description = "EKS node id"
  value       = aws_eks_node_group.illuminati-eks-nodes.id
}
