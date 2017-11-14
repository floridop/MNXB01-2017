#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh.skeleton file
# Author: Bromwel Apondi rh0260ap-s@student.lu.se
#         Lund University
#
########################################################################

# The script must take in input as an argument the directory where the 
# database is stored.
# for example:
#   ./pokemoninfo.sh dataset/
# note that the name 'dataset' should not be hardcoded. It can be any directory
# name. Make sure to read slides 33,34,39 
# Store the folder name in a variable called DBDIR.
DBDIR=$1

# use this function to show an error message with usage information.
errormsg() {
   echo "Usage:"
   echo "$0 <directory>"
   echo "directory must be a path containing a csv dataset."	
}

### Exercise 1: 1 points
# Write an error and exit if no command line argument exists or if the argument
# is empty (it could be a variable!)
# hint: use the if construct and the proper conditions to verify the arguments

# YOUR CODE HERE
if [ ! $DBDIR ]; then
	echo "You need to have at least one argument!" ;
	#If the argument is empty or no command line exists, this error message will be shown.
	# Exit with error, not zero
	exit 1;
fi
### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

# YOUR CODE HERE
echo "This scripts checks the existance of the DBDIR directory."
echo "Checking..."
if [ ! -d $DBDIR ]
#! is command for NOT, -d specifies a directory 
	then
		echo "$DBDIR does not  exist or is not a directory!"
		# Exit with error, not zero
		exit 1;
	
fi

### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..."

grep -nr --include=*.csv "Pokémon Red Version" $DBDIR
#This line reads inside all the csv files and returns the line number plus information about the files.

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise
echo -e "\nRemoving old allplatforms.csv"
# YOUR CODE HERE
if [ -e ./allplatforms.csv ]; 
	then rm ./allplatforms.csv 
	#This line deletes allplatforms.csv files that exist
fi

echo -e "\nRemoving old allplatforms.ordered.csv"

#Everytime the code is executed, more and more allplatforms.ordered.csv file are created. 
#Therefore, the code below deletes them everytime.
if [ -e ./allplatforms.ordered.csv ]; 
	then rm ./allplatforms.ordered.csv 
	#This line deletes allplatforms.ordered.csv files that exist
fi

### 

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

# YOUR FOR LOOP HERE
Outfiles="allplatforms.csv"
#Creating a variable
for files in $DBDIR/*.csv ; do
	tail -n +2 $files >> $Outfiles
#The for loop reads through the files in the directory,
# removes the header lines, uses information from the second row onwards
# and directs them to the single file with Outfiles as a variable.
done	

### Exercise 6: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'
echo -e "\nSorting allplatforms.csv..."
# YOUR CODE HERE

Alfabetical="allplatforms.ordered.csv"

sort -k2 -d ./allplatforms.csv >> $Alfabetical
#This command takes the content in allplatforms.csv and sorts them in alfabetical order. 
#Since the names are on the second column, -k2 tells it to skip the first column and 
#sort the second one alfabetically.

# Exercise 7: 4 points
# Write a for loop that, for each file, counts all the games
# in each file. Inspect the csv file to understand the structure of the 
# csv file to get the right numbers.
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

#YOUR CODE HERE

for files in $DBDIR/*.csv ; do
	gamenum="$(tail -n +2 $files | wc -l)"
#Counts the lines in the files excluding the header and gives back the number of games.
	filename=$(basename "$files")
#Takes away the directory path from the file names and only gives back the name of the file.
	echo "$filename has $gamenum games"
#Calling the filename and the number of games.	
done

exit 0;
