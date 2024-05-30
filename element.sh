#!/bin/bash
echo "Please provide an element as an argument."
PSQL="psql --username=freecodecamp --dbname=periodic_table -t -c"
SYMBOL=$1

# If input is not a number
if ! [[ $SYMBOL =~ ^[0-9]+$ ]]; then
  # If input is greater than two letters
  LENGTH=$(echo -n "$SYMBOL" | wc -m)
  if [[ $LENGTH -gt 2 ]]; then 
    # Get data by full name
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE name='$SYMBOL'")
    if [[ -z $DATA ]]; then
      echo "I could not find that element in the database."
    else
      echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELTING BAR BOILING BAR TYPE; do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  else
    # Get data by atomic symbol
    DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE symbol='$SYMBOL'")
    if [[ -z $DATA ]]; then
      echo "I could not find that element in the database."
    else
      echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELTING BAR BOILING BAR TYPE; do
        echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
      done
    fi
  fi
else
  # Get data by atomic number
  DATA=$($PSQL "SELECT * FROM elements INNER JOIN properties USING(atomic_number) INNER JOIN types USING(type_id) WHERE atomic_number=$SYMBOL")
  if [[ -z $DATA ]]; then
    echo "I could not find that element in the database."
  else
    echo $DATA | while read BAR BAR NUMBER BAR SYMBOL BAR NAME BAR WEIGHT BAR MELTING BAR BOILING BAR TYPE; do
      echo "The element with atomic number $NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $WEIGHT amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."
    done
  fi
fi
