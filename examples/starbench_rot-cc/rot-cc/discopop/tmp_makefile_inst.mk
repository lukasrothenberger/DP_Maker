all: -1 5
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang image.cpp -c -o image.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc/FileMapping.txt;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang rotation_engine.cpp -c -o rotation_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc/FileMapping.txt;
2:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang convert_engine.cpp -c -o convert_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc/FileMapping.txt;
3:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang benchmark_engine.cpp -c -o benchmark_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc/FileMapping.txt;
4:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang program.cpp -c -o program.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc/FileMapping.txt;
5: 0 1 2 3 4
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && clang++ image.ll rotation_engine.ll convert_engine.ll benchmark_engine.ll program.ll -o rot-cc -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_rot-cc/rot-cc && llvm-link -S -o rot-cc_dp_inst.ll image.ll rotation_engine.ll convert_engine.ll benchmark_engine.ll program.ll;
