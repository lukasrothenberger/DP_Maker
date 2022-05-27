source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_tinyjpeg/tinyjpeg"
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="tinyjpeg"
EXECUTION_COMMAND="$TARGET_PROJECT/tinyjpeg --benchmark earth-marker.jpg $RESULT_DIR/output.tga"

execute_DP_Maker
