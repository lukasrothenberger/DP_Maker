all: -1 3
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate && clang image.cpp -c -o image.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate/FileMapping.txt;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate && clang rotation_engine.cpp -c -o rotation_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate/FileMapping.txt;
2:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate && clang program.cpp -c -o program.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate/FileMapping.txt;
3: 0 1 2
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rotate/rotate && clang++ image.ll rotation_engine.ll program.ll -o rot -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
