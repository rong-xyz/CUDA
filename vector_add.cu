#include <stdio.h>
#include <cuda_runtime.h>
#include <chrono>

__global__ void vectorAdd(const float *A, const float *B, float *C, int numElements)
{
    int i = blockDim.x * blockIdx.x + threadIdx.x;
    if (i < numElements)
    {
        C[i] = A[i] + B[i];
    }
}

int main(void)
{
    int numElements = 50000000;  // Increased for better timing
    size_t size = numElements * sizeof(float);

    // Timing variables
    cudaEvent_t start, stop, total_start, total_stop;
    float milliseconds = 0, total_milliseconds = 0;
    auto cpu_start = std::chrono::high_resolution_clock::now();

    // Create CUDA events for total time
    cudaEventCreate(&total_start);
    cudaEventCreate(&total_stop);
    
    // Start total time measurement
    cudaEventRecord(total_start);

    // Allocate host memory
    float *h_A = (float *)malloc(size);
    float *h_B = (float *)malloc(size);
    float *h_C = (float *)malloc(size);

    // Initialize host arrays
    for (int i = 0; i < numElements; ++i)
    {
        h_A[i] = i;
        h_B[i] = i * 2;
    }

    auto cpu_end = std::chrono::high_resolution_clock::now();
    auto cpu_duration = std::chrono::duration_cast<std::chrono::milliseconds>(cpu_end - cpu_start);
    printf("CPU Initialization: %ld ms\n", cpu_duration.count());

    // Create CUDA events
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    // Allocate device memory
    cudaEventRecord(start);
    float *d_A, *d_B, *d_C;
    cudaMalloc((void **)&d_A, size);
    cudaMalloc((void **)&d_B, size);
    cudaMalloc((void **)&d_C, size);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("GPU Memory Allocation: %.2f ms\n", milliseconds);

    // Copy host arrays to device
    cudaEventRecord(start);
    cudaMemcpy(d_A, h_A, size, cudaMemcpyHostToDevice);
    cudaMemcpy(d_B, h_B, size, cudaMemcpyHostToDevice);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("Data Transfer (Host to Device): %.2f ms\n", milliseconds);

    // Launch kernel
    int threadsPerBlock = 256;
    int blocksPerGrid = (numElements + threadsPerBlock - 1) / threadsPerBlock;
    cudaEventRecord(start);
    vectorAdd<<<blocksPerGrid, threadsPerBlock>>>(d_A, d_B, d_C, numElements);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("Kernel Execution: %.2f ms\n", milliseconds);

    // Copy result back to host
    cudaEventRecord(start);
    cudaMemcpy(h_C, d_C, size, cudaMemcpyDeviceToHost);
    cudaEventRecord(stop);
    cudaEventSynchronize(stop);
    cudaEventElapsedTime(&milliseconds, start, stop);
    printf("Data Transfer (Device to Host): %.2f ms\n", milliseconds);

    // Stop total time measurement
    cudaEventRecord(total_stop);
    cudaEventSynchronize(total_stop);
    cudaEventElapsedTime(&total_milliseconds, total_start, total_stop);
    printf("Total GPU Time: %.2f ms\n", total_milliseconds);

    // Free device memory
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);

    // Free host memory
    free(h_A);
    free(h_B);
    free(h_C);

    // Destroy CUDA events
    cudaEventDestroy(start);
    cudaEventDestroy(stop);
    cudaEventDestroy(total_start);
    cudaEventDestroy(total_stop);

    return 0;
}