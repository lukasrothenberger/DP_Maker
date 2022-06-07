source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_rotate/rotate"
TARGET_BUILD=$TARGET_PROJECT
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="g++"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="rot"
EXECUTION_COMMAND="$TARGET_PROJECT/rot input.ppm $RESULT_DIR/result.ppm 45"

execute_DP_Maker