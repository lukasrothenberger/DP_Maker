HOME_DIR=$PWD
TARGET_PROJECT_FOLDER=/home/lukas/Schreibtisch/bots
TARGET_FOLDER=$TARGET_PROJECT_FOLDER/serial

cd $TARGET_FOLDER
make clean
cd $HOME_DIR

python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=/home/lukas/git/discopop/ --dp-build-path=/home/lukas/git/discopop/build/ --exec-mode=dep
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.txt

cd $HOME_DIR

