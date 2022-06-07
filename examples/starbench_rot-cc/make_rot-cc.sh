source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_rot-cc/rot-cc"
TARGET_BUILD=$TARGET_PROJECT
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="g++"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="rot-cc"
EXECUTION_COMMAND="$TARGET_PROJECT/rot-cc input.ppm output.ppm 45"

execute_DP_Maker

mv $TARGET_PROJECT/output.ppm $RESULT_DIR