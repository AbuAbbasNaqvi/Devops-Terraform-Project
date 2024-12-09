#!/bin/bash

# Update the system
echo "Updating the system..."
sudo apt update -y
sudo apt upgrade -y

# Change the server hostname to avoid confusion
echo "Changing the server hostname to Jenkins-Master..."
sudo hostnamectl set-hostname Jenkins-Master

# Install OpenJDK 17
echo "Installing OpenJDK 17..."
sudo apt install openjdk-17-jre -y

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Install Docker
echo "Installing Docker..."
sudo apt-get install docker.io -y

# Add the current user to the Docker group
echo "Adding the user to the Docker group..."
sudo usermod -aG docker $USER

# Print Docker version to verify installation
echo "Verifying Docker installation..."
docker --version

echo "Docker and OpenJDK 17 have been successfully installed!"
