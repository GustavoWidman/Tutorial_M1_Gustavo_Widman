// C++ Project #1.cpp : This file contains the 'main' function. Program execution begins and ends there. 
// 

#include <iostream>
#include <algorithm>
#include <chrono>
#include <thread>
#include <mutex>

/* here we have a c++ program that, when run, prompts the user
for a input of a array size, determining the array size to that int.
after that, the program prompts the user "array size" times and fills
in the array with user input. after the array is full, the program
prompts the user if they would like to sort their array. if not, the
program prints out the user's array, unordered, and prompts to press
enter to close the program (END). if however, the user chooses to
sort his array, the program prompts the user what sorting algorithm
they would like to use, having mergesort, quicksort, bubble sort
and bogosort as options (more will be added). once the user prompts a
sorting algorithm, the program sorts the user-inputted array and prints
out: the sorted array, the execution time and the used sorting algorithm's
name, and complexity values */


// here we have the sorting algorithms
// the sorting algorithms are: bubble sort, bogosort, mergesort and quicksort

// first, we have the bubblesort algorithm. it doesnt return anything because it sorts the array in place but we want to return the sorted array
// in order to do that we need to pass the array by reference (using pointers) and return the array itself like so
int* bubbleSort(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        for (int j = 0; j < n - i - 1; j++) {
            if (arr[j] > arr[j + 1]) {
				int temp = arr[j];
				arr[j] = arr[j + 1];
				arr[j + 1] = temp;
			}
		}
	}
	// here we pass the array by reference (using pointers) and return the array itself
	return arr;
}

bool isSorted(int arr[], int n) {
    for (int i = 0; i < n - 1; i++) {
        if (arr[i] > arr[i + 1]) {
            return false;
        }
    }
    return true;
}

// here we have the bogosort function that calls the isSorted function, it doesnt return anything because it sorts the array in place but we want to return the sorted array
// in order to do that we need to pass the array by reference (using pointers) and return the array itself like so
int* bogoSort(int arr[], int n) {
    int count = 0;
    while (!isSorted(arr, n)) {
        for (int i = 0; i < n; i++) {
            std::random_shuffle(arr, arr + n);
            count++;
        }
    }

    std::cout << "The algorithm went through " << count << " iterations" << std::endl;
    // here we pass the array by reference (using pointers) and return the array itself
    return arr;
}

// next, we have the mergesort algorithm
void merge(int arr[], int l, int m, int r) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;
    int* L = new int[n1];
    int* R = new int[n2];
    for (i = 0; i < n1; i++) {
		L[i] = arr[l + i];
	}

    for (j = 0; j < n2; j++) {
        R[j] = arr[m + 1 + j];
    }
    i = 0;
    j = 0;
    k = l;
    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        }
        else {
            arr[k] = R[j];
            j++;
        }
        k++;
    }
    while (i < n1) {
        arr[k] = L[i];
        i++;
        k++;
    }
    while (j < n2) {
        arr[k] = R[j];
        j++;
        k++;
    }
}

// here we have the mergesort function that calls the merge function, it doesnt return anything because it sorts the array in place but we want to return the sorted array
// in order to do that we need to pass the array by reference (using pointers) and return the array itself like so
int* mergeSort(int arr[], int l, int r) {
    if (l < r) {
		int m = l + (r - l) / 2;
		mergeSort(arr, l, m);
		mergeSort(arr, m + 1, r);
		merge(arr, l, m, r);
	}
	// here we pass the array by reference (using pointers) and return the array itself
	return arr;
}


// finally, we have the quicksort algorithm
int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {
        if (arr[j] < pivot) {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
        }
    }
    int temp = arr[i + 1];
    arr[i + 1] = arr[high];
    arr[high] = temp;
    return (i + 1);
}

