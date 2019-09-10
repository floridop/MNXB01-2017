#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh solution file
# Author: Florido Paganelli florido.paganelli@hep.lu.se
#         Lund University
#
########################################################################

# The script must take in input the directory where the database is stored.
# Stores it in a variable called DBDIR.
DBDIR=$1

# use this function to show an error message with usage information.
errormsg() {
   echo "Usage:"
   echo "$0 <directory>"
   echo "directory must be a path containing a csv dataset."	
}

### Exercise 1: 1 points
# Write an error and exit if no parameter exists or if the parameter is empty.
# hint: use the if construct and the proper conditions to verify parameters
# and directory existence.

if [[ $# -le 0 ]]; then
   echo "Missing mandatory parameter." 
   errormsg
   echo "Exiting..."
   exit 1;
fi

### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

if ! [ -d ${DBDIR} ]; then
    echo "${DBDIR} not found or not a directory."
    errormsg
    echo "Exiting..."
    exit 1
fi

### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..."
grep 'Pokémon Red Version' ${DBDIR}/*

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise
# TODO: would have been better with a check for existence before.
echo -e "\nRemoving old allplatforms.csv"
rm -f allplatforms.csv

### Exercise 5: 3 points
# Write a for loop that takes every file in the database and puts it 
# into a single file
# called allplatforms.csv.
# Inspect the csv files to understand their structure,
# and make sure to remove the header lines.
# Hint: use the slides about for ... do ... done
#       use the tail command to remove the header lines (check 'man tail'),
#       use the file concatenator '>>' to write out the allplatforms.csv file

# create allplatforms file with a for loop
echo -e "\nCreating new allplatforms.csv"
# Start of for loop
for dbfile in ${DBDIR}/*; do
    tail -n +2 ${dbfile} >> allplatforms.csv
# end of for loop
done

### Exercise 4: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'
echo -e "\nSorting allplatforms.csv..."
# TODO: add -d to do proper sorting.
sort -t\" -k3 allplatforms.csv > allplatforms.ordered.csv



# Exercise 5: 4 points
# Write a for loop that, for each file, counts all the games
# in each file. Inspect the csv file to understand the structure of the 
# csv file. 
# Hint: use the slides about for ... do ... done
#       use the '$()' syntax to put the output of a command inside a variable
#       use the program tail to get rid of useless lines
#       use the program wc to count things
#       make use of the | symbol to compose         
#       use the 'basename' command to get rid of the directory part of the filename
# output the result in this form:
# <filename> has <number of games> games <newline>
# example output:
# poke.Android.csv has 2 game(s)
# poke.iOS.csv has 1 game(s)
echo -e "\nCalculating number of games for each file..."
for dbfile in ${DBDIR}/*; do
    NLINES=$(tail -n +2 ${dbfile} | wc -l)
    PLAINFILENAME=$(basename ${dbfile})
    echo "$PLAINFILENAME has $NLINES game(s)"
done

exit 0;
