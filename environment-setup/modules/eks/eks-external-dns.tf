resource "aws_iam_policy" "external_dns" {
  name        = "ExternalDNSChanges"
  description = "Allow ExternalDNS to update Route53 records"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "route53:ChangeResourceRecordSets",
          "route53:ListResourceRecordSets"
        ]
        Resource = ["arn:aws:route53:::hostedzone/*"]
      },
      {
        Effect = "Allow"
        Action = [
          "route53:ListHostedZones",
        ]
        Resource = ["*"]
      }
    ]
  })
}

data "aws_iam_policy_document" "external_dns_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = ["sts:AssumeRole", "sts:TagSession"]
  }
}

resource "aws_iam_role" "external_dns" {
  name               = "external-dns-role-k8s"
  assume_role_policy = data.aws_iam_policy_document.external_dns_trust.json
}

resource "aws_iam_role_policy_attachment" "external_dns_attach" {
  role       = aws_iam_role.external_dns.name
  policy_arn = aws_iam_policy.external_dns.arn
}

resource "aws_eks_pod_identity_association" "external_dns" {
  cluster_name    = aws_eks_cluster.illuminati-eks.name
  namespace       = "kube-system"
  service_account = "external-dns-service"
  role_arn        = aws_iam_role.external_dns.arn

  depends_on = [aws_eks_addon.pod_identity]
}