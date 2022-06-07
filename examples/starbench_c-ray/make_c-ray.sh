source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_c-ray/c-ray"
TARGET_BUILD=$TARGET_PROJECT
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.ppm"
EXECUTABLE="c-ray-mt"
EXECUTION_COMMAND="cat scene | $TARGET_PROJECT/c-ray-mt"

execute_DP_Maker