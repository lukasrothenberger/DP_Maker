all: -1 4
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans && clang wtime.c -c -std=gnu99 -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans/FileMapping.txt -o wtime.ll;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans && clang file_io.c -c -std=gnu99 -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans/FileMapping.txt -o file_io.ll;
2:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans && clang kmeans.c -c -std=gnu99 -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans/FileMapping.txt -o kmeans.ll;
3:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans && clang main.c -c -std=gnu99 -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans/FileMapping.txt -o main.ll;
4: 0 1 2 3
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_kmeans/kmeans && clang++ wtime.ll file_io.ll kmeans.ll main.ll -lm -o kmeans -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
