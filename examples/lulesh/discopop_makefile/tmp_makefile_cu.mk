all: 0 2 4 6 8 10 11
-1:
0: -1
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Building lulesh.cc";
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang lulesh.cc -DUSE_MPI=0 -c -o lulesh.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH/FileMapping.txt;
2: 1
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Building lulesh-comm.cc";
3:
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang lulesh-comm.cc -DUSE_MPI=0 -c -o lulesh-comm.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH/FileMapping.txt;
4: 3
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Building lulesh-viz.cc";
5:
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang lulesh-viz.cc -DUSE_MPI=0 -c -o lulesh-viz.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH/FileMapping.txt;
6: 5
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Building lulesh-util.cc";
7:
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang lulesh-util.cc -DUSE_MPI=0 -c -o lulesh-util.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH/FileMapping.txt;
8: 7
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Building lulesh-init.cc";
9:
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang lulesh-init.cc -DUSE_MPI=0 -c -o lulesh-init.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH/FileMapping.txt;
10: 9
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && echo "Linking";
11: 1 3 5 7 9
	cd /home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH && clang++ lulesh.ll lulesh-comm.ll lulesh-viz.ll lulesh-util.ll lulesh-init.ll -DUSE_MPI=0 -lm -o lulesh2.0 -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
