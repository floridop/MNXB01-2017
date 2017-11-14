#!/bin/bash

#######################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh
# Author: Lucas Hellström nat14lhe@student.lu.se
#		  Lund University
########################################################################

#clear the log file of entries if log file exists
if [ -e ./results/output.log ]; then
 rm ./results/output.log 
fi


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

#Check if parameter DBDIR exists and is not empty, if it does not exists or is empty the program will exit
if [ ! $DBDIR ]; then
	echo "Parameter does not exist or is empty!" | tee "output.log" -a
	exit 0;
fi

### Exercise 2: 1 points
# Write an error and exit if the DBDIR directory does not exist or it's not a directory.
# Hint: read http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html

#Check if DBDIR is a directory, if not the program will exit
if [ ! -d  $DBDIR ]; then 
	echo "$DBDIR does not exist or is not a directory!" | tee "output.log" -a
	exit 0;
fi

#Count the number of .csv files in DBDIR
countcsv=$(find $DBDIR -name  "*.csv" | wc -l)

#Check if the number of .csv file is more than 0. If it is 0, the directory is not a database
#directory and the program will cancel
if [ $countcsv = 0 ]; then
	echo "$DBDIR does not contain any .csv files!" | tee "output.log" -a
	exit 0;
fi

### Exercise 3: 1 point
# Use the grep command to find which file contains "Pokémon Red Version"
# and output the results on screen.
# grep examples: http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_04_02.html

echo -e "\nSearching for Pokémon Red..." | tee "output.log" -a
#Search for "Pokémon Red" in all .csv files in the directory specified by user
grep -nr --include=*.csv "Pokémon Red" $DBDIR

### Exercise 4: 1 point
# delete existing allplatform.csv file in preparation of the next exercise

echo -e "\nRemoving old allplatforms.csv" | tee "output.log" -a

#check if allplatforms.csv exists in database, if it does the program will delete it
if [ -e ./allplatforms.csv ]; then
 rm ./allplatforms.csv
fi

#check if allplatforms.csv exists in results directory, if it does the program will delete it
if [ -e ./results/allplatforms.csv ]; then
 rm ./results/allplatforms.csv
fi


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

echo -e "\nCreating new allplatforms.csv" | tee "output.log" -a

OutFileName="allplatforms.csv"

#output the lines from all files in specified directory with extension .csv with tail command
#starting with line 2 to remove header and put result in file allplatforms.csv

for filename in $DBDIR/*.csv; do
	tail -n +2 $filename >> $OutFileName 
done



### Exercise 4: 1 point
# Sort the contents of the allplatforms.csv file by using the sort 
# command and write the result in allplatforms.ordered.csv
# Hint: use \" as a delimiter for sort. Check 'man sort'

echo -e "\nSorting allplatforms.csv..." | tee "output.log" -a

SortFileName="allplatforms.ordered.csv"

#Sort the file allplatforms.csv with respect to the second column (name of the games) and put result
#in file allplatforms.ordered.csv
sort -k2 -d ./allplatforms.csv >> $SortFileName

#Create directory results, if it does not exist, in the same folder as the program is run from.
#Then move the allplatforms.csv and allplatforms.ordered.csv files there

mkdir -p ./results
mv $OutFileName ./results
mv $SortFileName ./results

###NOTE: Some games are appearing twice in the allplatforms list, this is because they exist in the file 
#poke.NintendoGameBoy.csv AND poke.NintendoGameBoyAdvance.csv or poke.NintendoGameBoyColor.csv
#(This caused some confusion as I thought the code were checking these files twice)

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

echo -e "\nCalculating number of games for each file..." | tee "output.log" -a

#Using a for loop, all .csv files in specified directory will be listed and the number of lines in them will
#be counted. This number together with the name of the file, using the basename to remove path, 
#are put into the output.log file and shown in the terminal

for filename in $DBDIR/*.csv; do
	numLines="$(tail -n +2 $filename | wc -l)"
	nameShort=$(basename "$filename")
	echo "$nameShort has $numLines game(s)" | tee "output.log" -a
done

#Finally the output.log file are moved into the results folder
	mv output.log ./results
exit 0;
