from typing import Dict, List
import os
import subprocess
from os.path import dirname
from .parser import parse_command
from Helper.compiler_information import CompilerFlagInformation, get_compiler_argument_information


def analyze_makefile(makefile_path, compilers):
    """Analyzes the makefile at the given path.
    :param makefile_path: Path to target Makefile
    :param compilers: List of known compiler commands"""
    # save starting cwd
    starting_cwd = os.getcwd()
    # set cwd to makefile's parent directory
    print()
    parent_dir = dirname(makefile_path)
    os.chdir(parent_dir)
    # get information on available flags of used compilers
    compiler_flag_information_dict: Dict[str, List[CompilerFlagInformation]] = dict()
    for compiler_cmd in compilers:
        if compiler_cmd in compiler_flag_information_dict:
            continue
        compiler_flag_information_dict[compiler_cmd] = get_compiler_argument_information(compiler_cmd)

    # dry run the specified makefile
    stream = os.popen("LANGUAGE=en make -n -j1")
    # parse each individual command
    files: str = []
    for command in stream.readlines():
        parse_command(command, compilers, compiler_flag_information_dict)

    # reset cwd
    os.chdir(starting_cwd)