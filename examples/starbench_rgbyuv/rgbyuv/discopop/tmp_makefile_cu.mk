all: -1 2
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rgbyuv/rgbyuv && clang imgio.c -D_GNU_SOURCE -std=c99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rgbyuv/rgbyuv/FileMapping.txt -o imgio.ll;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rgbyuv/rgbyuv && clang bmark.c -D_GNU_SOURCE -std=c99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rgbyuv/rgbyuv/FileMapping.txt -o bmark.ll;
2: 0 1
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rgbyuv/rgbyuv && clang++ imgio.ll bmark.ll -D_GNU_SOURCE -std=c99 -lm -o rgbyuv -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
