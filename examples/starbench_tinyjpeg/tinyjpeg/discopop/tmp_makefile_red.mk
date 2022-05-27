all: -1 6
-1:
0:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang tinyjpeg.c -Wextra -DDEBUG=0 -std=c99 -c -o tinyjpeg.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
1:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang loadjpeg.c -Wextra -DDEBUG=0 -std=c99 -c -o loadjpeg.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
2:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang tinyjpeg-parse.c -Wextra -DDEBUG=0 -std=c99 -c -o tinyjpeg-parse.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
3:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang jidctflt.c -Wextra -DDEBUG=0 -std=c99 -c -o jidctflt.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
4:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang conv_yuvbgr.c -Wextra -DDEBUG=0 -std=c99 -c -o conv_yuvbgr.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
5:
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang huffman.c -Wextra -DDEBUG=0 -std=c99 -c -o huffman.ll -g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang /home/goerlibe/discopop/discopop/build/libi/LLVMDPReduction.so -mllvm -fm-path -mllvm /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg/FileMapping.txt;
6: 0 1 2 3 4 5
	cd /home/goerlibe/discopop/DP_Maker/examples/starbench_tinyjpeg/tinyjpeg && clang++ tinyjpeg.ll loadjpeg.ll tinyjpeg-parse.ll jidctflt.ll conv_yuvbgr.ll huffman.ll -o tinyjpeg -pthread -L/home/goerlibe/discopop/discopop/build/rtlib -lDiscoPoP_RT -lpthread;
