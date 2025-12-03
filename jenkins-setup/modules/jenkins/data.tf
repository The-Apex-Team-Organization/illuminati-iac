data "aws_route_table" "private-route-table" {
  tags = {
    name = "private-route-table-${var.env}"
  }
}

data "aws_subnet" "jenkins-subnet" {
  tags = {
    Name = "private-${var.availability-zone}-jenkins"
  }
}
