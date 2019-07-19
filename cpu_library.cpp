//
// Created by Daniel Simon on 7/18/19.
//

#include "cpu_library.hpp"

namespace cpu {

void Kernel(const float* x, float* y, int n, float a, float b) {
  for (int i = 0; i < n; i++) {
    y[i] = a * x[i] + b;
  }
}

}
