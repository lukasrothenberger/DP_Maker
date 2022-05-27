source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_streamcluster/streamcluster"
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="streamcluster"
EXECUTION_COMMAND="$TARGET_PROJECT/streamcluster 6 10 64 100 200 50 none $RESULT_DIR/output.txt"

execute_DP_Maker