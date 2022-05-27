all: -1 2
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_md5/md5 && clang md5.c -D_GNU_SOURCE -std=c99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_md5/md5/FileMapping.txt -o md5.ll;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_md5/md5 && clang md5_bmark.c -D_GNU_SOURCE -std=c99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMCUGeneration.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_md5/md5/FileMapping.txt -o md5_bmark.ll;
2: 0 1
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_md5/md5 && clang++ md5.ll md5_bmark.ll -D_GNU_SOURCE -std=c99 -o md5 -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
