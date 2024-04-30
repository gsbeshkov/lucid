#!/bin/bash
yum update -y
amazon-linux-extras install docker
service docker start
usermod -a -G docker ec2-user

$(aws ecr get-login --no-include-email --region us-east-1)
docker pull 093276084297.dkr.ecr.us-east-1.amazonaws.com/lucid-repo
docker run -d -p 8080:80 093276084297.dkr.ecr.us-east-1.amazonaws.com/lucid-repo
