from typing import Dict, List
import os
import subprocess
from os.path import dirname
from .parser import parse_command
from Helper.compiler_information import CompilerFlagInformation, get_compiler_argument_information
from Helper.command_preprocessor import preprocess
from DP_Maker_Classes.Command import Command, CmdType
from DP_Maker_Classes.RunConfiguration import RunConfiguration, ExecutionMode


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
    grouped_parsed_commands: List[Command] = []
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
    tmp_make_file.write("all:\n")

    # create filemapping on parent directory of target Makefile
    tmp_cwd = os.getcwd()
    os.system("cp "+run_configuration.dp_path+"/scripts/dp-fmap " + run_configuration.target_project_root + "/dp-fmap")
    os.system("cd " + run_configuration.target_project_root + " && ./dp-fmap")
    os.system("cd " + tmp_cwd)

    last_dir = os.getcwd()
    # execute FileMapping
    os.system("cp " + run_configuration.dp_path + "/scripts/dp-fmap " + last_dir + "/dp-fmap")
    os.system("cd " + last_dir + " && ./dp-fmap")

    # write tmp_makefile.txt for selected analysis
    for group in grouped_parsed_commands:
        cmd_line_str = ""
        for cmd in group:
            cmd.prepare_output()
            if cmd.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
                last_dir = "" + cmd.exit_dir + cmd.enter_dir
            cmd_str = str(cmd)
            # replace DP-Shared Object marker with Instrumentation
            if run_configuration.execution_mode is ExecutionMode.DEP_ANALYSIS:
                cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                          run_configuration.dp_build_path + "/libi/LLVMDPInstrumentation.so")
            elif run_configuration.execution_mode is ExecutionMode.CU_GENERATION:
                cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                          run_configuration.dp_build_path + "/libi/LLVMCUGeneration.so")
            elif run_configuration.execution_mode is ExecutionMode.DP_REDUCTION:
                cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                          run_configuration.dp_build_path + "/libi/LLVMDPReduction.so")
            else:
                raise ValueError("Unrecognized Execution Mode: ", run_configuration.execution_mode)
            # replace DP-FMAP marker with path of FileMapping.txt
            cmd_str = cmd_str.replace("##DPFILEMAPPING##", run_configuration.target_project_root + "/FileMapping.txt")
            # replace § signs introduced by the preprocessor with whitespaces
            cmd_str = cmd_str.replace("§", " ")
            # replace # signs introduced by the preprocessor with semicolon
            cmd_str = cmd_str.replace("#", ";")
            if len(cmd_line_str) == 0:
                cmd_line_str += "cd " + last_dir
                if len(cmd_str) > 0:
                    cmd_line_str += " && "
            cmd_line_str += cmd_str + " "
        tmp_make_file.write("\t" + cmd_line_str + "\n")

    tmp_make_file.close()

    # reset cwd
    os.chdir(starting_cwd)