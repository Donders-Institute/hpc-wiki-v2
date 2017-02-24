#!/bin/bash

## check if data file path is given from command argument
if [ $# -lt 1 ]; then
    echo "data file required." 1>&2 
    exit 1
fi

## get data file from command line
f_data=$1

## TODO: check file existance, if not existing:
##       - print an error 
##       - return non-zero number
if [ ! -f $f_data ]; then
    echo "file not found: $f_data" 1>&2
    exit 2
fi

## TODO: get total number of completed jobs
total_jobs=$( cat $f_data | awk 'BEGIN {s = 0;} { s = s + $3 + $4; } END {print s; }' )

## TODO: implement the function which takes uid and data file as arguments and returns the total completed jobs of the user
##  - argument 1: the data file
##  - argument 2: the user id
function get_total_jobs {
    grep $2 $1 | awk 'BEGIN {s = 0;} { s = s + $3 + $4; } END {print s; }'
}

## TODO:
##  - make a for loop that iterates over a list of uniq user ids retrieved from the data file
##  - for each user, call the "get_total_jobs" function to get the job completed by the user
##  - use the utility "bc" with option "-l" to compute the personal cluster usage in terms of completed jobs
for u in $( cat $f_data | awk '{print $2}' | sort | uniq ); do

    u_total=$( get_total_jobs $f_data $u )
    p_total=$(  echo "scale=2; 100 * $u_total  / ($total_jobs)" | bc -l )

    echo "$u $u_total ($p_total)"
done

exit 0
