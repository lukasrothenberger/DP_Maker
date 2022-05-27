all: -1 2
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster && clang util.c -std=gnu99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster/FileMapping.txt -o util.ll;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster && clang streamcluster.c -std=gnu99 -c -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster/FileMapping.txt -o streamcluster.ll;
2: 0 1
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster && clang++ util.ll streamcluster.ll -lm -std=gnu99 -pthread -o streamcluster -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_streamcluster/streamcluster && llvm-link -S -o streamcluster_dp_inst.ll util.ll streamcluster.ll;
