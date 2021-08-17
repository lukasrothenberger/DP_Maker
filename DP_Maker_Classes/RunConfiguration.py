from typing import List, Tuple
from enum import Enum


class ExecutionMode(Enum):
    DEP_ANALYSIS = "dep"
    CU_GENERATION = "cu_gen"
    DP_REDUCTION = "dp_red"


class RunConfiguration(object):
    target_makefile: str
    target_project_root: str
    compilers: List[str]
    execution_mode: ExecutionMode
    dp_path: str
    dp_build_path: str

    def __init__(self):
        pass

    def __str__(self):
        return  "########################" + "\n" + \
                "### RUN COFIGURATION ###" + "\n" + \
                "\ttarget: " + self.target_makefile + "\n" + \
                "\tcompilers: " + str(self.compilers) + "\n" + \
                "\texecution mode: " + str(self.execution_mode) + "\n" + \
                "\tdp_path: " + self.dp_path + "\n" + \
                "\tdp_build_path: " + self.dp_build_path + "\n" + \
                "########################" + "\n"
