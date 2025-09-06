#!/bin/bash

# Display usage information
usage() {
    echo "SYNTAX ERROR,
    use in this format: $0 [-L N] (-c|-2|-r|-F|-t) <filename>"
    exit 1
}

# Checks if command have enough arguments
if [[ $# -lt 2 ]]; then
    usage
fi

# defining variables
LIMIT=""
FILENAME=""
OPTION=""

# Parse options using getopts
while getopts "L:c2rFt" opt; do
    case $opt in
        L) LIMIT=$OPTARG ;;    # Set the limit for number of results
        c) OPTION="c" ;;        # Option to list IPs with the most connection attempts
        2) OPTION="2" ;;        # Option to list IPs with most successful connections
        r) OPTION="r" ;;        # Option to list common result codes with their IPs
        F) OPTION="F" ;;        # Option to list common failure result codes with their IPs
        t) OPTION="t" ;;        # Option to list IPs receiving the most bytes
        \?) usage ;;            # Handle invalid options
    esac
done
shift $((OPTIND-1))

# Checks if the filename is provided after argument
if [[ -z "$1" ]]; then
    usage
else
    FILENAME=$1
fi

# Checks if the file exists or not
if [[ ! -f "$FILENAME" ]]; then
    echo "Error: File '$FILENAME' not found!"
    exit 1
fi

# Function to handle the -c argument(most connection attempts)
most_connections_attempts() {
    if [[ -n "$LIMIT" ]]; then
        awk '{print $1}' "$FILENAME" | sort | uniq -c | sort -nr | head -n "$LIMIT" | awk '{print $2, $1}'
    else
        awk '{print $1}' "$FILENAME" | sort | uniq -c | sort -nr | awk '{print $2, $1}'
    fi
}

# Function to handle the -2 arguments (most successful connections)
most_successful_attempts() {
    if [[ -n "$LIMIT" ]]; then
        awk '$9 ~ /^2[0-9]{2}$/{print $1}' "$FILENAME" | sort | uniq -c | sort -nr | head -n "$LIMIT" | awk '{print $2, $1}'
    else
        awk '$9 ~ /^2[0-9]{2}$/{print $1}' "$FILENAME" | sort | uniq -c | sort -nr | awk '{print $2, $1}'
    fi
}

# Function to handle the -r arguments (common result codes with IPs)
most_common_result_codes() {
    awk '{print $9, $1}' "$FILENAME" | sort | uniq -c | sort -nr |
    awk -v limit="$LIMIT" '
    {
        codes[$2]++;
        if (codes[$2] <= limit || limit == "") {
            print $2, $3;
        }
    }' | sort -n
}

# Function to handle the -F arguments (failure result codes with IPs)
most_failure_result_codes() {
    awk '$9 ~ /^[45][0-9]{2}$/{print $9, $1}' "$FILENAME" | sort | uniq -c | sort -nr |
    awk -v limit="$LIMIT" '
    {
        codes[$2]++;
        if (codes[$2] <= limit || limit == "") {
            print $2, $3;
        }
    }' | sort -n
}

# Function to handle the -t arguments (most bytes sent)
most_number_bytes() {
    if [[ -n "$LIMIT" ]]; then
        awk '{if($10 != "-") print $1, $10}' "$FILENAME" | awk '{sum[$1]+=$2} END {for (ip in sum) print sum[ip], ip}' | sort -nr -k1 | head -n "$LIMIT" | awk '{print $2, $1}'
    else
        awk '{if($10 != "-") print $1, $10}' "$FILENAME" | awk '{sum[$1]+=$2} END {for (ip in sum) print sum[ip], ip}' | sort -nr -k1 | awk '{print $2, $1}'
    fi
}

# Execute the appropriate function based on the selected arguments
case $OPTION in
    c) most_connections_attempts ;;
    2) most_successful_attempts ;;
    r) most_common_result_codes ;;
    F) most_failure_result_codes ;;
    t) most_number_bytes ;;
    *) usage ;;
esac
