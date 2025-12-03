variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "ami_name" {
  description = "The port the server will use for HTTP requests"
  type        = string
}

variable "web_ami_name" {
  description = "The port the server will use for HTTP requests"
  type        = string
}

variable "public-subnets-for-lb" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "private-subnets-for-db" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "private-subnets-for-web" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "instance-type" {
  description = "default instance type for our project"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "dns-name" {
  description = "domain name for our app"
  type        = string
}

#DATA CODE BLOCK
data "aws_route_table" "private-route-table" {
  tags = {
    Name = "private-route-table-${var.env}"
  }
}

data "aws_route_table" "public-route-table" {
  tags = {
    Name = "public-route-table-${var.env}"
  }
}

data "aws_iam_instance_profile" "photosaver_profile" {
  name = "photosaver-profile"
}

data "aws_eip" "nat-eip" {
  tags = {
    Name = "nat-eip-${var.env}"
  }
}

data "aws_key_pair" "jenkins-key-pair" {
  key_name = "jenkins-public"
}

data "aws_vpc" "account-vpc" {
  tags = {
    Name = "BirdwatchingProject"
  }
}
