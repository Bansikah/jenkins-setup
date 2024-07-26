#!/bin/bash

# Set up the network if it doesn't exist
docker network create jenkins || true

# Run Docker-in-Docker container
docker run --name jenkins-docker --rm --detach \
  --privileged --network jenkins --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind --storage-driver overlay2

# Run Jenkins container
docker run --name jenkins --restart=on-failure --detach \
  --network jenkins --publish 8081:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  jenkins/jenkins:lts

echo "Jenkins is now running at http://localhost:8081"
