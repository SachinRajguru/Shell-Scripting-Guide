# Shell Scripting Basics - Study Guide

## Table of Contents
- [Module Overview](#module-overview)
- [1. Introduction to Shell Scripting](#1-introduction-to-shell-scripting)
- [2. What is Automation?](#2-what-is-automation)
- [3. Why Shell Scripting for DevOps?](#3-why-shell-scripting-for-devops)
- [4. Basic Linux Commands](#4-basic-linux-commands)
- [5. Creating & Editing Files](#5-creating--editing-files)
- [6. Shebang (#!) Explained](#6-shebang--explained)
- [7. Writing Your First Shell Script](#7-writing-your-first-shell-script)
- [8. File Permissions & chmod](#8-file-permissions--chmod)
- [9. Executing Shell Scripts](#9-executing-shell-scripts)
- [10. Directory Navigation Commands](#10-directory-navigation-commands)
- [11. Practical Shell Script Example](#11-practical-shell-script-example)
- [12. Shell Scripting in DevOps](#12-shell-scripting-in-devops)
- [13. Node Health Monitoring](#13-node-health-monitoring)
- [14. Interview Questions & Answers](#14-interview-questions--answers)
- [15. Summary & Next Steps](#15-summary--next-steps)
- [Hands-on Practice Exercise](#hands-on-practice-exercise)

---

## Module Overview

**Definition**: This study guide covers foundational shell scripting concepts for beginners and DevOps engineers.

**Purpose**: Learn automation basics, file operations, permissions, and DevOps use cases.

---

## 1. Introduction to Shell Scripting

**Definition**: Shell scripting automates day-to-day activities on Linux systems (AWS EC2, VMs, servers).

**Key Benefits**:
```
- Works across all Linux distributions
- Eliminates repetitive manual tasks
- Essential for DevOps/SRE roles
```

---

## 2. What is Automation?

**Definition**: Replacing manual tasks with scripts/programs.

**Examples**:
```
Manual: touch file1 file2 ... file1000 (Impossible)
Script: for i in {1..1000}; do touch file$i; done (Instant)
```

---

## 3. Why Shell Scripting for DevOps?

**Daily Use Cases**:
```
1. Infrastructure provisioning
2. Configuration management
3. Deployment automation
4. Health monitoring (10K+ servers)
5. Log analysis and alerts
6. Cron jobs and scheduling
```

---

## 4. Basic Linux Commands

### 4.1 `ls` - List Directory Contents
```bash
ls                    # Basic list
ls -l                 # Long format
ls -la                # Include hidden files
ls -ltr               # Sort by time (newest last)
```

### 4.2 `man` - Manual Pages
```bash
man ls                # Command documentation
q                     # Exit man page
```

### 4.3 `history` - Command History
```bash
history               # Show all commands
!123                  # Re-execute command #123
```

---

## 5. Creating & Editing Files

### 5.1 `touch` - Create Files
```bash
touch script.sh       # Create empty file
```

### 5.2 `vim` - Text Editor
```
vim script.sh
i          # Insert mode
Esc        # Command mode
:wq!       # Save & exit
:q!        # Quit without saving
```

### 5.3 `cat` - View File Contents
```bash
cat script.sh         # Display file
cat *.sh              # All .sh files
```

---

## 6. Shebang (#!) Explained

**Purpose**: Specifies interpreter for script execution.

```
#!/bin/bash           # Bash shell (recommended)
#!/bin/sh             # POSIX shell (dash on Ubuntu)
#!/usr/bin/env bash   # Most portable
```

**Interview Question**:
```
Q: #!/bin/sh vs #!/bin/bash?
A: /bin/sh links to dash (Ubuntu) which lacks bash features.
Use #!/bin/bash for reliability.
```

---

## 7. Writing Your First Shell Script

```bash
#!/bin/bash
echo "Hello, World!"
```

**Save as**: `first.sh`

---

## 8. File Permissions & chmod

**Permission Groups**: Owner | Group | Others

**Numeric System (4-2-1)**:
```
7 = rwx (4+2+1)
5 = r-x (4+1)
4 = r--
755 = Owner:rwx, Group:rx, Others:rx
```

**Commands**:
```bash
chmod 755 script.sh   # Standard for scripts
chmod +x script.sh    # Add execute permission
```

---

## 9. Executing Shell Scripts

```
Method 1: bash script.sh     # No chmod needed
Method 2: chmod +x script.sh # Recommended
          ./script.sh
```

---

## 10. Directory Navigation Commands

```bash
pwd                    # Print working directory
mkdir folder           # Create directory
cd folder              # Change directory
cd ..                  # Parent directory
cd ~                   # Home directory
```

---

## 11. Practical Shell Script Example

```bash
#!/bin/bash
mkdir demo
cd demo
touch file1 file2
chmod 755 file1 file2
ls -ltr
cd ..
```

---

## 12. Shell Scripting in DevOps

**Real-world Examples**:
```
Node health monitoring
Infrastructure provisioning
Deployment automation
Log analysis
Backup scripts
```

---

## 13. Node Health Monitoring

```bash
free -h                # Memory usage
top                    # CPU and processes
df -h                  # Disk usage
nproc                  # CPU cores
```

---

## 14. Interview Questions & Answers

**Q1**: Difference between `#!/bin/sh` and `#!/bin/bash`?
```
A: /bin/sh → dash (POSIX, limited features)
   /bin/bash → Full bash features
   Use #!/bin/bash for modern scripts
```

**Q2**: What does `chmod 755` mean?
```
A: Owner:rwx(7), Group:rx(5), Others:rx(5)
   4=read, 2=write, 1=execute
```

---

## 15. Summary & Next Steps

### 15.1 Commands Mastered (15 Total)
```
ls -ltr, touch, vim, cat, chmod, ./, man, history
pwd, mkdir, cd, rm -rf, echo, top, free -h
```

### 15.2 Practice Roadmap
```
Week 1: Master basics
Week 2: Advanced scripting
Week 3: Cron jobs
Week 4: DevOps projects
```

---

## Hands-on Practice Exercise

**Complete Script**:

```bash
#!/bin/bash
# Practice Exercise - All core concepts

echo "1. Creating folder 'practice'..."
mkdir -p practice

echo "2. Entering directory..."
cd practice

echo "3. Creating files..."
touch file1 file2 file3

echo "4. Setting 755 permissions..."
chmod 755 file1 file2 file3

echo "5. Listing contents:"
ls -ltr

echo "Returning to parent..."
cd ..

echo "Current directory: $(pwd)"
```

**Execution**:
```bash
vim practice.sh
# i → paste → Esc → :wq!
chmod 755 practice.sh
./practice.sh
ls -l practice/  # Verify 755 permissions
```

**Expected Output**:
```
1. Creating folder 'practice'...
2. Entering directory...
3. Creating files...
4. Setting 755 permissions...
5. Listing contents:
total 0
-rwxr-xr-x 1 user user 0 Dec 10 12:00 file1
-rwxr-xr-x 1 user user 0 Dec 10 12:00 file2
-rwxr-xr-x 1 user user 0 Dec 10 12:00 file3
Returning to parent...
Current directory: /home/user
```

---