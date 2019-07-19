//
// Created by Daniel Simon on 7/18/19.
//

#ifndef CUDATEST_CPU_LIBRARY_H
#define CUDATEST_CPU_LIBRARY_H

namespace cpu {

void Kernel(const float* x, float* y, int n, float a, float b);

}

#endif //CUDATEST_CPU_LIBRARY_H
