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
    clang_bin: str
    clangxx_bin: str
    llvm_link_bin: str

    def __init__(self):
        pass

    def __str__(self):
        return  "### RUN CONFIGURATION ###" + "\n" + \
                "\ttarget: " + self.target_makefile + "\n" + \
                "\tcompilers: " + str(self.compilers) + "\n" + \
                "\texecution mode: " + str(self.execution_mode) + "\n" + \
                "\tdp_path: " + self.dp_path + "\n" + \
                "\tdp_build_path: " + self.dp_build_path + "\n" + \
                "\tclang_bin: " + self.clang_bin + "\n" + \
                "\tclangxx_bin: " + self.clangxx_bin + "\n" + \
                "\tllvm_link_bin: " + self.llvm_link_bin + "\n" + \
                "########################"
