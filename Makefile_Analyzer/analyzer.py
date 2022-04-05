import sys
from typing import Dict, List
import os
import subprocess
from os.path import dirname
from .parser import parse_command
from Helper.compiler_information import CompilerFlagInformation, get_compiler_argument_information
from Helper.command_preprocessor import preprocess
from DP_Maker_Classes.Command import Command, CmdType
from DP_Maker_Classes.RunConfiguration import RunConfiguration, ExecutionMode
from File_Dependency_Graph.constructor import construct_graph_from_commands
from File_Dependency_Graph.graph import FileDependencyGraph


def analyze_makefile(run_configuration: RunConfiguration):
    """Analyzes the makefile at the given path.
    :param run_configuration: Object storing run configuration (paths etc.)"""
    # save starting cwd
    starting_cwd = os.getcwd()
    # set cwd to makefile's parent directory
    parent_dir = dirname(run_configuration.target_makefile)
    os.chdir(parent_dir)
    # get information on available flags of used compilers
    compiler_flag_information_dict: Dict[str, List[CompilerFlagInformation]] = dict()
    for compiler_cmd in run_configuration.compilers:
        if compiler_cmd in compiler_flag_information_dict:
            continue
        compiler_flag_information_dict[compiler_cmd] = get_compiler_argument_information(compiler_cmd)

    # dry run the specified makefile
    stream = os.popen("LANGUAGE=en make -n -j1")

    # group lines to support multi-line commands
    raw_lines = stream.readlines()
    grouped_lines: List[str] = []
    line_buffer = ""
    for idx, line in enumerate(raw_lines):
        line_buffer = line_buffer + line  # .replace("\n", "")
        if line_buffer.endswith("\\\n"):
            # preserve line_buffer, replace \\\n at the end of the line with whitespace
            line_buffer = line_buffer.replace("\\\n", " ")
        else:
            # remove newline-marker and tabs
            line_buffer = line_buffer.replace("\n", "").replace("\t", " ")
            # remove multiple whitespaces
            while "  " in line_buffer:
                line_buffer = line_buffer.replace("  ", " ")
            # append line_buffer to grouped lines
            grouped_lines.append(line_buffer)
            # clear line_buffer
            line_buffer = ""
    # preprocess grouped lines
    preprocessed_grouped_lines = [preprocess(line) for line in grouped_lines]

    # get grouped raw commands, split grouped lines into individual commands
    grouped_raw_commands: List[List[str]] = [line.split(";") for line in preprocessed_grouped_lines]
    # parse each individual command
    grouped_parsed_commands: List[List[Command]] = []
    for raw_cmd_group in grouped_raw_commands:
        parsed_cmd_group: List[Command] = []
        for raw_cmd in raw_cmd_group:
            # filter out empty commands
            if len(raw_cmd) == 0:
                continue
            raw_cmd = preprocess(raw_cmd)
            parsed_cmd_group.append(parse_command(raw_cmd, run_configuration.compilers, compiler_flag_information_dict))
        grouped_parsed_commands.append(parsed_cmd_group)

    print()
    print("#######################")
    print("### PARSED COMMANDS ###")
    print("#######################")
    print()

    # instrument commands
    for group in grouped_parsed_commands:
        for cmd in group:
            cmd.add_discopop_instrumentation(run_configuration)

    print()
    print("#############################")
    print("### INSTRUMENTED COMMANDS ###")
    print("#############################")
    print()

    tmp_make_file = open("tmp_makefile.mk", "w+")
    # tmp_make_file.write("all:\n")

    # create FileMapping.txt
    tmp_cwd = os.getcwd()
    os.chdir(run_configuration.target_project_root)
    os.system(run_configuration.dp_path + "/scripts/dp-fmap")
    os.chdir(tmp_cwd)

    # construct file dependency graph and write makefile
    cmd_graph: FileDependencyGraph = construct_graph_from_commands(grouped_parsed_commands)
    # cmd_graph.plot_graph()
    cmd_graph.simplify_graph()
    cmd_graph.plot_graph(writeFile=True)
    cmd_graph.write_makefile(tmp_make_file, run_configuration, tmp_cwd)

    tmp_make_file.close()

    # reset cwd
    os.chdir(starting_cwd)
