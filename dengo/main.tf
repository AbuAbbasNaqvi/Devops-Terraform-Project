provider "aws" {
  region = var.region
}

# Reference existing VPC instead of creating a new one
data "aws_vpc" "existing" {
  id = "vpc-041f4f907457ab93c"  # Make sure this VPC ID is correct
}

# Subnet creation
resource "aws_subnet" "main" {
  vpc_id                  = data.aws_vpc.existing.id  # Reference the existing VPC
  cidr_block              = var.subnet_cidr_block
  map_public_ip_on_launch = true
  tags = {
    Name = "MainSubnet"
  }
}

# Security Group
resource "aws_security_group" "main" {
  vpc_id = data.aws_vpc.existing.id  # Reference the existing VPC

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.allowed_ssh_cidr
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = var.allowed_http_cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MainSecurityGroup"
  }
}

# EC2 instance for Jenkins Master
resource "aws_instance" "jenkins_master" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id] 
  associate_public_ip_address = true
  user_data = file("install_jenkins.sh")  # Reference to a script that installs Jenkins
 tags = {
    Name = "Jenkins-Master"
  }
}


# EC2 instance for Jenkins Agent
resource "aws_instance" "jenkins_agent" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  user_data = file("install_sonarqube.sh")  # Reference to a script that installs Jenkins
 tags = {
    Name = "Jenkins-agent"
  }
}

# EC2 instance for SonarQube
resource "aws_instance" "sonarqube" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_pair_name
  subnet_id                   = aws_subnet.main.id
  vpc_security_group_ids      = [aws_security_group.main.id]
  associate_public_ip_address = true
  user_data = file("install_jenkins.sh")  # Reference to a script that installs Jenkins

  tags = {
    Name = "SonarQube"
  }
}