TARGET_PROJECT_FOLDER=/home/goerlibe/discopop/DP_Maker/examples/atax/atax_Makefile
TARGET_FOLDER=$TARGET_PROJECT_FOLDER

# load configuration variables that are similar for all example builds (e.g. DP_PATH)
source ../config.sh

# needed if you want to rebuild the entire application
cd $TARGET_FOLDER
make clean
cd $HOME_DIR

# general approach when using dp-maker:
#  1) start the Makefile_Analyzer with the desired exec-mode (cu_gen, dep, dp_red)
#  2) run the generated tmp_makefile.mk

# obtain computational units (CUs)
python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=dep
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./out && cd $HOME_DIR

# identify data dependencies by instrumentation
python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=cu_gen
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./out && cd $HOME_DIR

# find inter-iteration data dependencies that can be resolved using OpenMP reduction clause
python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=dp_red
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.mk && ./out && cd $HOME_DIR


# run discopop to obtain parallelization opportunities "pop.txt"
cd $TARGET_FOLDER && python -m discopop_explorer --cu-xml=Data.xml --dep-file=out_dep.txt >> pop.txt

cd $HOME_DIR
