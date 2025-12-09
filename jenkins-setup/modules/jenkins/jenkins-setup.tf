resource "tls_private_key" "sskeygen-execution" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "jenkins-key-pair" {
  depends_on = [tls_private_key.sskeygen-execution]
  key_name   = "jenkins-public"
  public_key = tls_private_key.sskeygen-execution.public_key_openssh
}


data "aws_vpc" "vpc-id" {
  id = var.vpc-id
}

resource "aws_subnet" "private-subnet-jenkins" {
  vpc_id            = data.aws_vpc.vpc-id.id
  cidr_block        = var.private-subnets-for-jenkins
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-jenkins"
  })
}

resource "aws_iam_role" "jenkins-role" {
  name = "jenkins-role-${var.env}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins-ssm" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
}

resource "aws_iam_role_policy" "jenkins-policy-for-deployment" {
  name   = "jenkins-policy-for-deployment"
  policy = file("./modules/jenkins/jenkins-policy.json")
  role   = aws_iam_role.jenkins-role.id
}

resource "aws_iam_role_policy" "jenkins_assume_roles" {
  name = "jenkins-assume-roles-policy"
  role = aws_iam_role.jenkins-role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = "sts:AssumeRole"
        Resource = [
          var.dev_deployment_role_arn,
          var.prod_deployment_role_arn,
          var.stage_deployment_role_arn
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "jenkins-profile" {
  name = "jenkins-profile"
  role = aws_iam_role.jenkins-role.name
}

resource "aws_security_group" "jenkins-security-group" {
  name = "allow-all"

  vpc_id = data.aws_vpc.vpc-id.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_instance" "jenkins-instance" {
  ami                         = var.ami
  instance_type               = "c7i-flex.large"
  associate_public_ip_address = false
  subnet_id                   = aws_subnet.private-subnet-jenkins.id
  vpc_security_group_ids      = [aws_security_group.jenkins-security-group.id]
  iam_instance_profile        = aws_iam_instance_profile.jenkins-profile.name

  key_name = aws_key_pair.jenkins-key-pair.key_name

  user_data = file("./modules/jenkins/install_jenkins.sh")

  tags = merge(var.common_tags, {
    Name = "jenkins-instance"
  })

}

resource "aws_ebs_volume" "jenkins-volume" {
  encrypted         = true
  availability_zone = var.availability-zone
  size              = 1
  type              = "gp3"
  tags = merge(var.common_tags, {
    Name = "jenkins-volume"
  })
}

resource "aws_volume_attachment" "jenkins-volume-attachment" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.jenkins-volume.id
  instance_id = aws_instance.jenkins-instance.id
}

resource "aws_route_table_association" "private-subnet-association-for-jenkins" {
  subnet_id      = aws_subnet.private-subnet-jenkins.id
  route_table_id = data.aws_route_table.private-route-table.id
}

resource "aws_s3_bucket" "ssm_ansible" {
  bucket = "ssm-ansible-bucket-717949299287"
  tags   = local.common_tags
}

resource "aws_s3_bucket_public_access_block" "ssm_ansible" {
  bucket = aws_s3_bucket.ssm_ansible.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "ssm_ansible" {
  bucket = aws_s3_bucket.ssm_ansible.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_iam_policy" "jenkins_ssm_s3" {
  name        = "jenkins-ssm-s3-${var.env}"
  description = "Allow Jenkins to use SSM S3 bucket for ${var.env}"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowBucketMeta"
        Effect = "Allow"
        Action = [
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ]
        Resource = aws_s3_bucket.ssm_ansible.arn
      },
      {
        Sid    = "AllowBucketObjects"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ]
        Resource = "${aws_s3_bucket.ssm_ansible.arn}/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "jenkins_ssm_s3_attach" {
  role       = aws_iam_role.jenkins-role.name
  policy_arn = aws_iam_policy.jenkins_ssm_s3.arn
}