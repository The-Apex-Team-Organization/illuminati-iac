resource "aws_route53_zone" "main" {
  name = var.dns-name
}

resource "aws_subnet" "public-subnets-for-lb" {
  vpc_id                  = var.vpc-id
  cidr_block              = var.public-subnets-for-lb
  availability_zone       = var.availability-zone
  map_public_ip_on_launch = true
  tags = merge(var.common_tags, {
    Name = "public-${var.availability-zone}-lb-${var.env}"
  })
}

resource "aws_eip" "lb-eip" {
  tags = merge(var.common_tags, {
    Name = "lb-eip-${var.env}"
  })
}

resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = var.allocation-id-for-nat-eip
  subnet_id     = aws_subnet.public-subnets-for-lb.id
  tags = merge(var.common_tags, {
    Name = "nat-gateway-${var.env}"
  })
}

resource "aws_route" "private-nat-route" {
  route_table_id         = var.private-route-table-id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-gateway.id
}

resource "aws_instance" "loadbalancer" {
  associate_public_ip_address = false
  ami                    = var.ami_name
  instance_type          = var.instance-type
  vpc_security_group_ids = [aws_security_group.load-balancer-security-group.id]
  subnet_id              = aws_subnet.public-subnets-for-lb.id
  key_name               = var.public-jenkins-key
  iam_instance_profile   = var.ssm_instance_profile_name

  user_data_replace_on_change = true

  tags = merge(var.common_tags, {
    Name = "birdwatching-loadbalancer-${var.env}"
  })
}

resource "aws_security_group" "load-balancer-security-group" {
  vpc_id = var.vpc-id
  name   = "basic-security-group-${var.env}"

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
    cidr_blocks = ["0.0.0.0/0"]
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

resource "aws_eip_association" "eip-assoc" {
  instance_id   = aws_instance.loadbalancer.id
  allocation_id = aws_eip.lb-eip.id
}

resource "aws_route53_record" "www-a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = var.dns-name
  type    = "A"
  ttl     = "300"
  records = [aws_eip.lb-eip.public_ip]
}

resource "aws_route_table_association" "public-subnet-association-for-lb" {
  subnet_id      = aws_subnet.public-subnets-for-lb.id
  route_table_id = var.public-route-table-id
}
