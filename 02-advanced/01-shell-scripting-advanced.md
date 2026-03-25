
# Advanced Shell Scripting

## Table of Contents
- [1. Prerequisites & Review](#1-prerequisites--review)
- [2. Node Health Monitoring Script](#2-node-health-monitoring-script)
- [3. Process Management Commands](#3-process-management-commands)
- [4. Pipe (`|`) Operator](#4-pipe--operator)
- [5. Shell Best Practices: `set` Options](#5-shell-best-practices-set-options)
- [6. Log Analysis with `curl` & `wget`](#6-log-analysis-with-curl--wget)
- [7. File Search with `find`](#7-file-search-with-find)
- [8. Control Structures (if/else, for loops)](#8-control-structures-ifelse-for-loops)
- [9. Signal Trapping with `trap`](#9-signal-trapping-with-trap)
- [10. Complete Node Health Script](#10-complete-node-health-script)
- [11. Interview Questions & Answers](#11-interview-questions--answers)
- [12. Summary](#12-summary)

---

## 1. Prerequisites & Review

**Required Knowledge**: [Shell Scripting Basics](../01-basics/01-shell-scripting-basics.md)

**Quick Review**:
```
✓ Basic commands: ls, touch, vim, cat, chmod, pwd, mkdir, cd
✓ Shebang: #!/bin/bash vs #!/bin/sh
✓ First script execution
✓ Node monitoring: df, free, nproc, top
```

**Lab Setup**:
```bash
# Use Ubuntu EC2 instance (or any Linux VM)
# Bash is default on all major distros
sudo apt update
```

---

## 2. Node Health Monitoring Script

**Goal**: Build production-ready script for VM health analysis. (Custom script to analyze VM health → GitHub repo → Share with team.)

**Scenario:**
```
Dev: "VM is slow! Help Abhishek!"  
You: "Run node_health.sh → Instant diagnosis!"
```

**Lab Exercise 1: Basic Node Health Script**
```bash
vim node_health.sh
```

```bash
#!/bin/bash
# ==========================================
# Node Health Monitor - v1.0
# Author: Sachin
# Date: Dec 1, 2023
# Purpose: Analyze VM health (CPU, Memory, Disk)
# Prerequisites: Bash shell
# ==========================================

# Disk space
df -h

# Memory usage  
free -g

# CPU cores
nproc
```

**Execute**:
```bash
chmod 755 node_health.sh
./node_health.sh
```

**Problem**: Raw output → **Hard to read!**

---

## 3. Process Management Commands

### 3.1 `ps -ef` - List All Processes

**Definition**: `ps -ef` = **P**rocess **S**tatus in full format (`-e` all, `-f` full).

```bash
ps -ef                    # All processes (detailed)
ps -ef | head -10         # First 10 processes
```

**Output Columns**:
```
UID    PID   PPID  C STIME TTY      TIME CMD
root   1234  1     0 10:30 ?        00:00:01 amazon-agent
```

**Use Case**: Find specific processes (Amazon services, Java apps).

**Example**:
```bash
ps -ef | grep amazon
# Only shows Amazon processes
```

**Analogy:** Windows Task Manager → Linux CLI version.

### 3.2 `grep` - Filter Output

**Definition**: `grep` = **G**lobal **R**egular **E**xpression **P**rint - Filter lines matching pattern.

**Syntax**:
```bash
grep pattern file          # Search file
grep pattern command       # Search command output
```

**Examples**:
```bash
ps -ef | grep python       # Python processes
cat log.txt | grep ERROR   # Find errors in logs
grep "Sachin" users.txt    # Find specific user
```

**Test Example:**
```bash
$ ps -ef | grep amazon
root     1234  1  0 10:30 ?        00:00:01 amazon-agent
ubuntu   5678  1  0 10:35 ?        00:00:02 amazon-process
```

**Test Script**:
```bash
#!/bin/bash
echo "1 11 12 55 99" | grep 1
# Output: 1 11 12 ✓
```

**Analogy**: Ctrl+F in Notepad (search functionality).

### 3.3 `awk` - Column Extraction

**Definition**: `awk` = **Pattern scanning and processing language** - Extract specific columns.

**AWK Syntax:**
```bash
awk '{print $N}'    # Print column N (space delimiter)
awk -F":" '{print $2}'  # Custom delimiter (:)
```

**Example**:
```bash
ps -ef | grep amazon | awk '{print $2}'
# $1=UID, $2=PID, $3=PPID, etc.
# Prints ONLY Process IDs!
```

**Output:**
```
1234
5678
```

**Lab Exercise 2: Extract Process IDs**
```bash
# Get root processes only
ps -ef | grep root | awk '{print $2, $NF}'

# Get Python PIDs
ps -ef | grep python | awk '{print $2}'
```

**Analogy**:
```
grep = Find rows containing "amazon"
awk = Extract specific columns from those rows
```

---

## 4. Pipe (`|`) Operator

**Definition**: **`|`** sends **stdout** of left command as **stdin** to right command.

**Syntax:**
```bash
command1 | command2 | command3  #Pipe sends output of left command → input of right command.
```

**Lab Exercise 3: Pipe Power**
```bash
# Example 1: Numbers filter
# Create test data
vim test.sh
```

```bash
#!/bin/bash
echo "11"
echo "12" 
echo "55"
echo "99"
```

```bash
chmod +x test.sh
./test.sh | grep 1    
# Output: 11 12 ✓
```

**Pipe Chain Example**:
```bash
# Example 2: Complete process chain
ps -ef | grep amazon | awk '{print $2}' | head -3
# All processes → Filter amazon → Get PIDs → First 3 only
```

**Pipe Power Chain:**
```
ps -ef          → All processes
   | grep amazon → Amazon processes  
   | awk '{print $2}' → PIDs only
   | head -5     → First 5 PIDs
```

**Analogy:** Assembly line → Output → Next machine.

---

## 5. Shell Best Practices: `set` Options

### 5.1 Script Metadata (Script Header Template/Comments)
```bash
#!/bin/bash
# ==========================================
# Script Name: node_health.sh
# Author: Sachin (Sachin@company.com)
# Date: Dec 1, 2023
# Version: v1.0
# Purpose: VM health monitoring
# Prerequisites: Ubuntu 20.04+, root access recommended
# ==========================================
```

### 5.2 `set` Options (CRITICAL!)

| Option | Purpose | Example |
|--------|---------|---------|
| `set -x` | **Debug mode** - Print each command before execution | `+ df -h` |
| `set -e` | **Exit on error** - Stop script on any command failure | ✓ Production ready |
| `set -o pipefail` | **Pipe failure handling** - Fail if ANY pipe command fails | Fixes `set -e` pipe bug |

#### 5.2.1 Debug Mode (`set -x`)
```bash
#!/bin/bash
set -x  # Debug mode: Print each command before execution
df -h
```

**Output:**
```
+ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       20G  1.2G   19G   6% /
```

#### 5.2.2 Error Handling (`set -e`)
Exits script on ANY error.

```bash
#!/bin/bash
set -e  # Exit on error

useradd newuser     # Step 1
touch /tmp/users.txt # Step 2
echo $newuser >> /tmp/users.txt  # Step 3

# WITHOUT set -e: Steps 2-3 execute even if Step 1 fails
# WITH set -e: Script stops at Step 1 failure ✓
```

**Lab Demo (Error without set -e):**
```bash
#!/bin/bash
# BAD: Continues after error
invalid_command
echo "This still executes! 😱"
```

**Lab Demo (Fixed with set -e):**
```bash
#!/bin/bash
set -e
invalid_command    # Script stops here ✓
echo "Never reached!"
```

#### 5.2.3 Pipe Fail (`set -o pipefail`)
Treats pipe failures as script errors.

```bash
#!/bin/bash
set -e
set -o pipefail

# WITHOUT pipefail: Only checks LAST command
ps -ef | grep invalid | awk '{print $2}'
echo "Script continues! 😱"

# WITH pipefail: Stops on ANY pipe failure ✓
```

**Complete Best Practices:**
```bash
#!/bin/bash
# Best practices enabled
set -e          # Exit on error
set -o pipefail # Exit on pipe failure
set -x          # Debug mode
```

**Pro Tip:** Keep flags separate lines for easy commenting!

---

## 6. Log Analysis with `curl` & `wget`

### 6.1 `curl` - Fetch from URL (Display)
**Definition**: **C**lient **URL** - Download/print web content.

```bash
# Scenario: Remote Log Analysis
# Logs stored: GitHub/S3/Azure Blob  
# Goal: Find ERROR logs remotely

# Fetch GitHub raw log file (Downloads AND displays content)
curl https://raw.githubusercontent.com/username/repo/main/dummy.log

# API call (API Testing)
curl -X GET https://api.example.com/health
curl -X POST -d '{"status":"up"}' https://api.example.com/status

# Filter errors directly (Error Log Filter)
curl https://raw.githubusercontent.com/.../dummy.log | grep ERROR
```

### 6.2 `wget` - Download to File (Download Only)
**Definition**: **W**eb **GET** - Download files to disk.

```bash
wget https://raw.githubusercontent.com/user/dummy.log
ls -ltr dummy.log
cat dummy.log | grep ERROR
```

**curl vs wget**:

| Command | Purpose | Saves File? | Use Case |
|---------|---------|-------------|----------|
| curl | Fetch + Display | ✗ No | Quick analysis |
| wget | Download | ✓ Yes | Archive logs |

**Interview Answer**:
```
Q: curl vs wget?
A: curl prints to stdout (pipe-friendly), wget saves to file.
Use curl for analysis, wget for downloads.
```

---

## 7. File Search with `find`

**Definition**: **`find`** searches filesystem by name, size, type, etc.

### 7.1 `sudo su -` - Become Root
```bash
sudo su -    # Switch to root user
whoami       # root ✓
exit         # Back to normal user
```

**Sudo vs Su:**
```
sudo ls /root/secrets    # Run ONE root command
sudo su -                # Become root permanently
```

### 7.2 find - Search Filesystem

**Lab Exercise 5: Find Files**
```bash
# Find as regular user (limited)
find /etc -name "pam.d" 2>/dev/null

# Find as root (full access)
sudo find / -name "pam.d" 2>/dev/null
```

**Pro Tip**: `2>/dev/null` suppresses permission denied errors.

**Example:**
```bash
sudo find /etc -name "passwd" 2>/dev/null
# /etc/passwd
```

---

## 8. Control Structures

### 8.1 `if/else` Syntax
```bash
#!/bin/bash
a=4
b=10

if [ $a -gt $b ]; then
    echo "a ($a) is greater than b ($b)"
else
    echo "b ($b) is greater than a ($a)"
fi
```

**Key Syntax**:
```
if [ condition ]; then     # Note spaces around [ ]
    # commands
else
    # else commands
fi                         # if backwards!
```

**Test Operators**:
| Operator | Meaning | Example |
|----------|---------|---------|
| `-eq` | Equal | `[ 5 -eq 5 ]` |
| `-ne` | Not equal | `[ 5 -ne 6 ]` |
| `-gt` | Greater than | `[ 10 -gt 5 ]` |
| `-lt` | Less than | `[ 3 -lt 5 ]` |

### 8.2 `for` Loop Syntax
```bash
#!/bin/bash
# Print 1-10
for i in {1..10}; do
    echo "Number: $i"
done

# Loop over files
for file in *.sh; do
    echo "Processing: $file"
done
```

**Loop Structure**:
```
for var in list; do
    # action
done
```

---

## 9. Signal Trapping with `trap`

**Definition**: **`trap`** **catches signals** (Ctrl+C, kill, etc.) and runs custom code.

**Linux Signals** (Common):
| Signal | Keyboard | Meaning |
|--------|----------|---------|
| `SIGINT` | **Ctrl+C** | Interrupt |
| `SIGTERM` | `kill` | Terminate |
| `SIGKILL` | `kill -9` | Force kill |

**Lab Exercise 6: Trap Demo**
```bash
#!/bin/bash
trap "echo 'Ctrl+C ignored! Use Ctrl+Z'" SIGINT

# Infinite loop
while true; do
    echo "Running... $(date)"
    sleep 1
done
```

**Output on Ctrl+C:**
```
Running... Mon Dec 4 10:30:15 UTC
Ctrl+C ignored!
Running... Mon Dec 4 10:30:16 UTC
```

**Real-World Example** (Cleanup Trap):
```bash
#!/bin/bash
TEMP_FILE=/tmp/temp_data

trap "rm -f $TEMP_FILE; echo 'Cleanup complete!'" EXIT

touch $TEMP_FILE
echo "Working..." 
sleep 60
```

**Real Scenario:** Database cleanup on interrupt.

**Interview Answer**:
```
Q: What is trap?
A: trap catches Linux signals (Ctrl+C=SIGINT) and runs custom code.
Prevents accidental termination, enables cleanup.
```

---

## 10. Complete Node Health Script

**Lab Exercise 7: Production-Ready Script**
```bash
vim complete_node_health.sh
```

```bash
#!/bin/bash
# ==========================================
# Complete Node Health Monitor - v2.0
# Author: Sachin
# Date: Dec 1, 2023
# Purpose: Production VM health analysis
# Version: 2.0
# ==========================================

# BEST PRACTICES
set -e                  # Exit on error
set -x                  # Debug mode
set -o pipefail         # Exit on pipe fail

echo "=== NODE HEALTH REPORT === $(date)"

# 1. CPU
echo "🖥️  CPU:"
echo "Cores: $(nproc)"

# 2. Memory  
echo "💾 MEMORY:"
free -h

# 3. Disk
echo "📁 DISK SPACE:"
df -h | grep -v "^tmpfs"

# 4. PROCESSES (Top 10 CPU)
echo "⚡ TOP CPU PROCESSES:"
ps -eo pid,ppid,cmd,%cpu,%mem --sort=-%cpu | head -11

# 5. AMAZON PROCESSES
echo "☁️  AMAZON PROCESSES:"
ps -ef | grep amazon | grep -v grep | awk '{print $2 ": " $NF}'

echo "=== ✓ Analysis complete! ==="
```

**Execute**:
```bash
chmod 755 complete_node_health.sh
./complete_node_health.sh
```

---

## 11. Interview Questions & Answers

### Q1: `date | echo "Today is"` output?

**A**: Only `"Today is"` prints. `date` writes to **stderr**, pipe uses **stdout**. 
Use:
```bash
date | cat
echo "Today is $(date)"
```

### Q2: Difference curl vs wget?

**A:** `curl` prints to stdout (pipeable), `wget` saves to file.
```
- **curl:** Fetch + display (API testing, pipes)
- **wget:** Download to file (archiving)
```

### Q3: Purpose of set -e, set -x, set -o pipefail?

**A:**
```
- `set -e`: Exit on error
- `set -x`: Debug mode (print commands)
- `set -o pipefail`: Exit on pipe failures
```

### Q4: Fix `set -e` with pipes?

**A**: Add `set -o pipefail`. `set -e` only checks last pipe command.

### Q5: Extract PID from `ps -ef | grep process`?

**A:**
```bash
ps -ef | grep process | grep -v grep | awk '{print $2}'
```

### Q6: Trap Ctrl+C in script?

**A:**
```bash
trap "echo 'Ignored!'" SIGINT
or
trap "echo 'Cannot stop!'; exit 0" SIGINT
```

### Q7: Why metadata in scripts?
**A**: Context, versioning, authorship, troubleshooting info.

## Hands-On Lab Checklist ✓

```
□ [ ] Build basic node_health.sh
□ [ ] Test ps -ef | grep | awk pipeline
□ [ ] Verify set -e, -x, -o pipefail
□ [ ] Fetch remote logs with curl | grep ERROR
□ [ ] Download with wget + analyze
□ [ ] Find files with sudo find /
□ [ ] Write if/else script
□ [ ] Write for loop 1-100
□ [ ] Trap Ctrl+C signal
□ [ ] Build complete_node_health.sh
□ [ ] Git commit to repo
```

**Pro Tips**:
```
1. Always start with: set -e -x -o pipefail
2. Use metadata headers
3. Practice pipelines daily
4. man <command> = your best friend
5. GitHub all scripts
```

---

## 12. Summary

| Concept | Command/Flag | Purpose |
|---------|--------------|---------|
| Debug | `set -x` | Show executed commands |
| Error Exit | `set -e` | Stop on ANY error |
| Pipe Fail | `set -o pipefail` | Pipe error handling |
| Filter | `grep pattern` | Search output |
| Pipe | `|` | Chain commands |
| Columns | `awk '{print $2}'` | Extract specific column |
| Download/Display | `curl url` | Remote file/API |
| Download | `wget url` | Save to file |
| Search | `find / -name file` | Find files |
| Condition | `if [ $a -gt $b ]` | If-else logic |
| Loop | `for i in {1..10}` | Iterate |
| Signals | `trap` | Handle Ctrl+C/kill |

**Final Node Health Script**:
```bash
#!/bin/bash
set -e -x -o pipefail
# Metadata...
df -h
free -h
nproc
ps -ef | grep amazon | awk '{print $2}'
```
---