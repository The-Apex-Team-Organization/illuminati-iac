#Create AWS LB policy


resource "aws_iam_policy" "lbc_policy" {
  name        = "AWSLoadBalancerControllerIAMPolicy"
  description = "Policy for AWS Load Balancer Controller"
  policy      = file("${path.module}/iam-policy-lb.json")
}

data "aws_iam_policy_document" "lbc_pod_identity_trust" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["pods.eks.amazonaws.com"]
    }
    actions = [
      "sts:AssumeRole",
      "sts:TagSession"
    ]
  }
}

resource "aws_iam_role" "lbc_role_pod_id" {
  name               = "eks-lbc-pod-identity-role"
  assume_role_policy = data.aws_iam_policy_document.lbc_pod_identity_trust.json
}

resource "aws_iam_role_policy_attachment" "lbc_attach" {
  role       = aws_iam_role.lbc_role_pod_id.name
  policy_arn = aws_iam_policy.lbc_policy.arn
}

resource "aws_eks_pod_identity_association" "lbc" {
  cluster_name    = aws_eks_cluster.illuminati-eks.name
  namespace       = "kube-system"
  service_account = "aws-load-balancer-controller"
  role_arn        = aws_iam_role.lbc_role_pod_id.arn
  depends_on      = [aws_eks_addon.pod_identity]
}