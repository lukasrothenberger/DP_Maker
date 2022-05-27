source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_kmeans/kmeans"
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="gcc"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="kmeans"
EXECUTION_COMMAND="$TARGET_PROJECT/kmeans -b -i color -n 5"

execute_DP_Maker