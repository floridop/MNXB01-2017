#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh.skeleton file
# Author: Florido Paganelli florido.paganelli@hep.lu.se
#         Lund University
#		Albin Hedse
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

if [ $# -eq 0 ]; 
	then echo "No argument has been given."
			exit 1
	elif [ -a "$1" ];
		then 
		:
		else echo "Argument is empty."
			exit 1
fi
#if $# is 0, there is no variable given, and the script exits, if everything but 
#$0 is 0, then the argument is empty

### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

if [ -d $DBDIR ];
	then 
	:
	else	echo 'The directory either does not exist or is not a directory.'
		exit 1
fi
# returns true if it is a directory and does nothing, if not a directory, it gives a message and exits

### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..."

grep -lr $DBDIR -e "Pokémon Red Version"

# l lists whatever's printed, r makes the search recursive, so that it checks all directories and subdirectories

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise
echo -e "\nRemoving old allplatforms.csv"

rm $DBDIR/allplatforms.csv
rm $DBDIR/allplatforms.ordered.csv

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

for file in ${DBDIR}/*;
do tail -n +2 $file >> $DBDIR/allplatforms.csv
done

#for every file in DBDIR it takes everything from line 2 to the bottom and inserts
#it into a file called allplatforms.csv which is saved inside DBDIR

### Exercise 6: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'
echo -e "\nSorting allplatforms.csv..."

sort -t\" -k3 -d $DBDIR/allplatforms.csv >> $DBDIR/allplatforms.ordered.csv

# Sorts by dictionary order after the third " appears, (-t\) determines
# what "index" is used, and -k3 denotes that it is sorted by what comes after
# the third ' " ' 

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

for file in ${DBDIR}/*; do
	if [ $file == $DBDIR/allplatforms.csv ] || [ $file == $DBDIR/allplatforms.ordered.csv ];
		then :
		else
			basename $file | xargs echo -n
			echo -n " contains " 
			tail -n +2 $file | wc -l | xargs echo -n
			echo " game(s)."
	fi
done

#Checks if the filename is either allplatforms.csv or allplatforms ordered.csv
# if it is, it ignores them, otherwise it echoes the basename (no extension) of each file
#and then checks the tail of every file up to the line after the header
#wc -l counts the amount of lines after the header has been removed, this is then echoed
#in the last command

exit 0;
