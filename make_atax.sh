HOME_DIR=$PWD
TARGET_PROJECT_FOLDER=/home/lukas/git/DP_Maker/atax_Makefile
TARGET_FOLDER=$TARGET_PROJECT_FOLDER

cd $TARGET_FOLDER
make clean
cd $HOME_DIR

python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=dep
# cd $TARGET_FOLDER && cat tmp_makefile.mk
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./out && cd ..

python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=cu_gen
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./out && cd ..

python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=dp_red
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.mk && ./out && cd ..

cd $HOME_DIR
