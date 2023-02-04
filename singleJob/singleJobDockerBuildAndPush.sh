#!/bin/bash

# set environment variables
AWS_ACCOUNT_ID=`aws sts get-caller-identity | jq -r '.Account'` # or replace by your account ID
export AWS_REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region) # or replace by your region
ECR_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"

# Authenticate with ECR
aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_URL}

# Build the image
docker build -f ./Dockerfile -t aws-batch-workshop/singlejob:latest .

# Tag the image
docker tag aws-batch-workshop/singlejob:latest ${ECR_URL}/aws-batch-workshop/singlejob:latest

# Push your image to your ECR repository
docker push ${ECR_URL}/aws-batch-workshop/singlejob:latest