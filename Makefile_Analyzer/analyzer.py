from typing import Dict, List
import os
import subprocess
from os.path import dirname
from .parser import parse_command
from Helper.compiler_information import CompilerFlagInformation, get_compiler_argument_information
from Helper.command_preprocessor import preprocess
from DP_Maker_Classes.Command import Command, CmdType


def analyze_makefile(run_configuration):
    """Analyzes the makefile at the given path.
    :param run_configuration: Object storing run configuration (paths etc.)"""
    # save starting cwd
    starting_cwd = os.getcwd()
    # set cwd to makefile's parent directory
    print()
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
    # parse each individual command
    parsed_commands: List[Command] = []
    for command in stream.readlines():
        command = command.replace("\n", "")
        command = preprocess(command)
        parsed_commands.append(parse_command(command, run_configuration.compilers, compiler_flag_information_dict))

    print()
    print("#######################")
    print("### PARSED COMMANDS ###")
    print("#######################")
    print()
    #for cmd in parsed_commands:
    #    print(cmd)

    # instrument commands
    for cmd in parsed_commands:
        cmd.add_discopop_instrumentation(run_configuration)

    print()
    print("#############################")
    print("### INSTRUMENTED COMMANDS ###")
    print("#############################")
    print()
    #for cmd in parsed_commands:
    #    print(cmd)

    enable_instrumentation = True
    enable_cu_generation = False
    enable_dp_reduction = False

    # execute Instrumentation
    if enable_instrumentation:
        last_dir = os.getcwd()
        # execute FileMapping
        os.system("cp "+run_configuration.dp_path+"/scripts/dp-fmap " + last_dir + "/dp-fmap")
        for cmd in parsed_commands:
            if cmd.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
                last_dir = "" + cmd.exit_dir + cmd.enter_dir
            print()
            print("PWD: ", last_dir)
            print("ORIG: ", cmd.cmd_line)
            print("PRE: ", str(cmd))
            cmd_str = str(cmd)
            # replace § signs introduced by the preprocessor with whitespaces
            cmd_str = cmd_str.replace("§", " ")
            # replace DP-Shared Object marker with Instrumentation
            cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                      run_configuration.dp_build_path + "/libi/LLVMDPInstrumentation.so")
            # replace DP-FMAP marker with path of FileMapping.txt
            cmd_str = cmd_str.replace("##DPFILEMAPPING##", last_dir + "/FileMapping.txt")
            print("Execute: ", "cd " + last_dir+" && " + cmd_str)
            stream = os.popen("cd " + last_dir+" && " + cmd_str)
            print("Result: ", stream.readlines())

    # execute Instrumentation
    if enable_cu_generation:
        last_dir = os.getcwd()
        # execute FileMapping
        os.system("cp "+run_configuration.dp_path+"/scripts/dp-fmap " + last_dir + "/dp-fmap")
        for cmd in parsed_commands:
            if cmd.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
                last_dir = "" + cmd.exit_dir + cmd.enter_dir
            print()
            print("PWD: ", last_dir)
            print("ORIG: ", cmd.cmd_line)
            print("PRE: ", str(cmd))
            cmd_str = str(cmd)
            # replace § signs introduced by the preprocessor with whitespaces
            cmd_str = cmd_str.replace("§", " ")
            # replace DP-Shared Object marker with Instrumentation
            cmd_str = cmd_str.replace("##DPSHAREDOBJECT##", run_configuration.dp_build_path+"/libi/LLVMCUGeneration.so")
            # replace DP-FMAP marker with path of FileMapping.txt
            cmd_str = cmd_str.replace("##DPFILEMAPPING##", last_dir + "/FileMapping.txt")
            print("Execute: ", "cd " + last_dir+" && " + cmd_str)
            stream = os.popen("cd " + last_dir+" && " + cmd_str)
            print("Result: ", stream.readlines())

    # execute DP Reduction
    if enable_dp_reduction:
        last_dir = os.getcwd()
        # execute FileMapping
        os.system("cp "+run_configuration.dp_path+"/scripts/dp-fmap " + last_dir + "/dp-fmap")
        os.system("cd " + last_dir + " && ./dp-fmap")
        for cmd in parsed_commands:
            if cmd.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
                last_dir = "" + cmd.exit_dir + cmd.enter_dir
            print()
            print("PWD: ", last_dir)
            print("ORIG: ", cmd.cmd_line)
            print("PRE: ", str(cmd))
            cmd_str = str(cmd)
            # replace § signs introduced by the preprocessor with whitespaces
            cmd_str = cmd_str.replace("§", " ")
            # replace DP-Shared Object marker with Instrumentation
            cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                      run_configuration.dp_build_path+"/libi/LLVMDPReduction.so")
            # replace DP-FMAP marker with path of FileMapping.txt
            cmd_str = cmd_str.replace("##DPFILEMAPPING##", last_dir + "/FileMapping.txt")
            print("Execute: ", "cd " + last_dir + " && " + cmd_str)
            stream = os.popen("cd " + last_dir + " && " + cmd_str)
            print("Result: ", stream.readlines())


    # reset cwd
    os.chdir(starting_cwd)