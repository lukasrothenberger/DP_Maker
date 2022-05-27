# this file is `source`ed by other scripts inside the examples directory and contains helper functions to reduce the amount of copy-pasting

function printYellow ()
{
    echo -e "\033[1;33m$1\033[0m"
}

function printRed ()
{
    echo -e "\032[1;33m$1\033[0m"
}


# very often the same steps need to be done when executing dp_maker so they are stashed away inside this function
function execute_DP_Maker () {
    # required variables:
        # TARGET_PROJECT
        # TARGET_MAKEFILE
        # COMPILER
        # DP_PATH
        # DP_BUILD
        # RESULT_DIR
        # RESULT_FILENAME
        # EXECUTABLE
        # EXECUTION_COMMAND
    HOME_DIR=$PWD

    # cleanup to force complete rebuild
    cd $TARGET_PROJECT && make clean
    rm -rf $RESULT_DIR && mkdir $RESULT_DIR

    # CU GEN
    printYellow "CU GENERATION"
    cd $DP_MAKER_BASE_PATH && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_MAKEFILE --compiler=$COMPILER --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=cu_gen
    cd $TARGET_PROJECT && make -f tmp_makefile.mk
    mv tmp_makefile.mk $RESULT_DIR/tmp_makefile_cu.mk

    # RED
    printYellow "REDUCTION"
    cd $DP_MAKER_BASE_PATH && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_MAKEFILE --compiler=$COMPILER --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=dp_red
    cd $TARGET_PROJECT && make -j7 -f tmp_makefile.mk
    mv tmp_makefile.mk $RESULT_DIR/tmp_makefile_red.mk

    # DEP
    printYellow "BUILDING FOR INSTRUMENTATION"
    cd $DP_MAKER_BASE_PATH && python -m Makefile_Analyzer --target-project=$TARGET_PROJECT --target-makefile=$TARGET_MAKEFILE --compiler=$COMPILER --dp-path=${DP_PATH} --dp-build-path=${DP_BUILD} --exec-mode=dep
    cd $TARGET_PROJECT && make -f tmp_makefile.mk
    mv tmp_makefile.mk $RESULT_DIR/tmp_makefile_inst.mk
    
    printYellow "RUNNING INSTRUMENTATION"
    eval "$EXECUTION_COMMAND > $RESULT_DIR/$RESULT_FILENAME"

    # cleanup
    mv Data.xml $RESULT_DIR/Data.xml
    mv ${EXECUTABLE}_dep.txt $RESULT_DIR/dp_run_dep.txt
    mv FileMapping.txt $RESULT_DIR/FileMapping.txt
    mv OriginalVariables.txt $RESULT_DIR/OriginalVariables.txt
    mv DP_CUIDCounter.txt $RESULT_DIR/DP_CUIDCounter.txt
    mv loop_counter_output.txt $RESULT_DIR/loop_counter_output.txt
    mv reduction.txt $RESULT_DIR/reduction.txt
    rm $EXECUTABLE
    rm -f *.ll

    # run discopop to obtain parallelization opportunities
    printYellow "RUNNING DISCOPOP EXPLORER"
    python -m discopop_explorer --path=$RESULT_DIR >> $RESULT_DIR/ranked_patterns.txt
    cd $HOME_DIR
}
