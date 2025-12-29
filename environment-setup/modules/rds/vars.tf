
variable "cluster-name" {
  description = "EKS cluster name"
  type        = string
}

variable "private_cluster_cidr_block_1" {
  description = "Subnet of eks nodes"
  type        = string
}

variable "private_cluster_cidr_block_2" {
  description = "Subnet of eks nodes"
  type        = string
}


variable "db_username" {
  description = "Master username for RDS DB"
  type        = string
}

variable "db_password" {
  description = "Master password for RDS DB"
  type        = string
}


variable "vpc_id" {
  description = "VPC id for deployment"
  type        = string  
}

variable "public_route_table_id" {
  description = "Public route table for NAT & ELB"
  type        = string
}

variable "db_private_subnet_1" {
  description = "Private subnet for RDS"
  type        = string
}

variable "db_private_subnet_2" {
  description = "Private subnet for RDS"
  type        = string
}

variable "db_availability_zone_1" {
  description = "First availability zone"
  type        = string
}

variable "db_availability_zone_2" {
  description = "Second availability zone"
  type        = string
}