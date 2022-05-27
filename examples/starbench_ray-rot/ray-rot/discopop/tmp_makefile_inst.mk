all: -1 4
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && clang image.cpp -c -o image.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot/FileMapping.txt;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && clang rotation_engine.cpp -c -o rotation_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot/FileMapping.txt;
2:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && clang ray_engine.cpp -c -o ray_engine.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot/FileMapping.txt;
3:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && clang program.cpp -c -o program.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPInstrumentation.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot/FileMapping.txt;
4: 0 1 2 3
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && clang++ image.ll rotation_engine.ll ray_engine.ll program.ll -o ray-rot -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_ray-rot/ray-rot && llvm-link -S -o ray-rot_dp_inst.ll image.ll rotation_engine.ll ray_engine.ll program.ll;
