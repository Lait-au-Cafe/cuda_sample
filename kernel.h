#include <cuda_runtime.h>
#include <device_launch_parameters.h>
#include <helper_functions.h>
#include <helper_cuda.h>

typedef unsigned char uchar;

//=========================================================
// Global Buffers
//=========================================================

//=========================================================
// Device Functions
//=========================================================
void AddArrays(float*, float*, float*, int);
