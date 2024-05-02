# Project Deployment Documentation

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
