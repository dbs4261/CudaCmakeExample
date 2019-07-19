#include <vector>

#include "cuda_library.cuh"
#include "cpu_library.hpp"

int main() {
  std::vector<float> data(35);
  float a = 2.1;
  float b = 5.2;
  std::vector<float> cpu_out(35);
  std::vector<float> cuda_out(35);
  cpu::Kernel(data.data(), cpu_out.data(), data.size(), a, b);
  return cuda::Kernel(data.data(), cpu_out.data(), data.size(), a, b);
}