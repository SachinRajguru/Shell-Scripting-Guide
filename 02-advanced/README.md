
# Advanced Shell Scripting

## Overview
Build production-ready shell scripts for DevOps. Learn process management, pipelines, error handling, control structures, signal trapping, and complete node health monitoring.

**Level**: Intermediate  
**Prerequisites**: [Shell Scripting Basics](../01-basics/)

## Table of Contents
- [Study Guide](./advanced-shell-scripting.md)
- [Quick Reference Commands](#quick-reference-commands)
- [Learning Objectives](#learning-objectives)
- [Practice Exercises](#practice-exercises)
- [Interview Preparation](#interview-preparation)

## Quick Reference Commands
```bash
set -e -x -o pipefail    # Best practices
ps -ef | grep process | awk '{print $2}'  # Process pipeline
curl url | grep ERROR    # Remote log analysis
find / -name "*.log"     # File search
if [ $a -gt $b ]; then   # Conditionals
for i in {1..10}; do     # Loops
trap "echo Cleanup" EXIT # Signal handling
```

## Learning Objectives
After completing this module, you will be able to:

1. Build production-ready scripts with error handling
2. Create powerful pipelines with `ps | grep | awk`
3. Implement `set -e`, `-x`, `-o pipefail` best practices
4. Analyze remote logs with `curl | grep`
5. Search filesystem with `find`
6. Write `if/else` and `for` loop control structures
7. Handle signals with `trap`
8. Develop complete node health monitoring scripts

## Study Guide Sections

| Section | Focus Area | Key Skills |
|---------|------------|-----------|
| 1-2 | Prerequisites & Node Health | Script foundation |
| 3-4 | Process Management & Pipes | `ps`, `grep`, `awk`, `|` |
| 5 | Best Practices | `set` options |
| 6-7 | Log Analysis & File Search | `curl`, `wget`, `find` |
| 8-9 | Control Structures & Traps | `if/else`, `for`, `trap` |
| 10-12 | Complete Scripts & Summary | Production scripts |

## Practice Exercises

### Exercise 1: Process Pipeline
```bash
# Find top 5 CPU processes
ps -eo pid,%cpu,cmd --sort=-%cpu | head -6
```

### Exercise 2: Error Handling Template
```bash
#!/bin/bash
set -e
set -o pipefail
set -x
# Your script here
```

### Exercise 3: Remote Log Analysis
```bash
# Fetch and filter errors (replace with real URL)
curl https://example.com/logs.txt | grep ERROR | tail -5
```

### Exercise 4: Signal Trap
```bash
#!/bin/bash
trap "echo Cleanup complete" EXIT
sleep 30
echo Done
```

## Interview Preparation

### Top 5 Questions Covered
1. **`set -e` vs `set -o pipefail`**: Error handling in scripts/pipes
2. **`ps | grep | awk` pipeline**: Extract process PIDs
3. **`curl` vs `wget`**: Fetch vs download
4. **`trap` usage**: Handle Ctrl+C/SIGINT
5. **Control structures**: `if [ $a -gt $b ]` syntax

## Next Steps
```
Complete → Cron Jobs & Scheduling (03-cron/)
Practice → Build multi-node health monitor
Apply → Production deployment scripts
Interview → Advanced shell scripting questions
```

## Folder Structure
```
02-advanced/
├── README.md                    # This file
└── advanced-shell-scripting.md  # Detailed study guide
```

---

**Practice Tip**: Build the complete node health script from scratch. Test all pipelines in production-like environment!