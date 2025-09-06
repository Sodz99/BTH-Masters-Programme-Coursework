#ifndef INPUT_UTILS_H
#define INPUT_UTILS_H

#include <stdio.h>
#include <stdlib.h>
#include "kmeans.h"

/**
 * Function to prompt and get the dataset choice from the user.
 * @return The dataset choice as an integer, or -1 if the input is invalid.
 */
int get_dataset_choice();

/**
 * Function to map the user's dataset choice to the corresponding file name.
 * @param choice The dataset choice input by the user.
 * @return A string representing the file name of the chosen dataset.
 */
const char* map_dataset_choice_to_file(int choice);

/**
 * Function to prompt and get the number of clusters from the user.
 * @return The number of clusters as an integer.
 */
int get_number_of_clusters();

/**
 * Function to prompt and get the initial centroids from the user.
 * @param k The number of clusters.
 * @return A pointer to an array of Point structures representing initial centroids, or NULL if an error occurs.
 */
Point* get_initial_centroids(int k);

#endif // INPUT_UTILS_H

