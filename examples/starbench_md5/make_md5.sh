source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_md5/md5"
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="md5"
EXECUTION_COMMAND="$TARGET_PROJECT/md5"

execute_DP_Maker