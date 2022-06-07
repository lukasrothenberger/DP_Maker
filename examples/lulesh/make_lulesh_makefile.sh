# this script uses the Makefile provided by LULESH to rebuild lulesh using clang to run discopop

source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/lulesh/LULESH"
TARGET_BUILD=$TARGET_PROJECT
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="g++"
RESULT_DIR="$DP_MAKER_BASE_PATH/examples/lulesh/discopop_makefile"
RESULT_FILENAME="result.txt"
EXECUTABLE="lulesh2.0"
EXECUTION_COMMAND="$TARGET_PROJECT/lulesh2.0 -s 5 -i 72"

execute_DP_Maker