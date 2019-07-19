cmake_minimum_required(VERSION 3.14)
project(CudaTest LANGUAGES CXX CUDA)

set(ignoreMe "${CMAKE_C_COMPILER}")

set(CMAKE_CXX_STANDARD 17)
if(NOT DEFINED CMAKE_CUDA_STANDARD)
  set(CMAKE_CUDA_STANDARD 14)
  set(CMAKE_CUDA_STANDARD_REQUIRED ON)
endif()

set(CUDA_COMPILED_ARCH "sm_50")

function(CUDA_CONVERT_FLAGS EXISTING_TARGET)
  get_property(old_flags TARGET ${EXISTING_TARGET} PROPERTY INTERFACE_COMPILE_OPTIONS)
  if(NOT "${old_flags}" STREQUAL "")
    string(REPLACE ";" "," CUDA_flags "${old_flags}")
    set_property(TARGET ${EXISTING_TARGET} PROPERTY INTERFACE_COMPILE_OPTIONS
      "$<$<COMPILE_LANGUAGE:CXX>:${old_flags}>$<$<COMPILE_LANGUAGE:CUDA>:-Xcompiler=${CUDA_flags}>"
      )
  endif()
endfunction()

add_library(CpuLibrary cpu_library.cpp)

add_library(CudaLibrary SHARED cuda_library.cu)
set_target_properties(CudaLibrary PROPERTIES
  CUDA_SEPERABLE_COMPILATION ON
  CUDA_HOST_COMPILER ${CMAKE_CXX_COMPILER}
)
target_include_directories(CudaLibrary
  PUBLIC
    ${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES}
)
target_compile_options(CudaLibrary
  PRIVATE
    $<$<COMPILE_LANGUAGE:CUDA>:-arch=${CUDA_COMPILED_ARCH}>
)

add_executable(Example main.cpp)
target_link_libraries(Example
  PUBLIC
    CpuLibrary
    CudaLibrary
)