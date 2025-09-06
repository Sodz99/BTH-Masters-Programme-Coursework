#include "output_utils.h"

/**
 * Function to write the clustering output to a file.
 * Ensures robust file handling and error checking.
 * @param filename Name of the file to write the output to.
 * @param data Array of data points.
 * @param labels Array of cluster labels for each data point.
 * @param num_points Total number of data points.
 */
void write_output(const char* filename, Point* data, int* labels, int num_points) {
    FILE* file = fopen(filename, "w");
    if (file == NULL) {
        perror("Error opening output file");
        return;
    }

    for (int i = 0; i < num_points; i++) {
        if (fprintf(file, "%lf %lf %d\n", data[i].x, data[i].y, labels[i]) < 0) {
            perror("Error writing to output file");
            fclose(file);
            return;
        }
    }

    fclose(file);
}

