
# Shell Scripting - Basics

## Module Overview

This module covers the foundational concepts of shell scripting for beginners and DevOps engineers.

## Topics Covered

1. Introduction to Shell Scripting
2. What is Automation?
3. Why Shell Scripting for DevOps?
4. Basic Linux Commands (ls, man, touch)
5. Creating and Managing Files (vi/vim, cat)
6. Shebang (#!) - /bin/bash vs /bin/sh
7. Writing Your First Shell Script
8. File Permissions & chmod (777, 755, 4-2-1 formula)
9. Executing Shell Scripts (./script.sh)
10. Directory Navigation (pwd, cd, mkdir)
11. Complete Sample Shell Script
12. Role of Shell Scripting in DevOps
13. Node Health Monitoring
14. Summary of All Commands

## Key Learning Outcomes

- Understand shebang and why `#!/bin/bash` is preferred
- Master file permissions using chmod with 4-2-1 formula
- Create, edit, and execute shell scripts
- Navigate Linux directories efficiently
- Build automation scripts for repetitive tasks
- Learn DevOps use cases (node monitoring, cron jobs)

## Essential Commands Reference

```
File Operations:
touch filename.sh     # Create file
vim filename.sh       # Edit file (i → ESC → :wq!)
cat filename.sh       # View content
chmod 777 filename.sh # Full permissions
./filename.sh         # Execute script

Directory:
pwd                   # Current location
mkdir folder          # Create folder
cd folder             # Enter folder
cd ..                 # Go up
ls -ltr               # List detailed

System Monitoring:
free -h               # Memory
top                   # Processes
nproc                 # CPU cores
```

## Hands-on Practice Exercise

Create and execute this complete automation script:

```bash
#!/bin/bash
# =====================================================
# Hands-on Practice Exercise: Shell Scripting Basics
# =====================================================
# This script demonstrates:
# 1. Directory creation (mkdir)
# 2. Directory navigation (cd)
# 3. File creation (touch)
# 4. File listing (ls -ltr)
# 5. Current directory display (pwd with command substitution)
# =====================================================

echo "Creating folder 'practice'..."
# mkdir creates directory if it doesn't exist
# -p flag could be added for parent directories: mkdir -p /path/to/practice
mkdir practice

echo "Entering 'practice' directory..."
cd practice
# cd changes current working directory
# Use 'cd -' to return to previous directory

echo "Creating 3 empty files: file1, file2, file3..."
# touch creates empty files or updates timestamp of existing files
touch file1 file2 file3

echo "Files created:"
# ls -ltr: list files with long format (-l), sorted by time (-t), reverse order (-r)
ls -ltr

echo "Returning to parent directory..."
cd ..
# cd .. moves up one directory level
# cd ~ or cd returns to home directory

echo "Current directory: $(pwd)"
# $(pwd) uses command substitution to capture pwd output
# Alternative: `pwd` (backticks also work)
```

**Enhanced Steps with Comments:**

```bash
# =====================================================
# STEP-BY-STEP EXECUTION GUIDE
# =====================================================

# 1. CREATE SCRIPT FILE
vim practice.sh
# - vim: powerful text editor
# - nano practice.sh: simpler alternative for beginners

# 2. ENTER INSERT MODE & PASTE SCRIPT
# Press 'i' → Paste script → ESC → :wq! (write & quit)

# 3. SET EXECUTABLE PERMISSIONS
chmod 777 practice.sh
# 777 = rwxrwxrwx (owner:group:others all have read/write/execute)
# Better practice: chmod 755 practice.sh (rwxr-xr-x)

# 4. EXECUTE THE SCRIPT
./practice.sh
# ./ specifies current directory (required for security)
# Alternative: bash practice.sh (no chmod needed)

# 5. VERIFY RESULTS
ls -la practice/          # Check folder & files created
cat practice/file1        # View file content (empty)
rm -rf practice/          # Cleanup (optional)
```

**Expected Output:**
```
Creating folder 'practice'...
Entering 'practice' directory...
Creating 3 empty files: file1, file2, file3...
Files created:
total 0
-rw-r--r-- 1 user user 0 Dec  5 10:30 file1
-rw-r--r-- 1 user user 0 Dec  5 10:30 file2
-rw-r--r-- 1 user user 0 Dec  5 10:30 file3
Returning to parent directory...
Current directory: /home/user
```

**Pro Tips:**

```bash
# SECURITY BEST PRACTICES:
# chmod 755 script.sh    # Owner:rwx, Group:rx, Others:rx (RECOMMENDED)
# chmod 700 script.sh    # Owner only (sensitive scripts)

# DEBUGGING:
# bash -x practice.sh    # Trace execution
# set -x                  # Debug mode within script

# ERROR HANDLING:
# mkdir -p practice      # No error if exists
# cd practice || exit 1  # Exit on failure
```

**Troubleshooting:**

```bash
# COMMON ISSUES:
# Permission denied? → chmod +x practice.sh
# ./practice.sh: No such file? → ls -la (check filename)
# Command not found? → which bash (verify shebang path)
# Directory exists? → rm -rf practice/ before running
```

## Lab Setup Requirements

**Windows Users:**
- AWS EC2 (Amazon Linux/Ubuntu) OR
- VirtualBox with Ubuntu/CentOS

**Mac/Linux Users:** Terminal ready

## Next Module
02-advanced/ - Loops, conditions, functions, advanced automation

---