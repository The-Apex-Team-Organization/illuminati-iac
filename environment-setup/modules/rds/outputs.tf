
output "db_subnet_group_id" {
  description = "Database security group"
  value       = aws_db_subnet_group.my_db_subnet_group.vpc_id
}


output "db_private_subnets" {
  description = "Private avaliable subnets"
  value = [
    aws_subnet.db_private_subnet_1.id,
    aws_subnet.db_private_subnet_2.id
  ]
}