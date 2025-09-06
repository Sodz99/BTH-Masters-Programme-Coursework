#ifndef OUTPUT_UTILS_H
#define OUTPUT_UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include "kmeans.h"

/**
 * Function to write the clustering output to a file.
 * @param filename Name of the file to write the output to.
 * @param data Array of data points.
 * @param labels Array of cluster labels for each data point.
 * @param num_points Total number of data points.
 */
void write_output(const char* filename, Point* data, int* labels, int num_points);

#endif // OUTPUT_UTILS_H

