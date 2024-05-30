#!/bin/bash

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    echo "Please provide an element as an argument."
    exit
fi

# Function to fetch element information
fetch_element_info() {
    # Query the database for element information based on atomic number or symbol or name
    element_info=$(psql -d your_database_name -U your_username -c "SELECT atomic_number, symbol, name, atomic_mass, melting_point_celsius, boiling_point_celsius, type_id FROM properties JOIN elements USING (atomic_number) WHERE atomic_number = $1 OR symbol = '$1' OR name = '$1';" -t)

    # Check if element information exists
    if [ -n "$element_info" ]; then
        # Parse element information
        atomic_number=$(echo "$element_info" | awk '{print $1}')
        symbol=$(echo "$element_info" | awk '{print $2}')
        name=$(echo "$element_info" | awk '{print $3}')
        atomic_mass=$(echo "$element_info" | awk '{print $4}')
        melting_point=$(echo "$element_info" | awk '{print $5}')
        boiling_point=$(echo "$element_info" | awk '{print $6}')
        type_id=$(echo "$element_info" | awk '{print $7}')

        # Print element information
        echo "The element with atomic number $atomic_number is $name ($symbol). It's a nonmetal, with a mass of $atomic_mass amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
    else
        # If element information does not exist, print error message
        echo "I could not find that element in the database."
    fi
}

# Call fetch_element_info function with the provided argument
fetch_element_info "$1"