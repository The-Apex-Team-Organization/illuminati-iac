resource "aws_subnet" "private-subnet-prometheus" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnets-for-prometheus
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-prometheus"
  })
}

resource "aws_iam_role" "prometheus-role" {
  name = "prometheus-role-${var.env}"

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

resource "aws_iam_role_policy_attachment" "prometheus-ssm" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess",
    "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  ])
  role       = aws_iam_role.prometheus-role.name
  policy_arn = each.value
}

resource "aws_iam_instance_profile" "prometheus-profile" {
  name = "prometheus-profile"
  role = aws_iam_role.prometheus-role.name
}

resource "aws_security_group" "prometheus-sg" {
  name        = "prometheus-sg"
  description = "Allow Prometheus, Grafana and Node Exporter inbound traffic"
  vpc_id      = var.vpc-id

  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  ingress {
    description = "Node Exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.common_tags, {
    Name = "prometheus-sg"
  })
}

resource "aws_instance" "prometheus-instance" {
  ami                         = var.ami
  associate_public_ip_address = false
  instance_type               = var.instance-type
  subnet_id                   = aws_subnet.private-subnet-prometheus.id
  iam_instance_profile        = aws_iam_instance_profile.prometheus-profile.name
  vpc_security_group_ids      = [aws_security_group.prometheus-sg.id]
  tags = merge(var.common_tags, {
    Name = "prometheus-instance"
  })
}