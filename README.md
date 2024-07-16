# Vector Addition: CPU vs GPU Performance Comparison

This repository contains implementations of vector addition in both CPU (C) and GPU (CUDA) to demonstrate and compare their performance characteristics.

## Project Structure

- `cpu_vector_add.c`: CPU implementation of vector addition
- `vector_add.cu`: GPU (CUDA) implementation of vector addition
- `toy.cu`: A toy CUDA program for testing and learning purposes
- `Makefile`: Compilation instructions for all programs

## Requirements

- GCC compiler for CPU code
- NVIDIA CUDA Toolkit for GPU code
- Make utility

## Compilation

Use the provided Makefile to compile the programs:

- To compile all programs: `make` or `make all`
- To compile only the CPU version: `make cpu`
- To compile only the GPU version: `make gpu`
- To compile only the toy CUDA program: `make toy`
- To clean up compiled executables: `make clean`

## Usage

After compilation, you can run the programs as follows:

- CPU version: `./cpu`
- GPU version: `./gpu`
- Toy CUDA program: `./toy`

## Program Descriptions

### CPU Vector Addition (`cpu_vector_add.c`)

This program performs vector addition on the CPU. It includes timing measurements for:
- Memory allocation
- Array initialization
- Vector addition operation
- Total execution time

### GPU Vector Addition (`vector_add.cu`)

This CUDA program performs vector addition on the GPU. It includes timing measurements for:
- Memory allocation (on GPU)
- Data transfer (Host to Device and Device to Host)
- Kernel execution (actual vector addition)
- Total execution time

### Toy CUDA Program (`toy.cu`)

This is a simple CUDA program for learning and testing purposes. It may demonstrate basic CUDA concepts or serve as a template for further CUDA development.

## Performance Comparison

Run both the CPU and GPU versions and compare their execution times. Note that:
- The GPU version includes data transfer overhead, which may impact performance for smaller datasets.
- The GPU version is expected to perform better for larger datasets or more complex operations.

## Optimization Notes

- Both CPU and GPU versions use the `-O3` optimization flag.