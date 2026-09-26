#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
exit 0
fi
if [[ $1 =~ ^[0-9]+$ ]]
 then
ELEMENT_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) where atomic_number = $1;")
else 
ELEMENT_DATA=$($PSQL "SELECT atomic_number, name, symbol, type, atomic_mass, melting_point_celsius, boiling_point_celsius from elements join properties using(atomic_number) join types using(type_id) where symbol= '$1' or name= '$1';")
fi
if [[ -z $ELEMENT_DATA ]]
then
echo "I could not find that element in the database."
else 
IFS='|' read -r ATOMIC_NUMBER NAME SYMBOL TYPE MASS MELTING BOILING <<< "$ELEMENT_DATA"
MASS_FORMATTED=$(echo $MASS | sed -E 's/0+$//;s/\.$//')
echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $MASS_FORMATTED amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
fi