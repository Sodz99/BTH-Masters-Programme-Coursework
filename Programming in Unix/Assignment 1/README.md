
# Web Server Log Analysis Tool

**Course:** DV1457 Programming in UNIX Environments  
**Assignment:** 1310  
**Script:** `log_sum.sh`

## Overview

This bash script processes web server log files (specifically `thttpd.log`) to extract and analyze server activity information. The tool serves as a simple intrusion detection mechanism by identifying IP addresses with suspicious activity patterns, analyzing HTTP status codes, and monitoring data transfer patterns.

## Files

- `log_sum.sh` - Main bash script for log analysis
- `thttpd.log` - Sample web server log file (thttpd format)
- `Assignment_1310.pdf` - Assignment specification document
- `README.md` - This documentation file

## Usage

```bash
./log_sum.sh [-L N] (-c|-2|-r|-F|-t) <filename>
```

### Arguments

**Mandatory (choose one):**
- `-c` - List IP addresses with the most connection attempts
- `-2` - List IP addresses with the most successful connections (2xx status codes)
- `-r` - Show most common HTTP status codes and their source IPs
- `-F` - Show most common failure status codes (4xx/5xx) and their source IPs
- `-t` - List IP addresses that received the most bytes

**Optional:**
- `-L N` - Limit output to top N results (if not specified, shows all results)

### Examples

```bash
# Show top 10 IPs with most connection attempts
./log_sum.sh -L 10 -c thttpd.log

# Show all IPs with most successful connections
./log_sum.sh -2 thttpd.log

# Show top 5 most common failure codes with source IPs
./log_sum.sh -L 5 -F thttpd.log
```

## Output Format

- **-c option:** `xxx.xxx.xxx.xxx yyy` (IP address, connection count)
- **-2 option:** `xxx.xxx.xxx.xxx yyy` (IP address, successful connection count)
- **-r option:** `yyy xxx.xxx.xxx.xxx` (status code, IP address) - one IP per line
- **-F option:** `yyy xxx.xxx.xxx.xxx` (failure code, IP address) - one IP per line
- **-t option:** `xxx.xxx.xxx.xxx yyy` (IP address, total bytes received)

## Implementation Details

### Architecture

The script follows a modular approach with dedicated functions for each analysis type:

1. **Argument Parsing**: Uses `getopts` to handle command-line options
2. **Input Validation**: Checks for required arguments and file existence
3. **Data Processing**: Specialized functions using `awk`, `sort`, and `uniq`
4. **Output Formatting**: Consistent formatting across all analysis types

### Core Functions

- `most_connections_attempts()` - Analyzes connection frequency per IP
- `most_successful_attempts()` - Filters for 2xx status codes and counts by IP
- `most_common_result_codes()` - Groups and counts all HTTP status codes
- `most_failure_result_codes()` - Filters for 4xx/5xx codes and analyzes patterns
- `most_number_bytes()` - Sums byte transfers per IP address

### Log File Format

The script processes thttpd web server logs following the unified Apache combined log format:
1. IP address
2. Ident (always '-')
3. Username (HTTP authentication)
4. Date/time
5. Request line (in quotes)
6. HTTP status code
7. Bytes transferred
8. Referrer page
9. User agent string

### Key Features

- **Error Handling**: Validates arguments and file existence
- **Flexible Limiting**: Optional result limiting with `-L` parameter
- **Sorted Output**: All results sorted by frequency/count (descending)
- **Status Code Filtering**: Intelligent filtering for success/failure patterns
- **Memory Efficient**: Uses stream processing with standard UNIX tools

## Technical Implementation

The script leverages standard UNIX/Linux tools:
- `awk` for field extraction and pattern matching
- `sort` for ordering results
- `uniq -c` for counting occurrences
- `head` for limiting output when `-L` is specified

Status code patterns:
- Successful: `^2[0-9]{2}$` (200-299 range)
- Failure: `^[45][0-9]{2}$` (400-499 and 500-599 ranges)

## Requirements

- Bash shell environment
- Standard UNIX tools (awk, sort, uniq, head)
- Read access to log files
- Execute permission on the script


  ## 👤 Author

**Sohan Arun**  
Master’s Student, Computer Science  
Blekinge Institute of Technology, Sweden  
📧 [Sohanoffice46@gmail.com](mailto:Sohanoffice46@gmail.com)

