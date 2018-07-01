#include <iostream>
#include "kernel.h"

int main(){
	// Define Properties
	int length = 500;
	float *input1 = (float*)malloc(length * sizeof(float));
	float *input2 = (float*)malloc(length * sizeof(float));
	float *result = (float*)malloc(length * sizeof(float));

	for(int i = 0; i < length; i++){
		input1[i] = i;
		input2[i] = length - 1 - i;
	}

	// Allocate Device Memory
	float* d_input1;
	checkCudaErrors(cudaMalloc(&d_input1, length * sizeof(float)));
	float* d_input2;
	checkCudaErrors(cudaMalloc(&d_input2, length * sizeof(float)));
	float* d_result;
	checkCudaErrors(cudaMalloc(&d_result, length * sizeof(float)));

	// Memory Transfer
	checkCudaErrors(cudaMemcpy((void*)d_input1, (void*)input1, length * sizeof(float), cudaMemcpyHostToDevice));
	checkCudaErrors(cudaMemcpy((void*)d_input2, (void*)input2, length * sizeof(float), cudaMemcpyHostToDevice));

	// Kernel Execution
	AddArrays(d_input1, d_input2, d_result, length);

	// Memory Transfer
	checkCudaErrors(cudaMemcpy((void*)result, (void*)d_result, length * sizeof(float), cudaMemcpyDeviceToHost));

	float res = result[0];
	bool is_ok = true;
	for(int i = 1; i < length; i++){ is_ok &= res == result[i]; }
	std::cout << std::boolalpha << "Result: " << is_ok << std::endl;

	return 0;
}
