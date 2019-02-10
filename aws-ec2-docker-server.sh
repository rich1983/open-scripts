#!/bin/bash

SERVER_NAME=$(cat /etc/aws.ec2.instance.name)
DOCKER_IMAGE_FULL_NAME=280666639932.dkr.ecr.us-west-2.amazonaws.com/iadea.service.$((cat /etc/aws.ec2.instance.name) | tr '[:upper:]' '[:lower:]' | awk 'BEGIN {FS="_"}; {print $1}').v1:latest

REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)
REGION=${REGION:0:-1}

source <(curl -s https://zeus.1adea.com/api/iCare.safeServer.awsKey?region=${REGION})

yum install -y docker
service docker start
systemctl enable docker
aws ecr get-login --no-include-email | sh

docker pull $DOCKER_IMAGE_FULL_NAME