# Project Lucid Deployment Documentation

## Overview

This project includes a comprehensive setup for a web application using Docker, Terraform, and Jenkins. This guide covers the techniques and technologies implemented to create a scalable and maintainable deployment pipeline.

## Technologies Used

- **Docker**: Utilized for containerizing the web application, ensuring consistency across different environments.
- **Terraform**: Employed for infrastructure as code to provision and manage AWS cloud resources dynamically and efficiently.
- **Jenkins**: Configured for continuous integration and continuous deployment (CI/CD), automating the build, test, and deployment processes.

## Docker Setup

### Dockerfile

The Dockerfile is crafted to set up an Nginx server that serves our static website. It incorporates ImageMagick for image optimization to enhance performance by reducing image file sizes during the build process.

```Dockerfile
FROM nginx:alpine
RUN apk add --no-cache imagemagick
WORKDIR /usr/share/nginx/html
COPY . .
RUN find . -type f \( -iname \*.jpg -o -iname \*.png \) -exec convert "{}" -strip -quality 85 "{}" \;

## Jenkins for CI/CD

The Jenkinsfile is configured to automate the deployment process, linking with GitHub for continuous integration. It includes stages for building the Docker image, pushing it to ECR, and deploying the infrastructure with Terraform.

## Docker-compose and Jenkins for DEVs

 **`jenkins.Dockerfile`**: Defines the Docker configuration for setting up a Jenkins server pre-configured with necessary plugins and settings.
- **`docker-compose.yaml`**: Manages multi-container Docker applications, specifying services, networks, and volumes for our project.

## Jenkins Configuration

### Dockerfile for Jenkins

The `jenkins.Dockerfile` sets up a Jenkins server tailored to our project's needs. It includes:

- Installation of the base Jenkins image.
- Installation of pre-determined plugins necessary for our CI/CD pipeline.
- Custom configurations to optimize build performance and security settings.

### Building the Jenkins Docker Image

```bash
docker build -t custom-jenkins -f jenkins.Dockerfile .

The docker-compose.yaml file is configured to orchestrate multiple containers that make up our development environment, including databases, backend services, and other dependencies.

To start all services defined in the docker-compose.yaml file: docker-compose up -d

