# Compiler settings
NVCC = nvcc
GCC = gcc
CFLAGS = -O3
CUDA_FLAGS = -O3

# File names
CPU_SOURCE = cpu_vector_add.c
GPU_SOURCE = vector_add.cu
TOY_SOURCE = toy.cu
CPU_EXEC = cpu
GPU_EXEC = gpu
TOY_EXEC = toy

# Default target
all: cpu gpu toy

# CPU target
cpu: $(CPU_SOURCE)
	$(GCC) $(CFLAGS) $(CPU_SOURCE) -o $(CPU_EXEC)

# GPU target
gpu: $(GPU_SOURCE)
	$(NVCC) $(CUDA_FLAGS) $(GPU_SOURCE) -o $(GPU_EXEC)

# Toy target
toy: $(TOY_SOURCE)
	$(NVCC) $(CUDA_FLAGS) $(TOY_SOURCE) -o $(TOY_EXEC)

# Clean target
clean:
	rm -f $(CPU_EXEC) $(GPU_EXEC) $(TOY_EXEC)

# Phony targets
.PHONY: all cpu gpu toy clean