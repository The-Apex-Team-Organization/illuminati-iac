output "vpc-id" {
  value = aws_vpc.illuminati-vpc.id
}

output "vpc-cidr-block" {
  value = aws_vpc.illuminati-vpc.cidr_block
}