#!/bin/bash

# Install sudo if not already installed
if ! command -v sudo &> /dev/null; then
  apt-get update
  apt-get install -y sudo
fi

# Update package index
sudo apt-get update

# Install required packages
sudo apt-get install -y ca-certificates curl

# Create the keyrings directory if it does not exist
sudo install -m 0755 -d /etc/apt/keyrings

# Download Docker's GPG key
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc

# Set proper permissions for the key
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the Docker repository to APT sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo \"$VERSION_CODENAME\") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package index again
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
# Prompt for Docker Compose installation
read -p "Möchten Sie Docker Compose installieren? (j/n): " install_compose
if [[ "$install_compose" == "j" || "$install_compose" == "J" ]]; then
  sudo apt-get install -y docker-compose-plugin
  echo -e "\033[32mDocker Compose wurde installiert.\033[0m"
else
  echo "Docker Compose wurde nicht installiert."
fi

# Final message in green
echo -e "\033[32mDocker wurde erfolgreich installiert!\033[0m"
