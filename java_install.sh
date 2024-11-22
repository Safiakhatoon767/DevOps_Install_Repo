#!/bin/bash

# Update system packages
echo "Updating system packages..."
sudo apt update -y

# Check if Java is already installed
if java -version &> /dev/null; then
    echo "Java is already installed!"
    java -version
    exit 0
fi

# Install OpenJDK 11
echo "Installing OpenJDK 11..."
sudo apt install -y openjdk-11-jdk

# Verify the installation
echo "Verifying Java installation..."
if java -version &> /dev/null; then
    echo "Java installed successfully!"
    java -version
else
    echo "Java installation failed. Please check for errors."
    exit 1
fi

# Set JAVA_HOME environment variable
echo "Setting JAVA_HOME environment variable..."
JAVA_PATH=$(dirname $(dirname $(readlink -f $(which java))))
echo "export JAVA_HOME=$JAVA_PATH" | sudo tee -a /etc/profile
echo "export PATH=\$JAVA_HOME/bin:\$PATH" | sudo tee -a /etc/profile
source /etc/profile

# Confirm JAVA_HOME
echo "JAVA_HOME is set to: $JAVA_HOME"
