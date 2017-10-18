#!/bin/bash

# put the output of cat in the variable CPUINFO
CPUINFO=$(cat /proc/cpuinfo)

# write the content of CPUINFO to screen
echo "$CPUINFO"

# write out the PATH predefined variable value
echo "PATH value is $PATH"
