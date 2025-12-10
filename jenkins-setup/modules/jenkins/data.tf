data "aws_route_table" "private-route-table" {
  tags = {
    Name = "private-route-table-${var.env}"
  }
}

