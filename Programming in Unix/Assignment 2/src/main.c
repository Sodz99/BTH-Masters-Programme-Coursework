#include <stdio.h>
#include <stdlib.h>
#include "kmeans.h"
#include "input_utils.h"  // New header for input functions
#include "output_utils.h" // New header for output functions

/**
 * Main function to run the K-means clustering program.
 * Handles user input, reads data, initializes centroids, runs the algorithm, and writes output.
 */
int main() {
    int k, num_points;
    int dataset_choice;
    const char* dataset_file;

    // Get the dataset choice from the user
    dataset_choice = get_dataset_choice();
    if (dataset_choice == -1) {
        printf("Invalid choice. Exiting program.\n");
        return 1;
    }

    // Map the dataset choice to the corresponding file
    dataset_file = map_dataset_choice_to_file(dataset_choice);

    // Get the number of clusters from the user
    k = get_number_of_clusters();
    if (k <= 0) {
        printf("Invalid number of clusters. Exiting program.\n");
        return 1;
    }

    // Read data from the file
    Point* data = read_data(dataset_file, &num_points);
    if (data == NULL) {
        printf("Error reading data file. Exiting program.\n");
        return 1;
    }

    // Get initial centroids from the user
    Point* initial_centroids = get_initial_centroids(k);
    if (initial_centroids == NULL) {
        free(data);
        return 1;
    }

    // Run K-means clustering
    int* labels = kmeans_with_initial_centroids(data, num_points, k, initial_centroids);
    if (labels == NULL) {
        free(data);
        free(initial_centroids);
        return 1;
    }

    // Write the clustering result to a file
    write_output("kmeans-output.txt", data, labels, num_points);
    printf("Output file 'kmeans-output.txt' generated successfully.\n");

    // Free dynamically allocated memory
    free(data);
    free(labels);
    free(initial_centroids);

    return 0;
}

