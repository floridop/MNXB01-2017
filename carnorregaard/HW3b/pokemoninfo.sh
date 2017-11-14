#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh.skeleton file
# Author: Carina Norregaard norregaard.carina@gmail.com
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

if [ ! $DBDIR ] ;
	then
		echo "You need at least one argument.";
	# exit with error, not zero
	exit 1;
fi
#This states that if no input is inserted, the program will exit with the statement "You need at least one argument."


### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

echo "This script checks the existence of the directory."
echo "Checking..."
if [ ! -d $DBDIR ] ;
	then 
		echo "DBDIR does not exist or is not a directory."
	exit 1;
fi 
echo
echo "...done."

#This code checks that the input is indeed a directory, using -d. If it is not, the program will exit with an error.


### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..."
grep -nr --include=*.csv "Pokémon Red Version" $DBDIR

#This code reads through the .csv files looking for "Pokemon Red Version". The -nr includes the line number in the results.

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise
echo -e "\nRemoving old allplatforms.csv"
if [ -e ./allplatforms.csv ];
	then rm ./allplatforms.csv 
fi 

#This code reads the names of the files in the directory, and if it finds allplatforms.csv it will delete it,
#so that it can be created in the next step. 

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

Total="allplatforms.csv" 
#total output into allplatforms.csv, $Total is the variable
for files in $DBDIR/*.csv; do
	tail -n +2 $files >> $Total
done

#This for loop takes in the variable $Total as the compiled file, and reads through all the .csv files in the given directory.
#It uses the tail command to remove the header, and then places all the content of the files into Total=allplatforms.csv. 

### Exercise 6: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'

echo -e "\nRemoving old allplatforms.ordered.csv"
if [ -e ./allplatforms.ordered.csv ];
	then rm ./allplatforms.ordered.csv 
fi 

#Here, I added the removal of any pre-existing allplatforms.ordered.csv files from the directory,
#using the same code that removed the pre-existing allplatforms.csv. I implemented this so that the files 
#are not added again each time the code runs, but rather that one set of ordered files is in the
#allplatforms.ordered.csv file. 

echo -e "\nSorting allplatforms.csv..."

Ordered="allplatforms.ordered.csv"

sort -k2 ./allplatforms.csv >> $Ordered
#automatically sorts alphabetically

#Using the sort command, this code reads through the allplatforms.csv file, starting from the second column,
#to order it alphabetically. The sort command seems to order the games automatically in alphabetical order.

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
for files in $DBDIR/*.csv ; do
	gamenumber="$(tail -n +2 $files | wc -l)"
	#|wc -l takes the output from tail -n +2 $files as input into gamenumber
	filename=$(basename "$files")
	echo "$filename has $gamenumber games"
done 	

#Again, this code reads through the .csv files in the given directory, then counts the lines in the files, having removed
#the header with the tail command. The number of lines (which is also the number of games) is then assigned to the gamenumber
#variable. Then, the code removes the directory path from the name of the files, using the basename command and inputs 
#the name into the variable filename. Finally, the filename and corresponding gamenumber are returned with the echo command.  


exit 0;
