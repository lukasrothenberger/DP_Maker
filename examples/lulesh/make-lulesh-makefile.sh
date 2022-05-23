# colorful output :)
OUT_HIGHLIGHT='\033[1;33m'
OUT_STANDARD='\033[0m'

# load configuration variables that are similar for all example builds (e.g. DP_PATH)
source ../config.sh

# project specific variables
TARGET_PROJECT=/home/goerlibe/discopop/DP_Maker/examples/lulesh/LULESH
EXEC_ARGS="-s 5 -i 72"

# cleanup to force complete rebuild
cd $TARGET_PROJECT
make clean
rm -rf $TARGET_PROJECT/discopop
mkdir $TARGET_PROJECT/discopop

echo -e "${OUT_HIGHLIGHT} --> CU GENERATION <--${OUT_STANDARD}"
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_PROJECT/Makefile --compiler=g++ --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=cu_gen
cd $TARGET_PROJECT && make -f tmp_makefile.mk
mv tmp_makefile.mk $TARGET_PROJECT/discopop/tmp_makefile_cu.mk

echo -e "${OUT_HIGHLIGHT} --> INSTRUMENTATION <--${OUT_STANDARD}"
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_PROJECT/Makefile --compiler=g++ --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=dep
cd $TARGET_PROJECT && make -f tmp_makefile.mk && ./lulesh2.0  $EXEC_ARGS
mv tmp_makefile.mk $TARGET_PROJECT/discopop/tmp_makefile_inst.mk

echo -e "${OUT_HIGHLIGHT} --> REDUCTION <--${OUT_STANDARD}"
cd $HOME_DIR && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_PROJECT/Makefile --compiler=g++ --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=dp_red
cd $TARGET_PROJECT && make -j7 -f tmp_makefile.mk
mv tmp_makefile.mk $TARGET_PROJECT/discopop/tmp_makefile_red.mk

# cleanup
mv Data.xml $TARGET_PROJECT/discopop/Data.xml
mv lulesh2.0_dep.txt $TARGET_PROJECT/discopop/dp_run_dep.txt
mv FileMapping.txt $TARGET_PROJECT/discopop/FileMapping.txt
mv OriginalVariables.txt $TARGET_PROJECT/discopop/OriginalVariables.txt
mv DP_CUIDCounter.txt $TARGET_PROJECT/discopop/DP_CUIDCounter.txt
mv loop_counter_output.txt $TARGET_PROJECT/discopop/loop_counter_output.txt
mv reduction.txt $TARGET_PROJECT/discopop/reduction.txt
rm -f *.ll
rm -f lulesh2.0
rm -f lulesh2.0_dp_inst.ll


# run discopop to obtain parallelization opportunities
echo -e "${OUT_HIGHLIGHT} --> RUNNING DISCOPOP EXPLORER <--${OUT_STANDARD}"
python -m discopop_explorer --path=$TARGET_PROJECT/discopop >> $TARGET_PROJECT/discopop/ranked_patterns.txt
cd $HOME_DIR
