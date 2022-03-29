HOME_DIR=/home/goerlibe/discopop/DP_Maker/
TARGET_PROJECT_FOLDER=/home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH
TARGET_FOLDER=$TARGET_PROJECT_FOLDER

# force a complete rebuild by cleaning beforehand
cd $TARGET_PROJECT_FOLDER
make clean

# general approach when using dp-maker:
#  1) start the Makefile_Analyzer with the desired exec-mode (cu_gen, dep, dp_red)
#  2) run the generated tmp_makefile.mk

# obtain computational units (CUs)
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --compiler=mpic++ --dp-path=/home/goerlibe/discopop/discopop --dp-build-path=/home/goerlibe/discopop/discopop/build --exec-mode=dep
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./lulesh2.0  -s 12

# identify data dependencies by instrumentation
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --compiler=mpic++ --dp-path=/home/goerlibe/discopop/discopop --dp-build-path=/home/goerlibe/discopop/discopop/build --exec-mode=cu_gen
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./lulesh2.0  -s 12

# find inter-iteration data dependencies that can be resolved using OpenMP reduction clause
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --compiler=mpic++ --dp-path=/home/goerlibe/discopop/discopop --dp-build-path=/home/goerlibe/discopop/discopop/build --exec-mode=dp_red
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.mk && ./lulesh2.0 -s 12


# run discopop to obtain parallelization opportunities
cd $TARGET_FOLDER && python -m discopop_explorer --cu-xml=Data.xml --dep-file=lulesh2.0_dep.txt >> pop.txt
cd $HOME_DIR
