data "aws_vpc" "account-vpc" {
  tags = {
    Name = "illuminati"
  }
}

data "tls_certificate" "eks" {
  url = aws_eks_cluster.illuminati-eks.identity[0].oidc[0].issuer
}

data "aws_iam_policy_document" "ebs_csi_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRoleWithWebIdentity"]

    principals {
      type = "Federated"
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
    }

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
    }
  }
}
