#ifndef KMEANS_H
#define KMEANS_H

/**
 * Structure to represent a 2D point.
 */
typedef struct {
    double x, y;  // Coordinates of the point
} Point;

/**
 * Function to read data points from a file.
 * @param filename Name of the file containing the data points.
 * @param num_points Pointer to an integer where the number of points will be stored.
 * @return A pointer to an array of Points read from the file, or NULL on error.
 */
Point* read_data(const char* filename, int* num_points);

/**
 * Function to write the clustering output to a file.
 * @param filename Name of the file to write the output to.
 * @param data Array of data points.
 * @param labels Array of cluster labels for each data point.
 * @param num_points Total number of data points.
 */
void write_output(const char* filename, Point* data, int* labels, int num_points);

/**
 * Function to perform K-means clustering with user-defined initial centroids.
 * @param data Array of data points.
 * @param num_points Total number of data points.
 * @param k Number of clusters.
 * @param initial_centroids Array of initial centroids provided by the user.
 * @return Array of labels indicating cluster assignments for each data point.
 */
int* kmeans_with_initial_centroids(Point* data, int num_points, int k, Point* initial_centroids);

/**
 * Function to calculate the Euclidean distance between two points.
 * @param p1 The first point.
 * @param p2 The second point.
 * @return The Euclidean distance between p1 and p2.
 */
double distance(Point p1, Point p2);

/**
 * Function to recalculate centroids based on the current cluster assignments.
 * @param data Array of data points.
 * @param labels Array indicating the cluster each data point belongs to.
 * @param centroids Array to store the recalculated centroids.
 * @param num_points Total number of data points.
 * @param k Number of clusters.
 */
void calculate_centroids(Point* data, int* labels, Point* centroids, int num_points, int k);

#endif  // KMEANS_H

