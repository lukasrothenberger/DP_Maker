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
    compile_files: List[str] = []
    compile_only_files: List[str] = []
    output_file: str = ""
    flags: List[str] = []
    includes: List[str] = []
    enter_dir: str = ""
    exit_dir: str = ""

    def __init__(self, cmd_line: str, cmd_type: CmdType):
        self.cmd_line = cmd_line
        self.cmd_type = cmd_type
