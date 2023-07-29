#!/bin/bash

# Replace these variables with your desired values
VPC_NAME="MyVPC"
VPC_CIDR_BLOCK="10.0.0.0/16"
REGION="us-east-1"  # Replace with your desired region

# Create VPC
echo "Creating VPC..."
vpc_id=$(aws ec2 create-vpc --cidr-block $VPC_CIDR_BLOCK --query 'Vpc.VpcId' --output text --region $REGION)
aws ec2 create-tags --resources $vpc_id --tags Key=Name,Value=$VPC_NAME --region $REGION

echo "VPC created successfully."
echo "VPC ID: $vpc_id"


