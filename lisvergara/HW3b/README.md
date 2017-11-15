########################################################################
##
## MNXB01-2017-HW3b
## Author: Florido Paganelli florido.paganelli@hep.lu.se
##         Lund University
##
########################################################################

# Description of the problem

A friend of mine likes videogames and wants to know some information
about all the existing Pokémon games around.
I found an open database on the internet:
http://wiki.thegamesdb.net/ 
And downloaded the information they have.
The database was in XML format, but it's hard to play with XML in bash,
so I converted it into the CSV format. I also divided the database in 
several files, one file for each computing platform.
My friend wants to know/have:
1. Use this script with the database stored in any folder he likes
2. A list of platforms where he can play "Pokemon Red Version"
3. A big list with all this information in a single file, 
   And another one where the names are in alphabetical order
4. How many Pokémon videogames exist for each platform

You should help me creating such software in one single script.
I placed the files in the dataset folder on github.

My suggestions how to implement the script are in the pokemon.sh.skeleton
file, please follow them! Each of them is worth a certain number of
points for the Homework. 

I also placed a copy of the output I'd like to see from the script in
the

>  ./result

folder, in a file called

> output.log

The resulting output for the big list is in

> allplatforms.csv  

And the ordered list should look exactly like:

> allplatforms.ordered.csv

Good luck!
