#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "kmeans.h"

/**
 * Function to calculate the Euclidean distance between two points.
 * @param p1 The first point.
 * @param p2 The second point.
 * @return The Euclidean distance between p1 and p2.
 */
double distance(Point p1, Point p2) {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

/**
 * Function to recalculate centroids based on the current cluster assignments.
 * @param data Array of data points.
 * @param labels Array indicating the cluster each data point belongs to.
 * @param centroids Array to store the recalculated centroids.
 * @param num_points Total number of data points.
 * @param k Number of clusters.
 */
void calculate_centroids(Point* data, int* labels, Point* centroids, int num_points, int k) {
    int* counts = calloc(k, sizeof(int));
    if (counts == NULL) {
        perror("Memory allocation failed for counts array");
        exit(1);
    }

    Point* new_centroids = calloc(k, sizeof(Point));
    if (new_centroids == NULL) {
        perror("Memory allocation failed for new_centroids array");
        free(counts);
        exit(1);
    }

    for (int i = 0; i < num_points; i++) {
        int label = labels[i];
        new_centroids[label].x += data[i].x;
        new_centroids[label].y += data[i].y;
        counts[label]++;
    }

    for (int i = 0; i < k; i++) {
        if (counts[i] > 0) {
            centroids[i].x = new_centroids[i].x / counts[i];
            centroids[i].y = new_centroids[i].y / counts[i];
        } else {
            fprintf(stderr, "Warning: Cluster %d has no points assigned.\n", i);
        }
    }

    free(new_centroids);
    free(counts);
}

/**
 * Function to perform K-means clustering with user-defined initial centroids.
 * @param data Array of data points.
 * @param num_points Total number of data points.
 * @param k Number of clusters.
 * @param initial_centroids Array of initial centroids provided by the user.
 * @return Array of labels indicating cluster assignments for each data point.
 */
int* kmeans_with_initial_centroids(Point* data, int num_points, int k, Point* initial_centroids) {
    if (num_points == 0 || k > num_points) {
        fprintf(stderr, "Invalid configuration: zero data points or more clusters than points.\n");
        return NULL;
    }

    Point* centroids = malloc(k * sizeof(Point));
    if (centroids == NULL) {
        perror("Memory allocation failed for centroids array");
        return NULL;
    }
    int* labels = calloc(num_points, sizeof(int));
    if (labels == NULL) {
        perror("Memory allocation failed for labels array");
        free(centroids);
        return NULL;
    }

    for (int i = 0; i < k; i++) {
        centroids[i] = initial_centroids[i];
    }

    int changed;
    do {
        changed = 0;
        for (int i = 0; i < num_points; i++) {
            double min_dist = distance(data[i], centroids[0]);
            int label = 0;
            for (int j = 1; j < k; j++) {
                double dist = distance(data[i], centroids[j]);
                if (dist < min_dist) {
                    min_dist = dist;
                    label = j;
                }
            }

            if (labels[i] != label) {
                labels[i] = label;
                changed = 1;
            }
        }

        calculate_centroids(data, labels, centroids, num_points, k);
    } while (changed);

    free(centroids);
    return labels;
}

