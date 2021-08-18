from typing import List, Optional
from enum import IntEnum


class CmdType(IntEnum):
    UNKNOWN = -1
    COMPILE = 1
    ENTER_DIR = 2
    EXIT_DIR = 3
    MAKE = 4


class Command(object):
    cmd_line: str = ""
    cmd_type: CmdType = CmdType.UNKNOWN
    compiler_command: str = ""
    flags: List[str] = []
    non_flag_arguments: List[str] = []
    enter_dir: str = ""
    exit_dir: str = ""

    def __init__(self, cmd_line: str, cmd_type: CmdType):
        self.cmd_line = cmd_line
        self.cmd_type = cmd_type

    def __str__(self):
        if self.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
            # the following works, because either enter_dir or exit_dir will be empty.
            return "cd " + self.enter_dir + self.exit_dir + ";"
        if self.cmd_type == CmdType.COMPILE:
            ret_str = self.compiler_command + " " + " ".join(self.non_flag_arguments) + " " + " ".join(self.flags) + ";"
            return ret_str
        if self.cmd_type == CmdType.MAKE:
            return ""
        return self.cmd_line + ";"

    def prepare_output(self):
        self.cmd_line = self.cmd_line.replace("$", "$$")

    def add_discopop_instrumentation(self, run_configuration):
        if self.cmd_type in [CmdType.ENTER_DIR, CmdType.EXIT_DIR, CmdType.UNKNOWN]:
            return
        if self.cmd_type == CmdType.COMPILE:
            # remove -fopenmp if it exists
            for idx, flag in enumerate(self.flags):
                if flag == "-fopenmp":
                    self.flags.pop(idx)
                    break

            # check if single file is compiled or multiple files are linked
            if "-c" in self.flags:
                # single file is compiled
                self.compiler_command = "clang"
                # append DiscoPoP compiler flags
                self.flags.append("-g -O0 -S -emit-llvm -fno-discard-value-names -Xclang -load -Xclang ##DPSHAREDOBJECT## -mllvm -fm-path -mllvm ##DPFILEMAPPING##")
                # change file type of output file
                modified_output_file = False
                for idx, flag in enumerate(self.flags):
                    if flag.startswith("-o "):
                        # manually set output file
                        if self.flags[idx].endswith(".o"):
                            self.flags[idx] = self.flags[idx][:self.flags[idx].rfind(".")]+".ll"
                        else:
                            self.flags[idx] += ".ll"
                        modified_output_file = True
                        break

                if not modified_output_file:
                    # output file named according to input file
                    # find name of compiled file
                    file_name = ""
                    for arg in self.non_flag_arguments:
                        if arg.endswith(".c") or arg.endswith(".cpp"):
                            file_name = arg
                    self.flags.append("-o " + file_name[:file_name.rfind(".")]+".ll")
            else:
                # multiple files are linked
                self.compiler_command = "clang++"
                self.flags.append("-L"+run_configuration.dp_build_path+"/rtlib -lDiscoPoP_RT -lpthread")
                for idx, arg in enumerate(self.non_flag_arguments):
                    if arg.endswith(".o"):
                        self.non_flag_arguments[idx] = self.non_flag_arguments[idx][:self.non_flag_arguments[idx].rfind(".")]
                        self.non_flag_arguments[idx] += ".ll"