//
// Created by Daniel Simon on 7/18/19.
//

#ifndef CUDATEST_CUDA_LIBRARY_H
#define CUDATEST_CUDA_LIBRARY_H

#include <cuda_runtime.h>

namespace cuda {

__global__ void Kernel_cu(const float* x, float* y, int n, float a, float b);

cudaError_t Kernel(const float* x, float* y, int n, float a, float b);

}

#endif //CUDATEST_CUDA_LIBRARY_H
