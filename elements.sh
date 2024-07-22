#!/usr/bin/bash
PSQL="--username=postgres --dbname=periodic_table --port=5433 -t --no-align -c"
if [[ -z $1 ]]
then
    echo Please provide an element as an arguement.
fi

if [[ $1 =~ ^[0-9]+ ]]
then
    echo atomic no
elif [[ $1 =~ ^[A-Za-z]+ ]]
then
    echo name or symbol
fi