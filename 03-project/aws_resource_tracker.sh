#!/bin/bash

###############################################################################
# Author: Sachin Rajguru
# Version: v0.0.1
# Date: 2024-01-11
#
# Script Purpose: Automate AWS resource usage tracking for cost optimization
# Usage: Generates daily reports for manager/reporting dashboard
#
# Supported Services:
# 1. EC2        6. IAM              11. SNS
# 2. RDS        7. Route53          12. SQS
# 3. S3         8. CloudWatch       13. DynamoDB
# 4. CloudFront 9. CloudFormation   14. EBS
# 5. VPC        10. Lambda
###############################################################################

# Input Validation: Check if exactly 2 arguments provided
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_tracker.sh <aws_region> <aws_service>"
    echo "Example: ./aws_resource_tracker.sh us-east-1 ec2"
    exit 1
fi

# Assign arguments to variables
aws_region=$1
aws_service=$(echo $2 | tr '[:upper:]' '[:lower:]')  # Convert to lowercase

# Prerequisite Check 1: AWS CLI installed?
if ! command -v aws &> /dev/null; then
    echo "✗ AWS CLI is not installed. Install with: sudo apt install awscli"
    exit 1
fi

# Prerequisite Check 2: AWS CLI configured?
if [ ! -d ~/.aws ]; then
    echo "✗ AWS CLI not configured. Run: aws configure"
    exit 1
fi

# Debug Mode: Print each command before execution
set -x

# Service-specific resource listing
case $aws_service in
    ec2)
        echo "▣ Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region \
            | jq '.Reservations[].Instances[].InstanceId'
        ;;
    rds)
        echo "▣ Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region \
            | jq '.DBInstances[].DBInstanceIdentifier'
        ;;
    s3)
        echo "▣ Listing S3 Buckets (Global)"
        aws s3api list-buckets --region $aws_region \
            | jq -r '.Buckets[].Name'
        ;;
    cloudfront)
        echo "▣ Listing CloudFront Distributions"
        aws cloudfront list-distributions --region $aws_region \
            | jq '.DistributionList.Items[].Id'
        ;;
    vpc)
        echo "▣ Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region \
            | jq '.Vpcs[].VpcId'
        ;;
    iam)
        echo "▣ Listing IAM Users (Global)"
        aws iam list-users \
            | jq -r '.Users[].UserName'
        ;;
    route53)
        echo "▣ Listing Route53 Hosted Zones"
        aws route53 list-hosted-zones \
            | jq -r '.HostedZones[].Name'
        ;;
    cloudwatch)
        echo "▣ Listing CloudWatch Alarms"
        aws cloudwatch describe-alarms --region $aws_region \
            | jq -r '.CompositeAlarms[].AlarmName, .MetricAlarms[].AlarmName'
        ;;
    cloudformation)
        echo "▣ Listing CloudFormation Stacks"
        aws cloudformation describe-stacks --region $aws_region \
            | jq -r '.Stacks[].StackName'
        ;;
    lambda)
        echo "▣ Listing Lambda Functions"
        aws lambda list-functions --region $aws_region \
            | jq -r '.Functions[].FunctionName'
        ;;
    sns)
        echo "▣ Listing SNS Topics"
        aws sns list-topics --region $aws_region \
            | jq -r '.Topics[].TopicArn'
        ;;
    sqs)
        echo "▣ Listing SQS Queues"
        aws sqs list-queues --region $aws_region \
            | jq -r '.QueueUrls[]'
        ;;
    dynamodb)
        echo "▣ Listing DynamoDB Tables"
        aws dynamodb list-tables --region $aws_region \
            | jq -r '.TableNames[]'
        ;;
    ebs)
        echo "▣ Listing EBS Volumes"
        aws ec2 describe-volumes --region $aws_region \
            | jq -r '.Volumes[].VolumeId'
        ;;
    *)
        echo "✗ Invalid service: $aws_service"
        echo "Supported: ec2 rds s3 cloudfront vpc iam route53 cloudwatch cloudformation lambda sns sqs dynamodb ebs"
        exit 1
        ;;
esac

# Disable debug mode
set +x
