# K-means Clustering Algorithm Implementation

## Overview

This project implements the K-means clustering algorithm in C as part of the BTH Masters Programme coursework for Programming in Unix. The implementation features a modular design with separate components for input handling, clustering logic, and output generation. The program supports multiple datasets and provides interactive centroid initialization.

## Features

- **Interactive Dataset Selection**: Choose from three available datasets
- **User-defined Initial Centroids**: Manually specify starting cluster centers
- **Modular Architecture**: Clean separation of concerns across multiple source files
- **Memory-efficient Implementation**: Optimized for large datasets with proper memory management
- **Comprehensive Output**: Detailed clustering results with cluster assignments
- **Development Tools Integration**: Makefile with debugging and memory checking targets

## Project Structure

```
Assignment 2/
├── src/
│   ├── main.c              # Main program entry point and execution flow
│   ├── kmeans.c            # Core K-means algorithm implementation
│   ├── input_utils.c       # User input and dataset selection handling
│   └── output_utils.c      # Results output and file writing functions
├── include/
│   ├── kmeans.h            # K-means data structures and function declarations
│   ├── input_utils.h       # Input utility function declarations
│   └── output_utils.h      # Output utility function declarations
├── data/
│   ├── kmeans-data.txt     # Standard dataset for testing
│   ├── large_kmeans_data_1.txt  # Large dataset for performance testing
│   └── large_kmeans_data_2.txt  # Alternative large dataset
├── Makefile               # Build automation and development tools
└── README.md              # This documentation file
```

## Prerequisites

- **Operating System**: Unix/Linux environment (tested on Ubuntu 24.04.01)
- **Compiler**: GCC (GNU Compiler Collection)
- **Build System**: GNU Make
- **Development Tools** (optional):
  - Valgrind (for memory leak detection)
  - GDB (for debugging)

## Quick Start

### Compilation

Navigate to the project directory and compile the program:

```bash
make
```

This creates an executable named `kmeans` in the project directory.

### Execution

Run the compiled program:

```bash
./kmeans
```

Follow the interactive prompts:

1. **Dataset Selection**: Choose from available datasets (1-3)
2. **Cluster Count**: Specify the desired number of clusters
3. **Initial Centroids**: Enter x,y coordinates for each cluster center

### Example Usage

```bash
$ ./kmeans

Select the dataset to run K-means clustering:
1. kmeans-data
2. large_kmeans_data_1  
3. large_kmeans_data_2
Enter your choice (1, 2, or 3): 1

Enter the number of clusters: 3

Enter the initial centroids (x, y) for each of the 3 clusters:
Centroid 1: 2.5, 3.0
Centroid 2: 5.0, 5.0  
Centroid 3: 7.5, 7.0

Processing... Clustering complete!
Results saved to kmeans-output.txt
```

## Build Targets

The Makefile provides several useful targets:

```bash
make          # Compile the program
make clean    # Remove object files and executable
make valgrind # Run memory leak detection
make gdb      # Start debugging session
```

## Output

The program generates `kmeans-output.txt` containing:
- Original data point coordinates
- Assigned cluster labels for each point
- Summary statistics (if applicable)

Console output includes:
- Progress indicators during clustering
- Warnings for empty clusters
- Convergence information

## Algorithm Implementation

The K-means implementation follows the standard iterative approach:

1. **Initialize** cluster centroids (user-defined)
2. **Assignment Step**: Assign each point to nearest centroid
3. **Update Step**: Recalculate centroid positions
4. **Convergence Check**: Repeat until centroids stabilize
5. **Output Results**: Generate final cluster assignments

## Performance Considerations

### Large Dataset Support

This implementation is optimized for handling large datasets:

- **Dynamic Memory Management**: Efficient allocation for variable dataset sizes
- **Optimized Distance Calculations**: Minimized computational overhead
- **Scalable Architecture**: Maintains performance with increasing data volume

### System Requirements

**Tested Environment**:
- OS: Ubuntu 24.04.01
- CPU: 20 cores
- RAM: 17 GB
- Storage: 20 GB

**Minimum Requirements**:
- RAM: 512 MB (for standard datasets), 2+ GB (for large datasets)
- Storage: 100 MB free space
- CPU: Any modern x86_64 processor

## Dataset Information

### Standard Dataset (`kmeans-data.txt`)
- Format: Two-column CSV (x, y coordinates)
- Size: ~23 KB
- Points: Moderate density, suitable for initial testing

### Large Datasets (`large_kmeans_data_*.txt`)
- Format: Two-column CSV (x, y coordinates)  
- Size: ~210 KB each
- Points: High-density datasets for performance evaluation
- Purpose: Algorithm robustness and scalability testing

## Development and Testing

### Debugging

Use GDB for step-through debugging:
```bash
make gdb
```

### Memory Analysis

Check for memory leaks with Valgrind:
```bash
make valgrind
```

### Performance Testing

The large datasets enable comprehensive testing of:
- **Algorithm Robustness**: Performance across varying data distributions
- **Memory Efficiency**: Dynamic allocation handling under load
- **Computational Scaling**: Processing time with increased data volume
- **Accuracy Validation**: Clustering quality across different scenarios

## Troubleshooting

### Common Issues

1. **Compilation Errors**
   - Ensure GCC is installed: `gcc --version`
   - Verify all source files are present
   - Check file permissions

2. **Runtime Errors**
   - Validate dataset file format (two columns, numeric data)
   - Ensure sufficient memory for large datasets
   - Check input format for centroids (comma-separated)

3. **Output Issues**
   - Verify write permissions in project directory
   - Check available disk space
   - Ensure dataset files are readable

### Error Messages

- `"Error reading dataset"`: Check file path and format
- `"Memory allocation failed"`: Insufficient system memory
- `"Invalid centroid format"`: Use comma-separated x,y coordinates



## 👤 Author

**Sohan Arun**  
Master’s Student, Computer Science  
Blekinge Institute of Technology, Sweden  
📧 [Sohanoffice46@gmail.com](mailto:Sohanoffice46@gmail.com)

