resource "aws_vpc" "illuminati-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = merge(var.common_tags, {
    Name = "illuminati"
  })
}
