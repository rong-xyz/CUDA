#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void vectorAdd(const float *A, const float *B, float *C, int numElements)
{
    for (int i = 0; i < numElements; i++)
    {
        C[i] = A[i] + B[i];
    }
}

int main(void)
{
    int numElements = 50000000;
    size_t size = numElements * sizeof(float);
    clock_t start, end, total_start, total_end;
    double cpu_time_used, total_time_used;

    // Start total time measurement
    total_start = clock();

    // Allocate memory
    start = clock();
    float *h_A = (float *)malloc(size);
    float *h_B = (float *)malloc(size);
    float *h_C = (float *)malloc(size);
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC * 1000.0;
    printf("CPU Memory Allocation: %.2f ms\n", cpu_time_used);

    // Initialize arrays
    start = clock();
    for (int i = 0; i < numElements; ++i)
    {
        h_A[i] = i;
        h_B[i] = i * 2;
    }
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC * 1000.0;
    printf("CPU Initialization: %.2f ms\n", cpu_time_used);

    // Perform vector addition
    start = clock();
    vectorAdd(h_A, h_B, h_C, numElements);
    end = clock();
    cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC * 1000.0;
    printf("CPU Vector Addition: %.2f ms\n", cpu_time_used);

    // End total time measurement
    total_end = clock();
    total_time_used = ((double) (total_end - total_start)) / CLOCKS_PER_SEC * 1000.0;
    printf("Total CPU Time: %.2f ms\n", total_time_used);

    // Free memory
    free(h_A);
    free(h_B);
    free(h_C);

    return 0;
}