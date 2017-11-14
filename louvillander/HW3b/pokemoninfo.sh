#!/bin/bash

########################################################################
#
# MNXB01-2017-HW3b
# File: pokemoninfo.sh
# Author: Louise Villander louise.villander.925@student.lu.se
#         Lund University
#
########################################################################


DBDIR=$1                 # the variable DBDIR is defined as the first argument passed to the script

errormsg() {             # error message to display if argument is passed incorrectly
   echo "Usage:"
   echo "$0 <directory>"
   echo "directory must be a path containing a csv dataset."	
}

# EXERCISE 1 (1 point)
if  [ "x$DBDIR" == "x" ] || [ $# != 1 ]; then    # if the argument passed is not defined or empty, or if the number of arguments passed is not 1
    errormsg;                                    # then give the error message,
    exit 1;                                      # terminate, and return exit code 1 (error)
fi

# EXERCISE 2 (1 point)
if [ ! -d "$DBDIR" ]; then         # if the argument passed is not an existing directory,
	errormsg;                      # then give the error message,
	exit 1;                        # terminate, and return exit code 1 (error)
fi


# EXERCISE 3 (1 point)
echo -e "\nSearching for Pokémon Red..."
grep -r "Pokémon Red Version" $DBDIR     # finds and displays which files in the directory contains the string "Pokémon Red Version"


# EXERCISE 4 (1 point)
echo -e "\nRemoving old allplatforms.csv"
find . -type f -name "allplatforms.csv" -delete    # finds and deletes the file "allplatforms.csv", searching from the working directory and through its subdirectories

# not an exercise
if [ ! -d "result" ]; then     #checks if a directory "result" exists; if not, one is created
	mkdir ./result
fi

# EXERCISE 5 (3 points)
echo -e "\nCreating new allplatforms.csv"
for file in $DBDIR/*; do                             # for every file in the directory
	tail -n +2 $file >> result/allplatforms.csv;     # remove the header and append the rest in the new file "allplatforms.csv"
done


# EXERCISE 6 (1 point)
echo -e "\nSorting allplatforms.csv..."
sort -t "," -k2 result/allplatforms.csv > result/allplatforms.ordered.csv  # sorts the contents of "allplatforms.csv" alphabetically according to column 2 (game titles), saves result in new csv file

# EXERCISE 7 (4 points)
echo -e "\nCalculating number of games for each file..."
for file in $DBDIR/*; do                                   # for every file in the directory
	f=$( tail -n +2 $file | wc -l );                       # count the number of lines, excluding the header (= number of games listed in the file)
	echo "$(basename ${file}) has $f game(s)";             # display filename and how many games were in the file
done
echo

exit 0            # terminate, and return exit code 0 (no error)




