#!/bin/bash
# listfiletypes.sh
# run with: ./listfilestypes.sh <directory>
#
# Print the argument values

TARGETDIR=$1

if [ "x$TARGETDIR" == "x" ]; then
     TARGETDIR='/etc'
     MESSAGE="No argument found. Listing filetypes for the /etc directory by default"
else
     MESSAGE="Scanning filetypes for the ${TARGETDIR} directory"
fi

echo "$MESSAGE"

for somefile in ${TARGETDIR}/*; do
    echo "This is the file $somefile, with type:";
    # the file command tells you the type of a file.
    file $somefile
done