// here we have the quicksort function that calls the partition function, it doesnt return anything because it sorts the array in place but we want to return the sorted array
// in order to do that we need to pass the array by reference (using pointers) and return the array itself like so
int* quickSort(int arr[], int low, int high) {
    if (low < high) {
		int pi = partition(arr, low, high);
		quickSort(arr, low, pi - 1);
		quickSort(arr, pi + 1, high);
	}
    return arr;
}

// here we have the function that determines the array size
int determine_size() {
    int array_size = 0;
    std::cout << "What size would you like your array to be? ";
    std::cin >> array_size;
    return array_size;
}

int* sleepsort(int arr[], int n) {
	std::thread* threads = new std::thread[n]; // this is the array of threads
    int* result = new int[n]; // this is the sorted array
    std::mutex mtx; // this is the mutex
    int sorted_index = 0; // this is the sorted index   
    for (int i = 0; i < n; i++) {
        threads[i] = std::thread([arr, i, &result, &sorted_index, &mtx]() {
			std::this_thread::sleep_for(std::chrono::milliseconds(arr[i])); // this is the sleep function
            std::unique_lock<std::mutex> lock(mtx);
            // here we append the number to the sorted array
            result[sorted_index++] = arr[i];
            std::cout << "Current: " << arr[i] << std::endl;
            lock.unlock();
		});
	}
    for (int i = 0; i < n; i++) {
		threads[i].join();
	}
    for (int i = 0; i < n; i++) {
        std::cout << result[i] << " ";
    }
	return result;
}

// A function to do counting sort of arr[] according to 
// the digit represented by exp. 
int* countingSort(int arr[], int n, int exp)
{
    int* output = new int[n]; // output array 
    int i;
    int count[10] = { 0 };

    // Store count of occurrences in count[] 
    for (i = 0; i < n; i++)
        count[(arr[i] / exp) % 10]++;

    // Change count[i] so that count[i] now contains actual 
    //  position of this digit in output array 
    for (i = 1; i < 10; i++)
        count[i] += count[i - 1];

    // Build the output array 
    for (i = n - 1; i >= 0; i--)
    {
        output[count[(arr[i] / exp) % 10] - 1] = arr[i];
        count[(arr[i] / exp) % 10]--;
    }

    // Copy the output array to arr[], so that arr[] now 
    // contains sorted numbers according to current digit 
    for (i = 0; i < n; i++)
        arr[i] = output[i];

    return output;
}


// here we implement radix sort
int* radixSort(int arr[], int n)
{
    // Find the maximum number to know number of digits 
    int m = arr[0];
    for (int i = 1; i < n; i++)
        if (arr[i] > m)
            m = arr[i];

    // Do counting sort for each digit. Note that instead 
    // of passing digit number, exp is passed. exp is 10^i 
    // where i is current digit number 
    for (int exp = 1; m / exp > 0; exp *= 10)
        countingSort(arr, n, exp);

    // in order to extract the result, we need to 
    // here we print the sorted array
    // pass the array by reference (using pointers)
    for (int i = 0; i < n; i++) {
		std::cout << arr[i] << " ";
	}
    return arr;
}



