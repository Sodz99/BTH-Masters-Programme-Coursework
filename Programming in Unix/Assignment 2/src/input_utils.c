#include "input_utils.h"
#include <stdio.h>
#include <stdlib.h>
#include "kmeans.h"

/**
 * Function to prompt and get the dataset choice from the user.
 * @return The dataset choice as an integer, or -1 if the input is invalid.
 */
int get_dataset_choice() {
    int choice;
    printf("Select the dataset to run K-means clustering:\n");
    printf("1. kmeans-data\n");
    printf("2. large_kmeans_data_1\n");
    printf("3. large_kmeans_data_2\n");
    printf("Enter your choice (1, 2, or 3): ");
    if (scanf("%d", &choice) != 1 || choice < 1 || choice > 3) {
        return -1;  // Invalid choice
    }
    return choice;
}

/**
 * Function to map the user's dataset choice to the corresponding file name.
 * @param choice The dataset choice input by the user.
 * @return A string representing the file name of the chosen dataset.
 */
const char* map_dataset_choice_to_file(int choice) {
    switch (choice) {
        case 1: return "data/kmeans-data.txt";
        case 2: return "data/large_kmeans_data_1.txt";
        case 3: return "data/large_kmeans_data_2.txt";
        default: return NULL;  // Invalid choice
    }
}

/**
 * Function to prompt and get the number of clusters from the user.
 * @return The number of clusters as an integer.
 */
int get_number_of_clusters() {
    int k;
    printf("Enter the number of clusters: ");
    if (scanf("%d", &k) != 1 || k <= 0) {
        printf("Invalid number of clusters. Please enter a positive integer.\n");
        return -1;  // Invalid input
    }
    return k;
}

/**
 * Function to prompt and get the initial centroids from the user.
 * @param k The number of clusters.
 * @return A pointer to an array of Point structures representing initial centroids, or NULL if an error occurs.
 */
Point* get_initial_centroids(int k) {
    Point* centroids = malloc(k * sizeof(Point));
    if (centroids == NULL) {
        perror("Memory allocation failed for initial centroids");
        return NULL;
    }

    printf("Enter the initial centroids (x, y) for each of the %d clusters:\n", k);
    for (int i = 0; i < k; i++) {
        printf("Centroid %d: ", i + 1);
        if (scanf("%lf, %lf", &centroids[i].x, &centroids[i].y) != 2) {
            printf("Invalid input for centroid coordinates. Please use the format (x, y).\n");
            free(centroids);
            return NULL;
        }
    }

    return centroids;
}

/**
 * Function to read data points from a file.
 * @param filename Name of the file containing the data points.
 * @param num_points Pointer to an integer where the number of points will be stored.
 * @return A pointer to an array of Points read from the file, or NULL on error.
 */
Point* read_data(const char* filename, int* num_points) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening file");
        return NULL;
    }

    int capacity = 1000;
    *num_points = 0;
    Point* data = malloc(capacity * sizeof(Point));
    if (data == NULL) {
        perror("Memory allocation failed for data array");
        fclose(file);
        return NULL;
    }

    double x, y;
    while (fscanf(file, "%lf %lf", &x, &y) == 2) {
        if (*num_points >= capacity) {
            capacity *= 2;
            Point* temp = realloc(data, capacity * sizeof(Point));
            if (temp == NULL) {
                perror("Memory allocation failed during resizing");
                free(data);
                fclose(file);
                return NULL;
            }
            data = temp;
        }
        data[*num_points].x = x;
        data[*num_points].y = y;
        (*num_points)++;
    }

    if (ferror(file)) {
        perror("Error reading data file");
        free(data);
        fclose(file);
        return NULL;
    }

    fclose(file);
    return data;
}

