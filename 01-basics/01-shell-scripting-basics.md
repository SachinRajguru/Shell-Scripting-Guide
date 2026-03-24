
# Shell Scripting Basics

## Table of Contents
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
- [15. Summary](#15-summary)

---

## 1. Introduction to Shell Scripting

**Definition**: Shell scripting is a process of **automating day-to-day activities or regular activities on Linux computers** (AWS VMs, local VMs, Oracle VirtualBox, bare-metal servers, etc.).

**Key Points**:
```
- Works on any Linux machine using the same shell
- Reduces manual, repetitive, tedious tasks
- Essential skill for DevOps, SRE, and infrastructure engineers 
- Platforms: AWS EC2, Ubuntu/CentOS VMs, any Linux environment
```

**Scenario**: 
```
Manual Task: Write numbers 1-10 → echo 1 2 3...10
Scale Up: Write numbers 1-1000 → IMPOSSIBLE manually
Scale Up: Create 100 files → touch file1 file2...file100
Scale Up: Create 2000 files → NEED AUTOMATION!
```

**Analogy**: Like creating Excel macros for repetitive Excel tasks.

---

## 2. What is Automation?

**Definition**: **Automation** = Process of reducing manual activities through scripts/programs.

**Examples**:
```
Day-to-Day: Repetitive tasks that are tedious
Linux: File creation, number printing, system monitoring
DevOps: Infrastructure setup, health checks, deployments
```

**Practical Example**:
```
✗ Manual: touch file1 file2 ... file1000 (Impossible!)
✓ Automated: Shell script creates 1000+ files instantly

✗ Manual: echo 1 2 3 4 5 6 7 8 9 10
✓ Script: for i in {1..10}; do echo $i; done
```

---

## 3. Why Shell Scripting for DevOps?

**Role in DevOps Day-to-Day**:
```
1. Infrastructure Automation (EC2/VM provisioning)
2. Configuration Management (Ansible wrapper)
3. Code Management (Git clone/pull/deploy)
4. Node Health Monitoring (10K+ VMs)
5. Cron Jobs & Scheduled Tasks
6. Deployment Scripts & CI/CD
7. Log Analysis & Alerts
```

**Lab Setup Requirements**:
```
Windows Users:
├── AWS Free Tier Account → Launch EC2 (Amazon Linux/Ubuntu)
├── Oracle VirtualBox → Install Ubuntu/CentOS
└── PuTTY → SSH to Linux VM

Mac/Linux Users: Terminal ready!
```

---

## 4. Basic Linux Commands

### 4.1 `ls` - List Files/Directories

**Definition**: `ls` = **List** files and directories in current directory.

```bash
# Basic listing
ls                    # Basic listing
ls -l                 # Long format (permissions, owner, size)
ls -la                # Show hidden files (.files)

# Detailed listing with timestamps
ls -ltr               # Long format + sort by time (newest first)

# Output Explanation:
# -l : long format (permissions, owner, size, date)
# -t : sort by modification time (newest first)
# -r : reverse order (oldest first)
```

**Example**:
```bash
$ ls -ltr
-rw-r--r-- 1 user user  220 Dec 10 10:30 first_shell_script.sh
drwxr-xr-x 2 user user 4096 Dec 10 10:35 my_first_folder/
```

**Analogy**: Like opening C: drive in Windows Explorer.

### 4.2 `man` - Manual Pages

**Definition**: `man` = **MANual** documentation for any command.

```bash
man ls        # LS command documentation
man touch     # TOUCH command documentation
man chmod     # CHMOD command documentation
q             # Quit man page (press q)
```

**Example**:
```bash
$ man touch
DESCRIPTION
       touch  - change file access and modification times
       If no file exists, it is created with default permissions
```

**Pro Tip**: **Always use `man <command>` when unsure!**

### 4.3 `history` - Command History

**Definition**: `history` = Shows all previously executed commands.

```bash
history              # All history
history | head -10   # Last 10 commands
!123                # Re-execute command #123
```

**Use Case**: Forgot a command? Check history!

---

## 5. Creating & Editing Files

### 5.1 `touch` - Create Empty Files

**Definition**: `touch` = Creates files with default permissions (if file doesn't exist).

```bash
# Create file (automation safe)
touch first_shell_script.sh
ls -ltr          # Verify file creation
```

**Key Point**: **Used in automation** (creates files WITHOUT opening).

### 5.2 `vi/vim` - Text Editors

**Definition**: 
- `vi`: Default editor (always available)
- `vim`: Enhanced editor (may need installation)

```bash
# Create AND open file
vim second_shell_script.sh

# vi/vim Modes:
# ───────────────
# Default: COMMAND mode (navigation)
# Press 'i': INSERT mode (editing)
# Press 'Esc': Back to COMMAND mode
# :wq! → Write (save) + Quit
# :q!  → Quit without saving
```

**VI/VIM Workflow**:
```
1. vim filename.sh
2. Press 'i' → INSERT mode (bottom-left shows -- INSERT --)
3. Write your script
4. Press 'Esc' → COMMAND mode
5. Type ':wq!' → Save & Exit
```

**Double-Click Trick**: Double-click filename in terminal → Auto-copies for pasting.

### 5.3 `cat` - Display File Contents

**Definition**: `cat` = **CAT**enate - Print file contents to terminal.

```bash
cat first_shell_script.sh   # Display content
cat *.sh                    # All .sh files
```

**Analogy**: Like opening Notepad to read file (without editing).

---

## 6. Shebang (#!) Explained

**Definition**: **Shebang** (`#!`) tells Linux **which interpreter** to use.

```bash
#!/bin/bash    # Use Bash shell (RECOMMENDED)
#!/usr/bin/env bash  # Most portable (finds bash in PATH)
#!/bin/sh      # Use SH shell  
#!/bin/ksh     # Use Korn shell
```

**Complete First Line**:
```bash
#!/bin/bash
```

**Why Shebang?**
```
Shell Script → Needs EXECUTABLE
Java → java filename.class
Python → python filename.py
Shell → bash filename.sh  ← Shebang automates this!
```

### 6.1 Shebang History & Interview Question

**SH vs BASH Debate**:

| Shell     | Path                | Status       | Notes |
|-----------|---------------------|--------------|-------|
| `sh`      | `/bin/sh`           | ⚠️ Variable  | Ubuntu → Links to **dash**<br>Older systems → Linked to **bash** |
| `bash`    | `/bin/bash`         | ✓ Recommended | Always use for new scripts |
| `env bash`| `/usr/bin/env bash` | ★ **Most Portable** | Finds bash anywhere |

**Interview Q&A**:
```
Q: Difference between #!/bin/sh and #!/bin/bash?
A: Previously /bin/sh linked to /bin/bash (symbolic linking).
Now Ubuntu/Debian link /bin/sh to /bin/dash (faster, POSIX-compliant).
Bash scripts using #!/bin/sh may FAIL on dash systems.
ALWAYS use #!/bin/bash for Bash scripting.
```

**Rule**: **Always use `#!/bin/bash` for new scripts!**

---

## 7. Writing Your First Shell Script

**Scenario**: Print "My name is Sachin" when executed.

```bash
#!/bin/bash
# My First Shell Script
echo "My name is Sachin"
```

**Step-by-Step Lab**:

```bash
# 1. Create file
vim first_script.sh

# 2. Enter INSERT mode (press 'i')
# 3. Write script above
# 4. Save & Exit (:wq!)

# 5. View contents
cat first_script.sh

# Output:
#!/bin/bash
echo "My name is Sachin"
```

**Echo Command**:
```bash
echo "Hello World"    # Print with quotes
echo Hello World      # Print without quotes (Hello treated as command → Error!)
```

**Comments in Shell**:
```bash
#!/bin/bash
# This is a comment (ignored by shell)
echo "Hello"         # Inline comment
```

---

## 8. File Permissions & chmod

### 8.1 Permission Denied Error

```bash
./first_script.sh
# → bash: ./first_script.sh: Permission denied
```

**Why?** Linux = **Security First**. Must grant **execute permission**.

### 8.2 `chmod` - CHange MODe

**Definition**: **Change file permissions**.

**Permission Model** (3 Groups):
```
OWNER (You)   | GROUP | OTHERS (Everyone)
7             | 7     | 7
```

**Magic Numbers** (4-2-1 Formula):
```
7 = 4+2+1 = r+w+x (All permissions)
4 = read only (r--)
2 = write only (-w-)
1 = execute only (---x)
0 = no permissions (---)
```

**Common Permissions**:
```bash
chmod 777 file.sh     # Everyone: rwx (DANGER!)
chmod 770 file.sh     # Owner+Group: rwx, Others: none
chmod 755 file.sh     # Owner: rwx, Group/Others: rx ✓ Scripts
chmod 644 file.sh     # Owner: rw, Group/Others: r ✓ Configs
chmod +x file.sh      # Add execute for owner (simplest)
```

**Lab Example**:
```bash
chmod 777 first_script.sh
ls -ltr first_script.sh    # -rwxrwxrwx
./first_script.sh          # ✓ Works!
# → My name is Sachin ✓
```

**Verify Permissions**:
```bash
ls -ltr first_script.sh
# -rwxrwxrwx 1 user user 45 Dec 10 10:45 first_script.sh
```

**Permission Breakdown**:
```
-rwxrwxrwx
 ││└─── Others (7 = rwx)
 │└───── Group (7 = rwx)  
 └────── Owner (7 = rwx)
```

---

## 9. Executing Shell Scripts

**Two Methods**:

```bash
# Method 1: Explicit shell (no chmod needed)
sh first_script.sh
bash first_script.sh

# Method 2: Direct execution (Recommended)
chmod +x first_script.sh
./first_script.sh         # ./ = current directory
```

**`.` vs `./`**:
```
. = Current directory
./ = Current directory + filename
```

---

## 10. Directory Navigation Commands

### 10.1 `pwd` - Print Working Directory

```bash
pwd                          # Where am I?
# /home/user/shell_scripting_tutorials
```

### 10.2 `mkdir` - Make Directory

```bash
mkdir my_first_folder
ls -ltr                      # Verify folder
```

### 10.3 `cd` - Change Directory

```bash
cd my_first_folder      # Enter folder
cd ..                   # Go up one level
cd ~/                   # Home directory
cd /                    # Root directory
```

**Complete Lab**:
```bash
pwd                          # Check current location
mkdir my_first_folder
ls -ltr                      # Verify folder created
cd my_first_folder
pwd                          # Confirm inside folder
cd ..                        # Go back
pwd                          # Verify back to parent
```

**Pro Tips**:
```bash
Tab completion: Type 'my_f' + Tab → my_first_folder
cd -              # Go to previous directory
```

---

## 11. Practical Shell Script Example

**Scenario**: Create folder → Enter folder → Create 2 files.

```bash
# Create comprehensive script
vim sample_shell_script.sh
```

```bash
#!/bin/bash
# ========================================
# Sample Shell Script: Create folder + files
# Purpose: Demonstrate automation capabilities
# ========================================

# Create folder
echo "Creating folder 'Practice'..."
mkdir Practice

# Enter folder
cd Practice

# Create files
echo "Creating files inside Practice folder..."
touch first_file
touch second_file

# List contents (proof of execution)
echo "Contents of Practice folder:"
ls -ltr

echo "✓ Automation completed successfully!"
```

**Complete Lab Execution**:

```bash
# 1. Create script
vim sample_script.sh
# (Write script above, :wq!)

# 2. Grant permissions
chmod 777 sample_script.sh

# 3. Execute
./sample_script.sh

# 4. Verify
ls -ltr           # See Practice folder
cd Practice/
ls -ltr           # See first_file, second_file ✓
```

**Output**:
```
Practice/
├── first_file
└── second_file
```

**Bonus**: `rm -rf folder_name` to delete (use carefully!).

---

## 12. Shell Scripting in DevOps

**Real-World Use Cases**:

### 12.1 Node Health Monitoring (10K VMs)

**Scenario**: John (DevOps Engineer) manages 10K Linux VMs.

**Problem**:
```
Developers complain:
✗ "VM 9999 is slow!"
✗ "CPU maxed out!"
✗ "Memory exhausted!"
```

**Shell Script Solution** *(Preview - Full implementation in Advanced Guide)*:
```bash
#!/bin/bash
# ========================================
# Production Node Health Monitor (10K VMs)
# Features: SSH → Metrics → Alerts → Cron
# ========================================

VM_LIST="vm1 vm2 ... vm10000"
for vm in $VM_LIST; do
    ssh $vm "top -b -n1 | head -20"  # [Pipes covered later]
    # CPU/Memory/Disk checks
    if [ high_usage ]; then           # [if/else covered later]
        echo "ALERT: $vm!" | mail -s "VM Alert" john@company.com
    fi
done
```

**Cron Job** (Automated):
```bash
# Run every day at 2 AM
0 2 * * * /path/to/health_check.sh
```

### 12.2 **Infrastructure Automation Examples**

```
1. EC2 Auto-Scaling:
   ├── Launch 100 Ubuntu instances
   ├── Install Docker + Nginx
   └── Join cluster
   
2. GitOps Deployment:
   ├── git pull main
   ├── docker build & push
   └── kubectl apply
   
3. Log Analysis Pipeline:
   ├── curl S3 logs
   ├── grep ERROR | count
   └── Alert Slack/Email
```

### 12.3 **DevOps Workflow Integration**

```
CI/CD Pipeline:
├── Jenkins → Shell wrapper
├── GitHub Actions → .sh scripts
├── Ansible → Shell tasks
└── Kubernetes → Init containers

Monitoring Stack:
├── Prometheus → Shell exporters
├── Grafana → Custom dashboards
└── AlertManager → Shell notifiers
```

### 12.4 **Interview Use Case Response**

**Q**: "Why shell scripting when Ansible/Python exist?"
```
A: "Shell = Fastest prototyping + Day-2 ops
   - Ansible wrapper for complex logic
   - Quick cron jobs/debugging
   - 1000-line Python = 50-line shell
   - Native Linux → No dependencies
   
   Example: Monitor 10K VMs daily
   Shell: 20 lines + cron
   Python: 100+ lines + pip install"
```

---

## 13. Node Health Monitoring Commands

### 13.1 CPU Monitoring
```bash
nproc              # Number of CPUs
top                # Real-time process monitoring
top -bn1 | grep 'Cpu(s)'  # Batch mode CPU stats
```

### 13.2 Memory Monitoring
```bash
free -h            # Human-readable memory stats
```

### 13.3 Process Monitoring
```bash
top                # Interactive monitoring
# Ctrl+C to exit
```

**Top Command Output**:
```
Tasks: 625 total,   5 running, 620 sleeping
%Cpu(s): 10.2 us,  5.1 sy,  0.0 ni, 84.7 id
MiB Mem :  8000.0 total,  2000.0 free,  5000.0 used
```

### 13.4 Disk Usage Monitoring
```bash
df -h                # Human-readable disk stats
```

---

## 14. Interview Questions & Answers

### Q1: What is Shell Scripting?
**A**: Shell scripting automates repetitive Linux tasks using shell commands stored in `.sh` files.

### Q2: Difference between `#!/bin/sh` vs `#!/bin/bash`?
**A**: 
```
#!/bin/sh: POSIX shell (dash on Ubuntu, previously bash)
#!/bin/bash: Bash shell specifically
#!/usr/bin/env bash: Most portable (finds bash in PATH)
Use #!/bin/bash for Bash features to avoid compatibility issues.
```

### Q3: Explain file permissions (777 vs 755)?
**A**:
```
777 = Owner: rwx | Group: rwx | Others: rwx (Everyone)
755 = Owner: rwx | Group: rx- | Others: rx- (Execute only)
Formula: 4(read) + 2(write) + 1(execute) = 7
```

### Q4: How do you monitor node health?
**A**:
```bash
top           # Processes + CPU/Memory
free -h       # Memory usage
nproc         # CPU count
Custom script → SSH to VMs + Parse output
```
**Example**:
```bash
top -bn1           # Batch CPU/Memory
free -h            # Memory usage
df -h              # Disk usage
Custom script → SSH + Parse with awk/bc
```

### Q5: Why `touch` vs `vim` for automation?
**A**:
```
touch: Creates file only ✓ Fast for 1000s of files
vim: Creates AND opens file ✗ Slow for bulk operations
```

---

## 15. Summary

| Command | Purpose | Example |
|---------|---------|---------|
| `ls -ltr` | List files | `ls -ltr` |
| `touch` | Create file | `touch file.sh` |
| `vim/vi` | Edit file | `vim script.sh` |
| `cat` | View file | `cat script.sh` |
| `chmod` | Permissions | `chmod 777 file.sh` |
| `./` or `sh` | Execute | `./script.sh` |
| `man` | Help | `man ls` |
| `history` | Command history | `history` |
| `pwd` | Current dir | `pwd` |
| `mkdir` | Create folder | `mkdir folder` |
| `cd` | Change dir | `cd folder` |
| `rm -rf` | Delete | `rm -rf folder` |
| `echo` | Print | `echo "Hello"` |
| `top` | Monitor | `top` |
| `free -h` | Memory | `free -h` |

---