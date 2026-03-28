
# Shell Scripting: Practical Guide for DevOps

A structured, hands-on shell scripting guide designed for DevOps engineers, beginners, and automation enthusiasts.

This repository follows a real-world learning approach:

**Basics → Advanced → Projects → Production**

---

## Quick Navigation

* [Basics](./01-basics/)
* [Advanced](./02-advanced/)
* [Projects](./03-projects/)

---

## Repository Structure

```text
Shell-Scripting-Guide/
├── README.md
├── 01-basics/
│   ├── README.md
│   └── shell-scripting-basics.md
├── 02-advanced/
│   ├── README.md
│   └── shell-scripting-advanced.md
└── 03-projects/
    └── 01-aws-resource-tracker/
       ├── README.md
       ├── shell-scripting-project.md
       ├── scripts/
       │   └── aws_resource_tracker.sh
       ├── outputs/
       │   └── .gitkeep
       ├── logs/
       │   └── .gitkeep
       └── utils/
           └── .gitkeep
```

---

## Learning Path

### Phase 1: Basics
**Goal:** Build strong Linux + scripting foundation

* Linux setup (WSL / EC2 / VM)
* Basic commands (`ls`, `touch`, `cat`, `vim`)
* Shebang (`#!/bin/bash`)
* File permissions (`chmod 755`)
* Writing your first script
* Directory navigation
* Simple automation scripts

### Phase 2: Advanced
**Goal:** Write production-ready scripts

* Process management (`ps`, `grep`, `awk`)
* Pipelines and streams (`|`)
* Error handling (`set -e -o pipefail`)
* Debugging (`set -x`)
* Control structures (`if-else`, `for`)
* Signal handling (`trap`)
* Log analysis (`curl`, `wget`)
* Node health monitoring script

### Phase 3: Projects
**Goal:** Apply skills to real-world DevOps use cases

#### AWS Resource Tracker
* EC2 instance tracking
* S3 bucket inventory
* VPC & networking details
* IAM role summary
* Automated reporting
* Cron-based execution

➤ [Explore Projects](./03-projects/)

---

## What You Will Learn

* Automate repetitive Linux tasks
* Write clean, maintainable shell scripts
* Debug and handle failures effectively
* Work with real DevOps scenarios
* Use AWS CLI for infrastructure automation
* Build production-ready scripts

---

## Prerequisites

### Environment Options
* Windows → WSL2 (Recommended)
* Linux / Mac → Native terminal
* Cloud → AWS EC2 (Free Tier)

### Install Required Tools
```bash
# Ubuntu/Debian
sudo apt update
sudo apt install awscli vim curl wget

# Verify installation
aws --version
bash --version
```

---

## How to Use This Repository

```bash
# Clone the repository
git clone https://github.com/SachinRajguru/Shell-Scripting-Guide.git
cd Shell-Scripting-Guide
```

### Follow this workflow:
```
1. READ     → 01-basics/README.md
2. PRACTICE → Run every command
3. BUILD    → Write your own scripts
4. DEBUG    → Use set -x
5. ADVANCE  → Move to 02-advanced
6. PROJECT  → Build AWS tracker
7. COMMIT   → Push to GitHub
```

---

## Core Commands Reference

```bash
# Basics
ls -ltr
touch script.sh
vim script.sh
chmod 755 script.sh
./script.sh

# Pipelines
ps -ef | grep process | awk '{print $2}'

# Debugging & Safety
set -e
set -x
set -o pipefail

# Monitoring
free -h
df -h
top
nproc

# AWS Example
aws ec2 describe-instances \
  --query 'Reservations[*].Instances[*].[InstanceId,State.Name]' \
  --output table
```

---

## Interview Preparation

### Topics Covered

| Level        | Topics                            |
| ------------ | --------------------------------- |
| Beginner     | Shebang, chmod, script execution  |
| Intermediate | Pipes, awk, error handling        |
| Advanced     | trap, production scripts, AWS CLI |

### Sample Questions
```
1. How do you stop a script when a command fails?
2. How do you extract PID from `ps -ef`?
3. How do you handle Ctrl+C in a script?
4. How to count EC2 instances using AWS CLI?
```

---

## Project Highlight

### AWS Resource Tracker
A real-world DevOps automation project:

* Multi-service AWS scanning
* Cost visibility insights
* Script-based reporting
* Cron job automation
* Production-ready structure

**Use Case:** Daily AWS audit across multiple environments

---

## License
MIT License — Free for personal and commercial use

---

## Support
If you find this useful:
* Star the repository
* Share with others
* Use it as your DevOps reference

---

**Don't just read — build, break, debug, and automate.**

Start here ➤ `01-basics/`
Your DevOps journey begins now!
