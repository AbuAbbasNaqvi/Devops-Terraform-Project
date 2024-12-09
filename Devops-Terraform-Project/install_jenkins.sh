#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update -y
sudo apt upgrade -y

# Install OpenJDK 17
echo "Installing OpenJDK 17..."
sudo apt install openjdk-17-jdk -y

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Add Jenkins repository and its key
echo "Adding Jenkins repository and its key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update apt and install Jenkins
echo "Installing Jenkins..."
sudo apt update
sudo apt install jenkins -y

# Enable and start Jenkins service
echo "Enabling and starting Jenkins..."
sudo systemctl enable jenkins
sudo systemctl start jenkins

# Print Jenkins status
echo "Verifying Jenkins installation..."
sudo systemctl status jenkins

echo "Jenkins installation complete!"
