resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.illuminati-eks.identity[0].oidc[0].issuer

  depends_on = [aws_eks_cluster.illuminati-eks]
}

resource "aws_iam_role" "ebs_csi_driver_role" {
  name_prefix        = "illuminati-ebs-csi-role-"
  assume_role_policy = data.aws_iam_policy_document.ebs_csi_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "ebs_csi_driver_policy" {
  role       = aws_iam_role.ebs_csi_driver_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
}

resource "aws_eks_addon" "ebs_csi_driver" {
  cluster_name = aws_eks_cluster.illuminati-eks.name
  addon_name   = "aws-ebs-csi-driver"

  service_account_role_arn = aws_iam_role.ebs_csi_driver_role.arn

  depends_on = [
    aws_iam_role_policy_attachment.ebs_csi_driver_policy,
    aws_eks_node_group.illuminati-eks-nodes
  ]
}