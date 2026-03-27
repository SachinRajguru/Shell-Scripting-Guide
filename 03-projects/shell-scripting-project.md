
# **AWS Resource Tracker Shell Script**

## ** Table of Contents**
1. [Why Cloud Migration?](#why-cloud-migration)
2. [Core DevOps Responsibility: Cost Optimization](#cost-optimization)
3. [Project Overview](#project-overview)
4. [Cron Job Automation](#cron-job-automation)
5. [Prerequisites & Setup](#prerequisites)
6. [Complete Script with Code Walkthrough](#complete-script)
7. [Step-by-Step Script Development](#step-by-step)
8. [JQ Command Mastery](#jq-mastery)
9. [Cron Job Integration](#cron-integration)
10. [Interview Questions & Answers](#interview-qa)
11. [Hands-on Lab Exercises](#lab-exercises)
12. [Advanced Improvements](#advanced)

---

## ** Why Cloud Migration?** {#why-cloud-migration}

### **Definition**
**Cloud Migration** = Moving on-premises infrastructure to cloud providers (AWS, Azure, GCP).

### **Primary Reasons for Cloud Migration**
| **Reason** | **On-Premise Problem** | **Cloud Solution** |
|------------|----------------------|-------------------|
| **Maintenance Overhead** | Build data centers, patch servers, security updates, dedicated sysadmin team | Cloud provider handles OS patching, hardware maintenance |
| **Cost Efficiency** | Pay for servers whether used or not | **Pay-as-you-go** model - pay only for what you use |

### **Real-World Scenario**
```
Company: example.com (100 developers)
Problem: Developers create 100 EC2 instances + unused EBS volumes
Result: Monthly AWS bill skyrockets despite low usage
DevOps Solution: Daily resource usage reports
```

**Analogy**: Like paying rent for an apartment you never visit vs. hotel - pay only when you stay!

---

## ** Core DevOps Responsibility: Cost Optimization** {#cost-optimization}

### **Definition**
**Resource Usage Tracking** = Monitoring AWS resources to ensure cost-effectiveness.

### **Common Wasteful Resources**
```
1. EC2 instances (running but unused)
2. EBS volumes (created but unattached)
3. S3 buckets (empty but billing storage)
4. Lambda functions (deployed but never invoked)
```

### **DevOps Engineer's Daily Task**
```
2 AM: Generate resource usage report → Send to manager/reporting dashboard
```

---

## ** Project Overview** {#project-overview}

### **Project Name**: `aws_resource_tracker.sh`
**Purpose**: Automate AWS resource inventory for cost monitoring

### **Supported AWS Services**
```
1. EC2 Instances
2. RDS Instances  
3. S3 Buckets
4. CloudFront Distributions
5. VPCs
6. IAM Users
7. Route53 Hosted Zones
8. CloudWatch Alarms
9. CloudFormation Stacks
10. Lambda Functions
11. SNS Topics
12. SQS Queues
13. DynamoDB Tables
14. EBS Volumes
```

### **Usage**
```bash
./aws_resource_tracker.sh <aws_region> <aws_service>
Example: ./aws_resource_tracker.sh us-east-1 ec2
```

---

## ** Cron Job Automation** {#cron-job-automation}

### **Definition**
**Cron Job** = Linux scheduler that automatically executes scripts at specified times.

### **Analogy**
```
YouTube Video Publishing:
- Upload video at 2 AM
- Schedule publish for 3 AM
- YouTube automatically publishes at 3 AM

Cron Job:
- Write script at 2 AM 
- Schedule execution for 2 AM daily
- Cron automatically runs script daily
```

### **Cron Job Format**
```
# Edit crontab: crontab -e
0 2 * * * /path/to/aws_resource_tracker.sh us-east-1 all > /tmp/resource_report.txt
```
**Meaning**: Run at 2:00 AM every day

---

## ** Prerequisites & Setup** {#prerequisites}

### **1. AWS CLI Installation & Configuration**
```bash
# Install AWS CLI (Ubuntu)
sudo apt update && sudo apt install awscli -y

# Configure AWS CLI
aws configure
# Enter: Access Key, Secret Key, Region (us-east-1), Output (json)
```

### **2. JQ Installation (JSON Parser)**
```bash
sudo apt install jq -y
```

### **3. Bash Shell (Recommended)**
```bash
#!/bin/bash  # vs  #!/bin/sh (sh might be dash)
```

**Why Bash over SH?**
```
SH = Symbolic link (might be bash OR dash)
Bash = Consistent syntax across Linux distributions
```

---

## ** Complete Script with Code Walkthrough** {#complete-script}

```bash
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
```

---

## ** Step-by-Step Script Development** {#step-by-step}

### **Step 1: Basic Script Structure**
```bash
#!/bin/bash
# Author comments + purpose

# List resources (initial version - verbose output)
aws s3 ls                    # Lists ALL S3 bucket details
aws ec2 describe-instances   # Lists ALL EC2 details  
aws lambda list-functions    # Lists ALL Lambda details
aws iam list-users           # Lists ALL IAM users
```

**Problem**: Output too verbose → Manager can't quickly identify resources

### **Step 2: Add User-Friendly Echo Statements**
```bash
echo "▣ Print list of S3 buckets"
aws s3 ls

echo "▣ Print list of EC2 instances"  
aws ec2 describe-instances
```

### **Step 3: Enable Debug Mode**
```bash
set -x  # Prints each command + output (like --verbose)
# Script runs...
set +x  # Disable debug
```

**Sample Debug Output**:
```
+ echo ▣ Print list of S3 buckets
+ aws s3 ls
2024-01-11  penguin-flew-away/
```

### **Step 4: File Output Redirection**
```bash
# Redirect ALL output to file
./aws_resource_tracker.sh us-east-1 ec2 > resource_report.txt

# View report
cat resource_report.txt | more
```

---

## ** JQ Command Mastery** {#jq-mastery}

### **Definition**
**JQ** = Command-line JSON processor (like `grep` + `awk` for JSON)

**Install**: `sudo apt install jq -y`

### **JSON Parsing Walkthrough**
**Raw AWS Output** (too verbose):
```json
{
  "Reservations": [
    {
      "Instances": [
        {
          "InstanceId": "i-1234567890abcdef0",
          "State": {"Name": "running"},
          ...
        }
      ]
    }
  ]
}
```

**JQ Filters** (step-by-step):
```bash
# Step 1: Get Reservations array
| jq '.Reservations[]'

# Step 2: Get Instances array  
| jq '.Reservations[].Instances[]'

# Step 3: Extract InstanceId only
| jq '.Reservations[].Instances[].InstanceId'

# Final command (clean output)
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'
```

**Output**:
```
i-1234567890abcdef0
i-0987654321fedcba0
```

### **Common JQ Patterns**
```bash
# -r = raw output (no quotes)
jq -r '.FieldName'

# Array iteration
jq -r '.ArrayName[]'

# Nested arrays
jq -r '.Parent[].Child[].Grandchild'

# Multiple fields
jq -r '.Name, .Id'
```

**Analogy**: JQ = Swiss Army knife for JSON (cut exactly what you need)

---

## ** Cron Job Integration** {#cron-integration}

### **Lab: Schedule Daily Report**
```bash
# 1. Make script executable
chmod 755 aws_resource_tracker.sh

# 2. Edit crontab
crontab -e

# 3. Add this line (runs 2 AM daily)
0 2 * * * /home/ubuntu/aws_resource_tracker.sh us-east-1 ec2 >> /home/ubuntu/daily_report.txt 2>&1

# 4. Verify cron job
crontab -l
```

**Cron Format**: `minute hour day month weekday command`

### **Email Reports (Bonus)**
```bash
# Send report via email
0 2 * * * /path/to/script.sh | mail -s "Daily AWS Report" manager@example.com
```

---

## ** Interview Questions & Answers** {#interview-qa}

### **Q1: Why do organizations migrate to cloud?**
**Answer**: 
1. **Reduce maintenance overhead** - No data centers, patching, hardware management
2. **Cost optimization** - Pay-as-you-go vs fixed CapEx
```
Example: 100 devs creating unused EC2/EBS → Daily tracking needed
```

### **Q2: How to schedule daily AWS reports?**
**Answer**: 
```bash
# Use Linux Cron Job
crontab -e
0 2 * * * /path/to/aws_resource_tracker.sh us-east-1 all >> report.txt
```
**Analogy**: Like YouTube auto-publishing scheduled videos.

### **Q3: How to parse AWS CLI JSON output?**
**Answer**:
```bash
# Use JQ (JSON processor)
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'

# Key flags:
# -r = raw output
# [] = iterate arrays
# .Field = select field
```

### **Q4: Difference between `#!/bin/sh` vs `#!/bin/bash`?**
**Answer**:
```
SH = Symbolic link (bash OR dash) → Inconsistent
Bash = Specific shell → Reliable across distros
Use: #!/bin/bash for production scripts
```

### **Q5: How to debug shell scripts?**
**Answer**:
```bash
set -x  # Enable debug (prints each command)
set +x  # Disable debug

# OR run with:
bash -x script.sh
```

---

## ** Hands-on Lab Exercises** {#lab-exercises}

### **Lab 1: Basic Script Test**
```bash
# 1. Create script
nano aws_resource_tracker.sh

# 2. Add basic commands
aws s3 ls
aws ec2 describe-instances

# 3. Test
chmod +x aws_resource_tracker.sh
./aws_resource_tracker.sh
```

### **Lab 2: JQ Mastery**
```bash
# Test EC2 instance IDs only
aws ec2 describe-instances | jq -r '.Reservations[].Instances[].InstanceId'

# Test S3 bucket names only  
aws s3api list-buckets | jq -r '.Buckets[].Name'
```

### **Lab 3: Cron Job Setup**
```bash
# 1. Test every minute (for testing)
* * * * * /path/to/script.sh >> /tmp/test.log

# 2. Check logs
tail -f /tmp/test.log

# 3. Production (2 AM daily)
0 2 * * * /path/to/script.sh >> /home/ubuntu/report.txt
```

### **Lab 4: Complete Automation**
```
1. Write full script with case statement
2. Add input validation
3. Add JQ parsing for all services  
4. Schedule with cron
5. Test output file
```

---

## ** Advanced Improvements** {#advanced}

### **1. Multi-Region Support**
```bash
regions=("us-east-1" "us-west-2" "eu-west-1")
for region in "${regions[@]}"; do
    echo "Scanning $region..."
    aws ec2 describe-instances --region $region | jq ...
done
```

### **2. HTML Report Generation**
```bash
# Convert to HTML table
aws ec2 describe-instances | jq ... > ec2_report.html
```

### **3. Slack/Email Integration**
```bash
# Send to Slack webhook
curl -X POST -H 'Content-type: application/json' \
--data '{"text":"Daily AWS Report"}' \
https://hooks.slack.com/services/xxx
```

### **4. Cost Analysis**
```bash
# Add billing data
aws ce get-cost-and-usage --time-period Start=2024-01-01,End=2024-01-31
```

---

## ** Assignment**
**Task**: Complete the full script and integrate with cron:
1. ✓ Support all 14 services
2. ✓ Add JQ parsing for clean output  
3. ✓ Input validation
4. ✓ Debug mode (`set -x`)
5. ✓ File output redirection
6. ✓ Cron job at 2 AMM daily
7. ✓ Test with `crontab -l`

**Submit**: Screenshot of cron output + sample report file

---

**This project demonstrates**: AWS CLI + Bash + JQ + Cron + DevOps cost optimization mindset! 
