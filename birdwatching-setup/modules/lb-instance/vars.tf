variable "ami_name" {
  description = "The port the server will use for HTTP requests"
  type        = string
}

variable "common_tags" {
  type = map(string)
}

variable "vpc-id" {
  description = "The VPC ID where subnet will be created"
  type        = string
}

variable "vpc-cidr-block" {
  description = "The VPC cidr block for security rules"
  type        = string
}

variable "env" {
  description = "Specifies the target environment (e.g., dev, stage, prod) for resource provisioning"
  type        = string
}

variable "region" {
  description = "The region to create the resources in"
  type        = string
}

variable "public-subnets-for-lb" {
  description = "CIDR block for lb-subnet"
  type        = string
}

variable "private-route-table-id" {
  description = "ID of the private route table, we're gonna use it here to configure routing for our private instances"
  type        = string
}

variable "public-route-table-id" {
  description = "ID of the public route table that will be associated with the private lb-instances subnet"
  type        = string
}

variable "availability-zone" {
  description = "Availability zone for subnets"
  type        = string
}

variable "allocation-id-for-nat-eip" {
  description = "This ID belongs to the IP that will be assigned to the NAT gateway"
  type        = string
}

variable "public-jenkins-key" {
  description = "SSH Key Pair name"
  type        = string
}

variable "instance-type" {
  description = "default instance type for our project"
  type        = string
}

variable "dns-name" {
  description = "domain name for our app"
  type        = string
}

variable "ssm_instance_profile_name" {
  description = "Profile name for ec2 instances"
  type = string
}