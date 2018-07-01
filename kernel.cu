#include <iostream>
#include <stdio.h>
#include "kernel.h"
#include <helper_math.h>

__global__ void devAddArrays(
	float *input1,
	float *input2,
	float *result,
	int length
) {
	const int tx = blockIdx.x*blockDim.x + threadIdx.x;

	if(tx >= length){ return; }
	
	result[tx] = input1[tx] + input2[tx];
}

void AddArrays(
	float *d_input1,
	float *d_input2,
	float *d_result,
	int length
){
	// define thread / block size
	dim3 dimBlock(32, 1, 1);
	dim3 dimGrid(
			(length - 1) / dimBlock.x + 1, 
			1, 
			1);

	std::cout
		<< "\n== Configs of " << __func__ << " ==\n"
		<< "Length : " << length << "\n"
		<< "Dim of Grid : (" 
			<< dimGrid.x << ", " 
			<< dimGrid.y << ", " 
			<< dimGrid.z << ")\n"
		<< "Dim of Block : (" 
			<< dimBlock.x << ", " 
			<< dimBlock.y << ", " 
			<< dimBlock.z << ")\n"
		<< std::endl;

	devAddArrays<<<dimGrid, dimBlock, 0 >>>(d_input1, d_input2, d_result, length);
	return;
}
