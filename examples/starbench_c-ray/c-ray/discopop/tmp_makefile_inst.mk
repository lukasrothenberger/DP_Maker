all: -1 1
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_c-ray/c-ray && clang c-ray-mt.c -c -o c-ray-mt.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_c-ray/c-ray/FileMapping.txt;
1: 0
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_c-ray/c-ray && clang++ c-ray-mt.ll -lm -o c-ray-mt -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_c-ray/c-ray && llvm-link -S -o c-ray-mt_dp_inst.ll c-ray-mt.ll;
