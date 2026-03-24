
# Shell Scripting Basics - Study Guide

## Overview
This guide covers the fundamentals of shell scripting for DevOps automation. Learn Linux setup, basic commands, file operations, permissions, script execution, and practical DevOps use cases.

**Level**: Beginner  
**Prerequisites**: Basic Linux terminal access

## Table of Contents
- [Study Guide](./01-shell-scripting-basics.md)
- [Quick Reference Commands](#quick-reference-commands)
- [Learning Objectives](#learning-objectives)
- [Practice Exercises](#practice-exercises)
- [Interview Preparation](#interview-preparation)

## Quick Reference Commands
```bash
ls -ltr      # List files with details
touch file.sh
vim file.sh  # Edit file (i → Esc → :wq)
cat file.sh  # View file
chmod +x file.sh
./file.sh    # Execute script
pwd          # Current directory
mkdir dir    # Create directory
cd dir       # Change directory
free -h      # Memory
top          # Processes
nproc        # CPU cores
```

## Learning Objectives
After completing this module, you will be able to:

1. Create and execute shell scripts with proper shebang
2. Manage file permissions using `chmod`
3. Navigate Linux directories efficiently
4. Understand shell scripting role in DevOps automation
5. Write basic automation scripts for repetitive tasks
6. Use essential monitoring commands (`top`, `free`, `df`)

## Study Guide Sections

| Section | Focus Area | Key Skills |
|---------|------------|-----------|
| 1-3 | Introduction & Automation | Understand shell scripting benefits |
| 4-5 | Basic Commands & File Ops | `ls`, `touch`, `vim`, `cat` |
| 6-9 | Scripts & Permissions | Shebang, `chmod`, execution methods |
| 10-11 | Navigation & Examples | `pwd`, `cd`, practical scripts |
| 12-13 | DevOps Applications | Monitoring, automation use cases |
| 14-15 | Interview Prep & Summary | Common questions & next steps |

## Practice Exercises

### Exercise 1: First Script
```bash
# Create and run your first script
touch hello.sh
vim hello.sh    # Add: #!/bin/bash\necho "Hello DevOps!"
chmod +x hello.sh
./hello.sh
```

### Exercise 2: Directory Automation
```bash
# Create practice directory structure
mkdir -p ~/practice/demo
cd ~/practice/demo
touch server1.log server2.log
chmod 755 *.log
ls -ltr
```

### Exercise 3: System Check Script
```bash
#!/bin/bash
echo "System Health Check"
free -h
echo "CPU Cores: $(nproc)"
top -b -n1 | head -20
```

## Interview Preparation

### Top 5 Questions Covered
1. **Shebang difference**: `#!/bin/sh` vs `#!/bin/bash`
2. **`chmod 755` meaning**: Owner:rwx, Group:rx, Others:rx
3. **Script execution methods**: `bash script.sh` vs `./script.sh`
4. **Common DevOps use cases**: Monitoring, deployments, backups
5. **File permission troubleshooting**: `ls -l` output interpretation

## Next Steps
```
Complete → Advanced Shell Scripting (02-advanced/)
Practice → Build monitoring script for 5 servers
Apply → Automate your daily Linux tasks
Interview → Answer shell scripting questions confidently
```

## Folder Structure
```
01-basics/
├── README.md                 # This file
└── shell-scripting-basics.md # Detailed study guide
```

---

**Practice Tip**: Execute every command in a Linux terminal (WSL, AWS EC2, or Docker Ubuntu). Hands-on practice is essential!