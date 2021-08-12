from typing import List, Optional
from enum import IntEnum


class CmdType(IntEnum):
    UNKNOWN = -1
    COMPILE = 1
    ENTER_DIR = 2
    EXIT_DIR = 3


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
            return "cd " + self.enter_dir + self.exit_dir
        if self.cmd_type == CmdType.COMPILE:
            return self.compiler_command + " " + str(self.non_flag_arguments) + " " + str(self.flags)
        return self.cmd_line
