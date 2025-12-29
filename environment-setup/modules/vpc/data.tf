data "aws_subnet" "private-subnet-prometheus" {
  tags = {
    Name = "private-${var.availability-zone}-prometheus"
  }
}