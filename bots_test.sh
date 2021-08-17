HOME_DIR=$PWD
TARGET_FOLDER=/home/lukas/Schreibtisch/bots

cd $TARGET_FOLDER
make clean
cd $HOME_DIR

python -m Makefile_Analyzer --t=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=dep
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.txt

cd $HOME_DIR

