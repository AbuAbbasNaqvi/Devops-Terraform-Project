# Output the VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = data.aws_vpc.existing.id
}

# Output the Subnet ID
output "subnet_id" {
  description = "The ID of the created subnet"
  value       = aws_subnet.main.id
}

# Output the Security Group ID
output "security_group_id" {
  description = "The ID of the created security group"
  value       = aws_security_group.main.id
}

# Output the Jenkins Master EC2 Instance ID
output "jenkins_master_instance_id" {
  description = "The ID of the Jenkins master EC2 instance"
  value       = aws_instance.jenkins_master.id
}

# Output the Jenkins Agent EC2 Instance ID
output "jenkins_agent_instance_id" {
  description = "The ID of the Jenkins agent EC2 instance"
  value       = aws_instance.jenkins_agent.id
}

# Output the SonarQube EC2 Instance ID
output "sonarqube_instance_id" {
  description = "The ID of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube.id
}

# Output the Public IP of the Jenkins Master EC2 Instance
output "jenkins_master_public_ip" {
  description = "The public IP of the Jenkins master EC2 instance"
  value       = aws_instance.jenkins_master.public_ip
}

# Output the Public IP of the Jenkins Agent EC2 Instance
output "jenkins_agent_public_ip" {
  description = "The public IP of the Jenkins agent EC2 instance"
  value       = aws_instance.jenkins_agent.public_ip
}

# Output the Public IP of the SonarQube EC2 Instance
output "sonarqube_public_ip" {
  description = "The public IP of the SonarQube EC2 instance"
  value       = aws_instance.sonarqube.public_ip
}
