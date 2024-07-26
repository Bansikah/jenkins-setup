#!/bin/bash

# Create volumes to persist data
echo "Creating Docker volumes for SonarQube..."
docker volume create --name sonarqube_data
docker volume create --name sonarqube_logs
docker volume create --name sonarqube_extensions

# Pull the latest SonarQube image
echo "Pulling the latest SonarQube Docker image..."
docker pull sonarqube:latest

# Run the SonarQube container
echo "Running the SonarQube container..."
docker run --rm -d \
    --name sonarqube \
    -p 9000:9000 \
    -v sonarqube_data:/opt/sonarqube/data \
    -v sonarqube_logs:/opt/sonarqube/logs \
    -v sonarqube_extensions:/opt/sonarqube/extensions \
    sonarqube:latest

# Provide instructions to access SonarQube
echo "SonarQube is now running."
echo "You can access SonarQube at http://localhost:9000"
