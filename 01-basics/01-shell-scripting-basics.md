
# Shell Scripting - Basics

## Table of Contents
- [1. Introduction to Shell Scripting](#1-introduction-to-shell-scripting)
- [2. What is Automation?](#2-what-is-automation)
- [3. Why Shell Scripting for DevOps?](#3-why-shell-scripting-for-devops)
- [4. Basic Linux Commands](#4-basic-linux-commands)
- [5. Creating and Managing Files](#5-creating-and-managing-files)
- [6. Shebang (#!)](#6-shebang--)
- [7. Writing Your First Shell Script](#7-writing-your-first-shell-script)
- [8. File Permissions & chmod](#8-file-permissions--chmod)
- [9. Executing Shell Scripts](#9-executing-shell-scripts)
- [10. Directory Navigation](#10-directory-navigation)
- [11. Complete Sample Shell Script](#11-complete-sample-shell-script)
- [12. Role of Shell Scripting in DevOps](#12-role-of-shell-scripting-in-devops)
- [13. Node Health Monitoring](#13-node-health-monitoring)
- [14. Summary of All Commands](#15-summary-of-all-commands)

---

## 1. Introduction to Shell Scripting

**Definition**: Shell scripting is a process of automating day-to-day activities or regular activities on your Linux computer.

**Analogy**: Think of shell scripting as creating a "recipe" for your Linux machine. Instead of manually performing repetitive tasks (like writing numbers 1-1000), you write instructions once and let the computer execute them repeatedly.

**Scenario**: 
```
Manual Task: Create 100 files named file1.txt, file2.txt... file100.txt
With Shell Script: Write once, execute -> 100 files created instantly!
```

**Why Learn Shell Scripting?**
- Reduces manual effort
- Works on any Linux machine (AWS EC2, VirtualBox VM, etc.)
- Essential for DevOps engineers

---

## 2. What is Automation?

**Definition**: Automation is a process to reduce manual activities.

**Examples**:
```
Manual: echo 1; echo 2; ... echo 1000  (Impossible!)
Automated: for i in {1..1000}; do echo $i; done

Manual: touch file1 file2 ... file1000
Automated: for i in {1..1000}; do touch file$i; done
```

**Real-world Analogy**: 
> Washing dishes manually vs. using a dishwasher. Shell scripting is your "dishwasher" for Linux tasks.

---

## 3. Why Shell Scripting for DevOps?

**DevOps Use Cases**:
1. **Infrastructure Automation**
2. **Configuration Management**
3. **Code Management (Git operations)**
4. **Node Health Monitoring**
5. **Cron Jobs & Scheduled Tasks**

**Lab Setup Requirements**:
```
Windows Users:
1. AWS Account -> Launch EC2 (Amazon Linux/Ubuntu)
2. OR: Oracle VirtualBox -> Install Ubuntu/CentOS

Mac/Linux Users: Terminal ready!
```

---

## 4. Basic Linux Commands

### 4.1 `ls` - List Files/Directories

```bash
# Basic listing
ls

# Detailed listing with timestamps
ls -ltr

# Example Output:
# -rw-r--r-- 1 user user  0 Dec 10 10:30 first_shell_script.sh
```

**Definition**: `ls` = List. Shows files and folders in current directory.

**Analogy**: Like opening File Explorer on Windows and seeing all files.

### 4.2 `man` - Manual Pages

```bash
man ls        # Shows ls command documentation
man touch     # Shows touch command documentation
q             # Quit man page (press q)
```

**Definition**: `man` = Manual. Built-in documentation for any command.

**Pro Tip**: Forgot what `-ltr` does in `ls -ltr`? -> `man ls`

### 4.3 `touch` - Create Empty Files

```bash
touch first_shell_script.sh
ls -ltr          # Verify file created
```

**Definition**: Creates files with default permissions or updates timestamps.

**Key Point**: `man touch` says: *"If file doesn't exist, create with default permissions"*

**Why `touch` vs `vim`?**
```
touch: Create only (automation-friendly)
vim:  Create + Open (interactive editing)
```

---

## 5. Creating and Managing Files

### 5.1 File Editors: `vi` vs `vim`

**`vi`** (Always available):
```bash
vi first_shell_script.sh
```

**`vim`** (User-friendly, needs installation):
```
# Ubuntu/Debian
sudo apt update
sudo apt install vim

# CentOS/RHEL
sudo yum install vim
```

### 5.2 Vim/vi Modes & Commands

```
1. Open file: vi filename.sh
2. Enter INSERT MODE: Press ESC -> i
3. Exit INSERT MODE: Press ESC
4. Save & Quit: :wq!
5. Quit without saving: :q!
```

**Visual Guide**:
```
┌─────────────────────────────────────┐
│ #!/bin/bash                         │
│ echo "Hello World"                  │
│                                     │
│ -- INSERT --                        │  <- INSERT MODE (bottom left)
└─────────────────────────────────────┘
```

**Pro Tip**: Double-click text in terminal -> Auto-copy (no Ctrl+C needed!)

### 5.3 `cat` - Display File Contents

```bash
cat first_shell_script.sh
```

**Definition**: `cat` = Concatenate. Prints file contents to terminal.

**Analogy**: Like opening a text file to read without editing.

---

## 6. Shebang (#!)

### 6.1 What is Shebang?

```bash
#!/bin/bash    <- Shebang Line (First line of EVERY shell script)
echo "My name is Sachin"
```

**Definition**: Shebang (`#!`) tells the kernel **which executable** to use for the script.

**Syntax**: `#!` + `/path/to/interpreter`

### 6.2 Shell Types & History

```
Common Shells:
├── sh     (Traditional Bourne Shell)
├── bash   (Bourne Again Shell) <- MOST POPULAR
├── ksh    (Korn Shell)
└── dash   (Debian Almquist Shell)
```

**GitHub Example**:
```bash
#!/usr/bin/env bash    # Portable shebang
#!/bin/bash           # Direct path
```

### 6.3 Critical Interview Question: `/bin/sh` vs `/bin/bash`

```
OLD WAY:
#!/bin/sh

CORRECT WAY:
#!/bin/bash
```

**Why the difference?**

```
Linux History:
1990s: /bin/sh -> linked to /bin/bash
2020s: Ubuntu -> /bin/sh -> linked to /bin/dash (faster, lighter)

Result: Bash scripts with #!/bin/sh may FAIL on modern Ubuntu!
```

**Interview Answer**:
> "Previously `/bin/sh` was symlinked to `/bin/bash`, but modern distros like Ubuntu link `/bin/sh` to `/bin/dash`. Always use `#!/bin/bash` for bash scripting to avoid compatibility issues."

---

## 7. Writing Your First Shell Script

### 7.1 Complete Example

```bash
#!/bin/bash
# My First Shell Script - Prints my name

echo "My name is Sachin"
```

**Step-by-Step Creation**:
```bash
1. vim first_script.sh
2. Press i (INSERT MODE)
3. Paste script above
4. ESC -> :wq! (Save & Quit)
5. cat first_script.sh (Verify)
```

**Output**:
```
My name is Sachin
```

**Echo vs Programming Languages**:
```
Java:    System.out.println("Hello")
Python:  print("Hello")
Shell:   echo "Hello"    <- SIMPLEST!
```

---

## 8. File Permissions & chmod

### 8.1 Permission Denied Error

```bash
./first_script.sh
# -> bash: ./first_script.sh: Permission denied
```

**Why?** Linux = Security First! Files need explicit execute permissions.

### 8.2 `chmod` Command

**Definition**: `chmod` = **CH**ange **MOD**e (permissions)

```
Syntax: chmod [permissions] filename
```

### 8.3 Permission Model: User-Group-Others

```
┌─────────────┬────────────┬────────────┐
│   Owner     │   Group    │  Everyone  │
│ (You)       │ (Team)     │ (Others)   │
├─────────────┼────────────┼────────────┤
│ 7           │ 7          │ 7          │ <- chmod 777
└─────────────┴────────────┴────────────┘
```

### 8.4 Magic Numbers: 4-2-1 Formula

```
4 = Read (r)
2 = Write (w) 
1 = Execute (x)

Combinations:
7 = 4+2+1 = rwx (Full access)
5 = 4+1   = r-x (Read + Execute)
4 = 4     = r-- (Read only)
1 = 1     = --x (Execute only)
```

**Practical Examples**:
```bash
chmod 777 script.sh     # Everyone: Read+Write+Execute
chmod 755 script.sh     # Owner:rwx, Group:rx, Others:rx
chmod 444 script.sh     # Everyone: Read only
chmod 111 script.sh     # Everyone: Execute only
```

**Lab Exercise**:
```bash
# Test permissions
chmod 444 first_script.sh
vim first_script.sh     # -> Cannot edit! (Read only)

chmod 777 first_script.sh
vim first_script.sh     # -> Can edit now!
```

---

## 9. Executing Shell Scripts

### 9.1 Two Methods

```bash
# Method 1: Direct execution
chmod +x first_script.sh
./first_script.sh

# Method 2: Explicit shell
sh first_script.sh
bash first_script.sh
```

**`.` vs `./`**:
- `.` = Current directory
- `./` = Execute file in current directory

---

## 10. Directory Navigation

### 10.1 Essential Commands

```bash
pwd           # Print Working Directory
mkdir folder  # Make Directory
cd folder     # Change Directory
cd ..         # Go up one level
ls -ltr       # List with timestamps
```

**Complete Example**:
```bash
pwd                           # /home/user/shell_tutorials
mkdir my_first_folder
ls -ltr                       # Verify folder created
cd my_first_folder
pwd                           # /home/user/shell_tutorials/my_first_folder
cd ..                         # Go back
pwd                           # /home/user/shell_tutorials
```

**Windows Analogy**:
```
Windows: Double-click folders
Linux:   cd folder_name
```

---

## 11. Complete Sample Shell Script

### 11.1 Automation Script

```bash
#!/bin/bash
# Sample Shell Script: Create folder + files automatically
# Author: Sachin (Learning Purpose)

# Step 1: Create folder
echo "Creating folder 'Sachin'..."
mkdir Sachin

# Step 2: Enter folder
echo "Entering folder..."
cd Sachin

# Step 3: Create files
echo "Creating files inside Sachin folder..."
touch first_file
touch second_file

# Step 4: Verify creation
echo "Files created successfully!"
ls -ltr
```

### 11.2 Execute & Test

```bash
vim sample_script.sh       # Create script
chmod 777 sample_script.sh # Grant permissions
./sample_script.sh         # Execute

# Expected Output:
# Creating folder 'Sachin'...
# Entering folder...
# Creating files inside Sachin folder...
# Files created successfully!
# total 0
# -rw-r--r-- 1 user user 0 Dec 10 11:00 first_file
# -rw-r--r-- 1 user user 0 Dec 10 11:00 second_file
```

**Verification**:
```bash
ls -ltr      # See Sachin folder
cd Sachin
ls -ltr      # See first_file, second_file
```

### 11.3 Bonus: Clean Up

```bash
rm -rf Sachin/    # Remove folder + contents
# -r = recursive, -f = force
```

---

## 12. Role of Shell Scripting in DevOps

### 12.1 DevOps Engineer's Daily Tasks

```
Core Responsibilities:
├── Infrastructure Maintenance
├── Git/Code Management
├── Configuration Management
└── Automation (Ansible wrapper scripts)
```

### 12.2 Real-World Scenario: Node Health Monitoring

**Scenario**: John (DevOps Engineer) manages 10,000 Linux VMs at Amazon.

**Problem**:
```
Developers complain:
"VM 9999 is slow!"
"CPU 100% on VM 5001!"
"Memory exhausted on VM 2345!"
```

**Shell Script Solution**:
```bash
#!/bin/bash
# Simple Node Health Monitor

VM_LIST="vm9999 vm5001 vm2345"

for vm in $VM_LIST; do
    echo "=== Checking $vm ==="
    ssh $vm "free -h"           # Memory usage
    echo "-------------------"
    ssh $vm "top -bn1 | head -5" # Top CPU processes
    echo ""
done
```

**Cron Job** (Automated):
```bash
# Run every day at 2 AM
0 2 * * * /path/to/health_check.sh
```

**Benefits**:
- Monitors 10,000 VMs automatically
- Email alerts for suspicious nodes
- Custom parameters beyond monitoring tools

---

## 13. Node Health Monitoring Commands

### 13.1 Essential Commands

```bash
nproc          # Number of CPU cores
free -h        # Memory usage
top            # Real-time process monitoring
history        # Command history
```

### 13.2 `top` Command Breakdown

```
top output:
  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND
 1234 root      20   0  123456  78901  2345 S  45.2 12.3   1:23.45 httpd
```

**Key Metrics**:
- `%CPU`: CPU usage
- `%MEM`: Memory usage  
- `TIME+`: Total CPU time consumed

---

## 14. Summary of All Commands Learned

| Command | Purpose | Example |
|---------|---------|---------|
| `ls` | List files | `ls -ltr` |
| `touch` | Create file | `touch script.sh` |
| `man` | Manual | `man ls` |
| `vi/vim` | Edit file | `vim script.sh` |
| `cat` | View file | `cat script.sh` |
| `chmod` | Permissions | `chmod 777 script.sh` |
| `pwd` | Current dir | `pwd` |
| `mkdir` | Create dir | `mkdir folder` |
| `cd` | Change dir | `cd folder` |
| `rm` | Remove | `rm -rf folder` |
| `history` | Command history | `history` |
| `top` | Monitor processes | `top` |
| `free` | Memory | `free -h` |
| `nproc` | CPU cores | `nproc` |

## Practice Lab: Create Your Own Script

```bash
#!/bin/bash
# Practice: Complete Automation Script

echo "=== Linux Automation Demo ==="
mkdir practice_demo
cd practice_demo
touch file{1..5}
chmod 755 *.sh
ls -ltr
echo "Automation Complete!"
pwd
```

**Execute**: `chmod +x practice.sh && ./practice.sh`

---