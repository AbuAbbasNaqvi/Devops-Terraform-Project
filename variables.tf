# Define key pair and region
variable "key_pair_name" {
  description = "Name of the key pair to use for instances"
  type        = string
}

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  type        = string
}

variable "storage_size" {
  description = "Size of the instance storage in GB"
  type        = number
}

# VPC configuration
variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_block" {
  description = "CIDR block for the subnet"
  type        = string
}

# Security group rules
variable "allowed_ssh_cidr" {
  description = "CIDR blocks allowed to access via SSH"
  type        = list(string)
}

variable "allowed_http_cidr" {
  description = "CIDR blocks allowed to access via HTTP"
  type        = list(string)
}

variable "allowed_ports" {
  description = "List of ports to allow in the security group"
  type        = list(number)
}