// here we have the main function
int main() {
    // here we have the variables
    int user_input; // this is the user input
    int sorting_algorithm; // this is the sorting algorithm

    int array_size = determine_size(); // this is the array size (the size of the array that the user inputs)


    int* user_array = new int[array_size]; // this is the user array (the array that the user inputs)
    int* sorted_array = new int[array_size]; // this is the sorted array (the array that the user inputs, but sorted

    std::cout << "Please enter " << array_size << " numbers: ";
    for (int i = 0; i < array_size; i++) {
        std::cin >> user_array[i];
    }
    std::cout << "Would you like to sort your array? (1 = yes, 0 = no): ";
    std::cin >> user_input;
    if (user_input == 0) {
        std::cout << "Your array is: ";
        for (int i = 0; i < array_size; i++) {
            std::cout << user_array[i] << " ";
        }
        std::cout << "Press ENTER to close the program...";
        std::cin.get();
        std::cin.get();
        return 0;
    }
    else {
        std::cout << "What sorting algorithm would you like to use? (1 = bubble sort, 2 = bogosort, 3 = mergesort, 4 = quicksort, 5 = sleepsort, 6 = radixsort): ";
        std::cin >> sorting_algorithm;
        if (sorting_algorithm == 1) {
            std::cout << "Your array is being sorted with bubble sort...";
            auto start = std::chrono::high_resolution_clock::now();
            bubbleSort(user_array, array_size);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << " microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(n) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(n^2) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(n^2) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: Bubble Sort" << std::endl;
            std::cout << "Your array is: ";
            for (int i = 0; i < array_size; i++) {
                std::cout << user_array[i] << " ";
            }
            std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
        else if (sorting_algorithm == 2) {
            std::cout << "Your array is being sorted with bogosort...";
            auto start = std::chrono::high_resolution_clock::now();
            sorted_array = bogoSort(user_array, array_size);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << " microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(n) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(n!) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(n!) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: Bogosort" << std::endl;
            std::cout << "Your array is: ";
            for (int i = 0; i < array_size; i++) {
                std::cout << user_array[i] << " ";
            }
            std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
        else if (sorting_algorithm == 3) {
			std::cout << "Your array is being sorted with mergesort...";
            auto start = std::chrono::high_resolution_clock::now();
            sorted_array = mergeSort(user_array, 0, array_size - 1);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << " microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(n log n) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(n log n) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(n log n) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: Mergesort" << std::endl;
			std::cout << "Your array is: ";
            // the array isnt showing up sorted because the array is being sorted in the function, but the array is not being returned
            // to fix this, we need to return the array from the function as a pointer and then assign it to the sorted array
			for (int i = 0; i < array_size; i++) {
				std::cout << user_array[i] << " ";
			}
			std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
        else if (sorting_algorithm == 4) {
            std::cout << "Your array is being sorted with quicksort...";
            auto start = std::chrono::high_resolution_clock::now();
            sorted_array = quickSort(user_array, 0, array_size - 1);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << " microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(n log n) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(n log n) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(n^2) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: Quicksort" << std::endl;
            std::cout << "Your array is: ";
            // the array isnt showing up sorted because the array is being sorted in the function, but the array is not being returned
            // to fix this, we need to return the array from the function as a pointer and then assign it to the sorted array
            for (int i = 0; i < array_size; i++) {
                std::cout << user_array[i] << " ";
            }
            std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
        else if (sorting_algorithm == 5) {
            std::cout << "Your array is being sorted with sleepsort...";
            auto start = std::chrono::high_resolution_clock::now();
            sorted_array = sleepsort(user_array, array_size);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << "microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(?) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(?) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(?) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: SleepSort" << std::endl;
            std::cout << "Your array is: ";
            for (int i = 0; i < array_size; i++) {
                std::cout << sorted_array[i] << " ";
            }
            std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
		}
        else if (sorting_algorithm == 6) {
            std::cout << "Your array is being sorted with radixSort...";
            auto start = std::chrono::high_resolution_clock::now();
            sorted_array = radixSort(user_array, array_size);
            auto stop = std::chrono::high_resolution_clock::now();
            auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop - start);
            std::cout << "The execution time of the algorithm is: " << duration.count() << "microseconds" << std::endl;
            std::cout << "Best Case Scenario: O(nk) Complexity" << std::endl;
            std::cout << "Average Case Scenario: O(nk) Complexity" << std::endl;
            std::cout << "Worst Case Scenario: O(nk) Complexity" << std::endl;
            std::cout << "The name of the algorithm is: radixSort" << std::endl;
            std::cout << "Your array is: ";
            for (int i = 0; i < array_size; i++) {
                std::cout << sorted_array[i] << " ";
            }
            std::cout << std::endl << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
		else {
			std::cout << "Invalid input. Please try again.";
			std::cout << "Press ENTER to close the program...";
            std::cin.get();
            std::cin.get();
            return 0;
        }
    }
}