# AWS Region
variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-west-2"
}

# AMI ID for EC2 instances
variable "ami_id" {
  description = "AMI ID to use for EC2 instances."
  type        = string
}

# EC2 Instance Type
variable "instance_type" {
  description = "The instance type to use for EC2 instances."
  type        = string
  default     = "t2.micro"
}

# EC2 Key Pair Name
variable "key_pair_name" {
  description = "The name of the EC2 key pair."
  type        = string
}

# VPC CIDR Block
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

# Subnet CIDR Block
variable "subnet_cidr_block" {
  description = "CIDR block for the subnet within the VPC."
  type        = string
}

# Security Group Rule: Allowed SSH CIDR
variable "allowed_ssh_cidr" {
  description = "CIDR block that is allowed SSH access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Security Group Rule: Allowed HTTP CIDR
variable "allowed_http_cidr" {
  description = "CIDR block that is allowed HTTP access."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

# Security Group Open Ports
variable "allowed_ports" {
  description = "List of ports to allow in the security group."
  type        = list(number)
  default     = [22, 8080]
}

# Storage size for EC2 instance
variable "storage_size" {
  description = "The storage size (in GB) for the EC2 instance."
  type        = number
  default     = 15
}
