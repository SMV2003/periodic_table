#!/usr/bin/bash
PSQL="psql --username=postgres --dbname=periodic_table --port=5433 --tuples-only -c"
if [[ -z $1 ]]
then
    echo Please provide an element as an arguement.
fi

if [[ $1 =~ ^[0-9]+ ]]
then
    INFO="$($PSQL"SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE atomic_number=$1")"
    if [[ -z $INFO ]]
    then
        echo I could not find that element in the database.
    else
        echo "$INFO" | while read TYPE_ID BAR ANUM BAR SYMBOL BAR NAME BAR AMASS BAR MPOINT BAR BPOINT BAR TYPE
        do
            echo "The element with atomic number $ANUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MPOINT celsius and a boiling point of $BPOINT celsius."
        done
    fi
elif [[ $1 =~ ^[A-Za-z]+ ]]
then
    INFO="$($PSQL "SELECT * FROM elements JOIN properties USING(atomic_number) JOIN types USING(type_id) WHERE symbol='$1' OR name='$1'")"
        if [[ -z $INFO ]]
    then
        echo I could not find that element in the database.
    else
        echo "$INFO" | while read TYPE_ID BAR ANUM BAR SYMBOL BAR NAME BAR AMASS BAR MPOINT BAR BPOINT BAR TYPE
        do
            echo "The element with atomic number $ANUM is $NAME ($SYMBOL). It's a $TYPE, with a mass of $AMASS amu. $NAME has a melting point of $MPOINT celsius and a boiling point of $BPOINT celsius."
        done
    fi
fi