HOME_DIR=$PWD
TARGET_FOLDER=/home/lukas/git/DP_Maker/atax_Makefile

cd $TARGET_FOLDER
make clean
cd $HOME_DIR

python -m Makefile_Analyzer --t=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=dep
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.txt && ./out && cd ..

python -m Makefile_Analyzer --t=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-bui=/home/lukas/git/discopop/build/ --exec-mode=cu_gen
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.txt && ./out && cd ..

python -m Makefile_Analyzer --t=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-bui=/home/lukas/git/discopop/build/ --exec-mode=dp_red
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.txt && ./out && cd ..

cd $HOME_DIR