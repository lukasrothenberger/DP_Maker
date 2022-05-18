TARGET_FOLDER=/home/goerlibe/discopop/DP_Maker/examples/atax/atax_Makefile

# load configuration variables that are similar for all example builds (e.g. DP_PATH)
source ../config.sh

# preparation
cd $TARGET_FOLDER
make clean
mkdir discopop
cd $HOME_DIR

# obtain computational units (CUs)
python -m Makefile_Analyzer --target-project=$TARGET_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=cu_gen
cd $TARGET_FOLDER && make -f tmp_makefile.mk && mv tmp_makefile.mk discopop/tmp_makefile_cu.mk && cd $HOME_DIR


# identify data dependencies by instrumentation
python -m Makefile_Analyzer --target-project=$TARGET_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=dep
cd $TARGET_FOLDER && make -f tmp_makefile.mk && ./out && mv tmp_makefile.mk discopop/tmp_makefile_dep.mk && cd $HOME_DIR

# find inter-iteration data dependencies that can be resolved using OpenMP reduction clause
python -m Makefile_Analyzer --target-project=$TARGET_FOLDER --target-makefile=$TARGET_FOLDER/Makefile --dp-path=$DP_PATH --dp-build-path=$DP_BUILD --exec-mode=dp_red
cd $TARGET_FOLDER && make -j7 -f tmp_makefile.mk && mv tmp_makefile.mk discopop/tmp_makefile_red.mk && cd $HOME_DIR

# cleanup
cd $TARGET_FOLDER
rm *.ll
rm out
mv Data.xml discopop/Data.xml
mv out_dep.txt discopop/dp_run_dep.txt
mv FileMapping.txt discopop/FileMapping.txt
mv OriginalVariables.txt discopop/OriginalVariables.txt
mv DP_CUIDCounter.txt discopop/DP_CUIDCounter.txt
mv loop_counter_output.txt discopop/loop_counter_output.txt
mv reduction.txt discopop/reduction.txt

# run discopop to obtain parallelization opportunities ranked_patterns.txt
python -m discopop_explorer --path=discopop >> discopop/ranked_patterns.txt

cd $HOME_DIR
