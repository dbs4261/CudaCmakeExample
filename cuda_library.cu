//
// Created by Daniel Simon on 7/18/19.
//

#include "cuda_library.cuh"

namespace cuda {

__global__ void Kernel_cu(const float* x, float* y, int n, float a, float b) {
  int idx = threadIdx.x + blockIdx.x * blockDim.x;
  y[idx] = a * x[idx] + b;
}

cudaError_t Kernel(const float* x, float* y, int n, float a, float b) {
  float* x_cu;
  float* y_cu;
  cudaMalloc(&x_cu, sizeof(float) * n);
  cudaMemcpy(x_cu, x, sizeof(float) * n, cudaMemcpyHostToDevice);
  cudaMalloc(&y_cu, sizeof(float) * n);
  Kernel_cu<<<n / 128, 128>>>(x_cu, y_cu, n, a, b);
  cudaMemcpy(y, y_cu, sizeof(float) * n, cudaMemcpyDeviceToHost);
  return cudaGetLastError();
}

}
