CXXFLAGS=-std=c++11 -Wall -Wextra -Werror -g
NVCCFLAGS=-Wno-deprecated-gpu-targets
TARGET=cuda_sample
GLLIB=-lGLU -lGL -lglfw
CUINC=-I/usr/local/cuda/include -I/usr/local/cuda/samples/common/inc
CULIB=-L/usr/local/cuda/lib64/ -lcudart

$(TARGET): source.o kernel.o
	nvcc $(NVCCFLAGS) -o $@ $^ $(GLLIB) $(CULIB)

source.o: source.cpp kernel.h
	g++ -c $< $(CXXFLAGS) $(CUINC)

kernel.o: kernel.cu kernel.h
	nvcc $(NVCCFLAGS) -c $< $(CUINC)

.PHONY: clean
clean:
	rm -f $(TARGET)
	rm -f *.o
