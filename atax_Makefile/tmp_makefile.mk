all: 0 3
-1:
0: -1
	cd /home/lukas/git/DP_Maker/atax_Makefile && clang useless.c -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/lukas/git/discopop/build//libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/lukas/git/DP_Maker/atax_Makefile/FileMapping.txt -o useless.ll;
1:
	cd /home/lukas/git/DP_Maker/atax_Makefile && clang atax.c -O3 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/lukas/git/discopop/build//libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/lukas/git/DP_Maker/atax_Makefile/FileMapping.txt -o atax.ll;
2:
	cd /home/lukas/git/DP_Maker/atax_Makefile && clang polybench.c -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/lukas/git/discopop/build//libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/lukas/git/DP_Maker/atax_Makefile/FileMapping.txt -o polybench.ll;
3: 1 2
	cd /home/lukas/git/DP_Maker/atax_Makefile && clang++ atax.ll polybench.ll -o out -L/home/lukas/git/discopop/build//rtlib -lDiscoPoP_RT -lpthread;
