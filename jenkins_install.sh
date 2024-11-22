#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update -y

# Install required dependencies and Java
echo "Installing Java and required dependencies..."
sudo apt install -y fontconfig openjdk-17-jre

# Verify Java installation
echo "Verifying Java installation..."
java -version

# Add Jenkins key and repository
echo "Adding Jenkins key and repository..."
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update package list again
echo "Updating package list..."
sudo apt-get update -y

# Install Jenkins
echo "Installing Jenkins..."
sudo apt-get install -y jenkins

# Start and enable Jenkins service
echo "Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

# Verify Jenkins service status
echo "Checking Jenkins service status..."
sudo systemctl status jenkins

# Display initial admin password
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
    echo "Jenkins initial admin password:"
    sudo cat /var/lib/jenkins/secrets/initialAdminPassword
else
    echo "Jenkins service may not have started correctly. Check logs with: sudo journalctl -xeu jenkins.service"
fi

echo "Jenkins installation script execution completed."
