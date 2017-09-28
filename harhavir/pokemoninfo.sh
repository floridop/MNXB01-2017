#!/bin/bash

DBDIR=$1

errormsg() {
   echo "Usage:"
   echo "$0 <directory>"
   echo "directory must be a path containing a csv dataset."	
}

if [[ (( $# -le 0 )) || (( -s DBDIR )) ]]; 
# if the number of inputs is less than or equal to 0 or if the input is not a file or has filesize 0...
then
	errormsg; #... display the error message defined above...
	exit 1; #... and exit the script with an error
fi

errormsg2() {
	echo "Usage"
	echo "$0 <directory>"
	echo "input must exist and be a directory!"
}

if [[ !(( -d $DBDIR )) ]] #if DBDIR does not exist or is not a directory then...
then
	errormsg2
	exit
fi

echo -e "\nSearching for Pokémon Red..."

FILES=$DBDIR/* #Creates a list of all files in DBDIR
for f in $FILES
do #For every file in this list
	grep -w "Pokémon Red" $f #check each for the string "Pokémon Red" and print where it is found.
done

echo -e "\nRemoving old allplatforms.csv"

if [[ -e allplatforms.csv ]] 
then
	rm allplatforms.csv
	rm allplatforms.ordered.csv
fi

echo -e "\nCreating new allplatforms.csv"

touch allplatforms.csv #Create allplatforms.csv
for f in $FILES 
do #For every file in this list
	tail -n+2 $f >> allplatforms.csv 
	#take all of the text, save the first line (the header) and concatenate into allplatforms.csv
done

echo -e "\nSorting allplatforms.csv..."

touch allplatforms.ordered.csv #Creates allplatforms.ordered.csv
sort -t\" -k3 -d allplatforms.csv >> allplatforms.ordered.csv
#above sorts whatever follows the third (k3) instance of " (t\") by dictionary order (d).
#Since the file reads the columns as "NNNN", "Pokémon XYZ", ...  the third instance of " 
#is the one directly before the Pokémon game title.

echo -e "\nCalculating number of games for each file..."

for f in $FILES
do
	lines=$(wc -l < $f) #counts number of lines in the file
	games=$(expr $lines - 1) #since each file has a header of one line, subtract that
	echo $(echo $f) $(echo " has ") $(echo $games) $(echo " games.")  #concatenating strings as output
done	

exit 0;
