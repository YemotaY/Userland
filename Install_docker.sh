#!/bin/bash

# Docker Installation Script for UserLAnd on Android (Debian/Ubuntu)

# Update package lists
echo "Updating package lists..."
sudo apt update -y

# Install necessary dependencies
echo "Installing dependencies..."
sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key
echo "Adding Docker GPG key..."
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the Docker repository
echo "Adding Docker repository..."
echo "deb [arch=arm64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package lists again
echo "Updating package lists after adding Docker repo..."
sudo apt update -y

# Install Docker
echo "Installing Docker..."
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Enable and start Docker service
echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

# Verify installation
echo "Verifying Docker installation..."
docker --version

# Add user to the docker group
echo "Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "Installation completed. You may need to restart your session for changes to take effect."
