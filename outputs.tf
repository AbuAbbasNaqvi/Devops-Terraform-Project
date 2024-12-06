output "jenkins_master_public_ip" {
  description = "Public IP address of the Jenkins Master instance"
  value       = aws_instance.jenkins_master.public_ip
}

output "jenkins_master_instance_id" {
  description = "Instance ID of the Jenkins Master instance"
  value       = aws_instance.jenkins_master.id
}

output "jenkins_agent_public_ip" {
  description = "Public IP address of the Jenkins Agent instance"
  value       = aws_instance.jenkins_agent.public_ip
}

output "jenkins_agent_instance_id" {
  description = "Instance ID of the Jenkins Agent instance"
  value       = aws_instance.jenkins_agent.id
}

output "sonarqube_public_ip" {
  description = "Public IP address of the SonarQube instance"
  value       = aws_instance.sonarqube.public_ip
}

output "sonarqube_instance_id" {
  description = "Instance ID of the SonarQube instance"
  value       = aws_instance.sonarqube.id
}

output "instances_details" {
  description = "Details of all instances"
  value = {
    jenkins_master = {
      public_ip   = aws_instance.jenkins_master.public_ip
      instance_id = aws_instance.jenkins_master.id
    }
    jenkins_agent = {
      public_ip   = aws_instance.jenkins_agent.public_ip
      instance_id = aws_instance.jenkins_agent.id
    }
    sonarqube = {
      public_ip   = aws_instance.sonarqube.public_ip
      instance_id = aws_instance.sonarqube.id
    }
  }
}
