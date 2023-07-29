#!/bin/bash

# Replace these variables with your desired values
INSTANCE_NAME="MyEC2Instance"
INSTANCE_TYPE="t2.micro"
KEY_NAME="apache_httpd"
SECURITY_GROUP_ID="sg-034a679ba1ac363db"
SUBNET_ID="subnet-011dccd6804ba4068"
REGION="us-east-1"  # Replace with your desired region

# User data to install httpd on the instance
USER_DATA="#!/bin/bash
yum update -y
yum install -y httpd
service httpd start
chkconfig httpd on
"

# Launch the EC2 instance
echo "Launching EC2 instance..."
instance_id=$(aws ec2 run-instances \
  --image-id ami-0f9ce67dcf718d332 \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --security-group-ids $SECURITY_GROUP_ID \
  --subnet-id $SUBNET_ID \
  --user-data "$USER_DATA" \
  --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$INSTANCE_NAME}]" \
  --query 'Instances[0].InstanceId' \
  --output text \
  --region $REGION)

# Enable "Auto-assign Public IP" for the instance
echo "Enabling Auto-assign Public IP..."
aws ec2 modify-instance-attribute --instance-id $instance_id --no-source-dest-check --region $REGION

echo "EC2 instance launched successfully."
echo "Instance ID: $instance_id"



