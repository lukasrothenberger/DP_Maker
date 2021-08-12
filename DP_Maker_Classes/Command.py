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
    compiler_command: str = []
    flags: List[str] = []
    non_flag_arguments: List[str] = []
    enter_dir: str = ""
    exit_dir: str = ""

    def __init__(self, cmd_line: str, cmd_type: CmdType):
        self.cmd_line = cmd_line
        self.cmd_type = cmd_type
