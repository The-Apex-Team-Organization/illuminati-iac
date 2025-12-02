resource "aws_subnet" "private-subnets-for-db" {
  vpc_id            = var.vpc-id
  cidr_block        = var.private-subnets-for-db
  availability_zone = var.availability-zone
  tags = merge(var.common_tags, {
    Name = "private-${var.availability-zone}-db-${var.env}"
  })
}

resource "aws_route_table_association" "private-subnet-association-for-web" {
  subnet_id      = aws_subnet.private-subnets-for-db.id
  route_table_id = var.private-route-table-id
}

resource "aws_ebs_volume" "db-volume" {
  availability_zone = var.availability-zone
  size              = 1
  type              = "gp3"
  encrypted         = true
  tags = merge(var.common_tags, {
    Name = "db-volume-${var.env}"
  })
}

resource "aws_instance" "db" {
  associate_public_ip_address = false
  ami                         = var.ami_name
  instance_type               = var.instance-type
  vpc_security_group_ids      = [aws_security_group.db-security-group.id]
  subnet_id                   = aws_subnet.private-subnets-for-db.id
  key_name                    = var.public-jenkins-key
  iam_instance_profile        = var.ssm_instance_profile_name
  user_data_replace_on_change = true
  tags = merge(var.common_tags, {
    Name = "birdwatching-db-${var.env}"
  })
}

resource "aws_volume_attachment" "generic_data_vol_att" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.db-volume.id
  instance_id = aws_instance.db.id
}

resource "aws_security_group" "db-security-group" {
  vpc_id = var.vpc-id
  name   = "db-security-group-${var.env}"

  ingress {
    from_port = 9100
    to_port   = 9100
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 8300
    to_port   = 8302
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 8301
    to_port   = 8302
    protocol  = "udp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

  ingress {
    from_port = 5432
    to_port   = 5432
    protocol  = "tcp"
    cidr_blocks = [
      var.private-subnets-for-web,
      "${data.aws_subnet.consul-subnet.cidr_block}",
      "${data.aws_subnet.jenkins-subnet.cidr_block}"
    ]
  }

 egress {
  from_port   = 0
  to_port     = 0
  protocol    = -1
  cidr_blocks = ["0.0.0.0/0"]
}
}
