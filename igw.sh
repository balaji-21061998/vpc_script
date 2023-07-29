#!/bin/bash
# Replace these variables with your AWS region and desired IGW name
aws_region="us-east-1"
igw_name="MYIGW"
# Create the Internet Gateway
igw_id=$(aws ec2 create-internet-gateway --region $aws_region --query 'InternetGateway.InternetGatewayId' --output text)
# Tag the Internet Gateway for easier identification
aws ec2 create-tags --region $aws_region --resources $igw_id --tags Key=Name,Value="$igw_name"
echo "Internet Gateway created with ID: $igw_id"
