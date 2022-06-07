source ../config.sh
source ../functions.sh

TARGET_PROJECT="$DP_MAKER_BASE_PATH/examples/starbench_ray-rot/ray-rot"
TARGET_BUILD=$TARGET_PROJECT
TARGET_MAKEFILE="$TARGET_PROJECT/Makefile"
COMPILER="g++"
RESULT_DIR="$TARGET_PROJECT/discopop"
RESULT_FILENAME="result.txt"
EXECUTABLE="ray-rot"
EXECUTION_COMMAND="$TARGET_PROJECT/ray-rot scene $DP_MAKER_BASE_PATH/examples/starbench_ray-rot/ray-rot/discopop/result.ppm 45 320 180 5"

execute_DP_Maker