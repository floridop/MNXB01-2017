#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh.skeleton file
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

# YOUR CODE HERE

if [ "$#" == "0" ];
	then echo "Nothing here"
		exit
	elif [  -a "$1" ];
		then : 
		else echo "This is empty"
			exit
fi		
# The code checks if there is an input or not, and gives an error in case there is none. 
# In the case there is a input, the elif statement checks if there is somehting assigned to it or not.
# If the input is non-empty the code moves on, if not returns an error and exits.


### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

# YOUR CODE HERE

if [[ -d $DBDIR ]]
	then echo "This is an existing directory"
	else echo "This is not an existing directory or a directory"
		exit 1
fi	
#The code checks if the input directory exists or not and returns an error if not. 

### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..."
# YOUR CODE HERE

grep -lr  "Pokémon Red Version" $DBDIR
#The grep command recursively reads and lists and files in the input directory that contains the string.

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise
echo -e "\nRemoving old allplatforms.csv"
# YOUR CODE HERE

rm $DBDIR/allplatforms.csv
rm $DBDIR/allplatforms.ordered.csv
#The files in the input directory are removed

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

for file in ${DBDIR}/*; do
	tail -n +2 $file >> $DBDIR/allplatforms.csv
done
# This for loop reads through all files in the input directory.
# The tail command ignores the first line of the files, and copies the files into a new file.

### Exercise 4: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'
echo -e "\nSorting allplatforms.csv..."
# YOUR CODE HERE

sort -t\" -k3 -d $DBDIR/allplatforms.csv --output=$DBDIR/allplatforms.ordered.csv
#This command sorts through the given file, and sorts the second column alphabetically.
#The delimiter " is used to sort the file after the third one. 
#The result is output in a new file.



# Exercise 5: 4 points
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

for file in ${DBDIR}/*; do
	if [ $file == $DBDIR/allplatforms.csv ] || [ $file == $DBDIR/allplatforms.ordered.csv ];
		then :
		else
			basename "$file" | xargs echo -n	
			echo -n " contains " 
			tail -n +2 $file |  wc -l | xargs echo -n
			echo " game(s)" 
	fi
done
#The for loop checks every file in the input and ignores them if it's either of the allplatforms files.
#For eveyr other file, the loop removes the directory from the filename and outputs a string .
#The string cotains a sentence and takes as input the number of lines after the first one.
#The whole output is given on a single line.
 
exit 0;
