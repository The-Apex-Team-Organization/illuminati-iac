resource "aws_subnet" "private-subnets-for-web" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnets-for-web
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-web-${var.env}"
  })
}

resource "aws_route_table_association" "private-subnet-association-for-web" {
  subnet_id      = aws_subnet.private-subnets-for-web.id
  route_table_id = var.private-route-table-id
}

resource "aws_instance" "web" {
  associate_public_ip_address = false
  ami                         = var.web_ami_name
  count                       = 2
  instance_type               = var.instance-type
  vpc_security_group_ids      = [aws_security_group.web-server-security-group.id]
  subnet_id                   = aws_subnet.private-subnets-for-web.id
  key_name                    = var.public-jenkins-key
  user_data_replace_on_change = true
  iam_instance_profile        = var.photosaver_profile

  tags = merge(var.common_tags, {
    Name = "birdwatching-web-${var.env}"
  })
}

resource "aws_security_group" "web-server-security-group" {
  vpc_id = var.vpc-id
  name   = "web-security-group-${var.env}"

  ingress {
  from_port   = 8000
  to_port     = 8000
  protocol    = "tcp"
  cidr_blocks = [var.vpc-cidr-block]
}
  
  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = 8300
    to_port     = 8302
    protocol    = "tcp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  ingress {
    from_port   = 8301
    to_port     = 8302
    protocol    = "udp"
    cidr_blocks = [var.vpc-cidr-block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}
