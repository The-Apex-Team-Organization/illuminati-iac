resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc-id

  tags = merge(var.common_tags, {
    Name    = "vpc-IGW-${var.env}"
    Project = "illuminati"
  })
}

resource "aws_subnet" "public-subnet-for-jenkins" {
  vpc_id            = var.vpc-id
  cidr_block        = var.public-subnet-for-jenkins
  availability_zone = var.availability-zone

  tags = merge(var.common_tags, {
    Name = "public-${var.availability-zone}-jenkins"
  })
}

resource "aws_route_table" "public-route-table" {
  vpc_id = var.vpc-id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge(var.common_tags, {
    Name    = "public-route-table-${var.env}"
    Project = "illuminati"
  })
}

# resource "aws_route" "public-route" {
#   route_table_id         = aws_route_table.public-route-table.id
#   destination_cidr_block = "0.0.0.0/0"
#   gateway_id             = aws_internet_gateway.igw.id
# }

resource "aws_route_table_association" "public-subnet-association" {
  subnet_id      = aws_subnet.public-subnet-for-jenkins.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "private-us-east-1a" {
  subnet_id      = aws_subnet.private-us-east-1a.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "private-us-east-1b" {
  subnet_id      = aws_subnet.private-us-east-1b.id
  route_table_id = aws_route_table.private-route-table.id
}

resource "aws_route_table_association" "public-us-east-1a" {
  subnet_id      = aws_subnet.public-us-east-1a.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_route_table_association" "public-us-east-1b" {
  subnet_id      = aws_subnet.public-us-east-1b.id
  route_table_id = aws_route_table.public-route-table.id
}

resource "aws_eip" "nat-eip" {
  domain = "vpc"

  tags = merge(var.common_tags, {
    Name    = "nat-eip-${var.env}"
    Project = "illuminati"
  })
  depends_on = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "nat-for-jenkins-subnet" {
  subnet_id     = aws_subnet.public-subnet-for-jenkins.id
  allocation_id = aws_eip.nat-eip.id

  tags = merge(var.common_tags, {
    Name    = "nat-gateway-${var.env}"
    Project = "illuminati"
  })
  depends_on = [aws_internet_gateway.igw]
}


resource "aws_route_table" "private-route-table" {
  vpc_id = var.vpc-id

  tags = merge(var.common_tags, {
    Name    = "private-route-table-${var.env}"
    Project = "illuminati"
  })
}

resource "aws_route" "private-route-to-nat" {
  route_table_id         = aws_route_table.private-route-table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat-for-jenkins-subnet.id
}

# resource "aws_route_table_association" "private-subnet-association-for-jenkins" {
#   for_each = toset([
#     data.aws_subnet.jenkins-subnet.id,
#   ])
#   subnet_id      = each.value
#   route_table_id = aws_route_table.private-route-table.id
# }
