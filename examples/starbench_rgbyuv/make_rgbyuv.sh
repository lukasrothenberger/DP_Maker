source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_rgbyuv/rgbyuv"
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="rgbyuv"
EXECUTION_COMMAND="$TARGET_PROJECT/rgbyuv -i input.ppm -c 5"

execute_DP_Maker

mv $TARGET_PROJECT/ucomp.ppm $RESULT_DIR
mv $TARGET_PROJECT/vcomp.ppm $RESULT_DIR
mv $TARGET_PROJECT/ycomp.ppm $RESULT_DIR
