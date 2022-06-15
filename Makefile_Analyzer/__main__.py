"""Discopop Makefile Analyzer and Execution Driver

Usage:
    Makefile_Analyzer --dp-path <path> --dp-build-path <path> --exec-mode <mode> --target-project <path> \
    [--target-makefile <path>] [--compiler <name>] [--clang-bin <path>] [--clang++-bin <path>] [--llvm-link-bin <path>]

Options:
    --exec-mode=<mode>      Specifies the mode of operation. Available values are: [dep, cu_gen, dp_red]
    --dp-path=<path>        Path to DiscoPoP folder
    --dp-build-path=<path>  Path to DiscoPoP build folder
    --clang-bin=<path>      Path to clang executable. [default: clang]
    --clang++-bin=<path>    Path to clang++ executable. [default: clang++]
    --llvm-link-bin=<path>  Path to llvm-link executable. [default: llvm-link]
    --target-makefile=<path>    Path of the target Makefile [default: ./Makefile]
    --target-project=<path>     Root Path of the target Project
    --compiler=<name>       Name of the used compile command (e.g. gcc, clang etc.)
                            If multiple compilers are used, a comma separated list can be supplied (e.g gcc,clang)
                            [default: gcc,clang,g++,clang++,cc]
    -h --help               Show this screen
"""
import os
import logging

from docopt import docopt  # type:ignore
from schema import SchemaError, Schema, Use
from DP_Maker_Classes.FlagTable import FlagTable  # type:ignore

from DP_Maker_Classes.RunConfiguration import RunConfiguration
from .analyzer import analyze_makefile
from DP_Maker_Classes.RunConfiguration import ExecutionMode

docopt_schema = Schema({
    '--target-makefile': Use(str),
    '--target-project': Use(str),
    '--compiler': Use(str),
    '--dp-path': Use(str),
    '--dp-build-path': Use(str),
    '--clang-bin': Use(str),
    '--clang++-bin': Use(str),
    '--llvm-link-bin': Use(str),
    '--exec-mode': Use(str)
})


def get_path(base_path: str, file_name: str) -> str:
    """Combines path and filename if it is not absolute

    :param base_path: path
    :param file_name: file name
    :return: path to file
    """
    return file_name if os.path.isabs(file_name) else os.path.join(base_path, file_name)


def main():

    # test FlagTable
    flagTable = FlagTable([("gcc", "gccFlags.csv"), ("g++", "g++Flags.csv")])
    print(flagTable.getReplacementForFlag("gcc", "-someFlag2")) # should be ""
    print(flagTable.getReplacementForFlag("gcc", "-someFlag3")) # should be "-someReplacement3"
    print(flagTable.getReplacementForFlag("gcc", "-someFlag42")) # not configured, should be ""

    flagTable.setDefaultCompiler("gcc")
    print(flagTable.getDefaultCompilerReplacementForFlag("-someFlag3"))


    # configure logging
    logger = logging.getLogger("DP_Maker")
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.DEBUG)
    console_handler.setFormatter(logging.Formatter("[%(levelname)s/%(module)s/%(lineno)s]::%(message)s"))
    logger.addHandler(console_handler)
    logger.setLevel(logging.DEBUG)

    logger.info("STARTED Makefile Analyzer")

    # read arguments and create RunConfiguration
    arguments = docopt(__doc__)
    try:
        arguments = docopt_schema.validate(arguments)
    except SchemaError as e:
        exit(e)

    target = arguments["--target-makefile"]
    target_project_root = arguments[ "--target-project"]
    compilers = arguments["--compiler"].split(",")
    dp_path = arguments["--dp-path"]
    dp_build_path = arguments["--dp-build-path"]
    clang_bin = arguments["--clang-bin"]
    clangxx_bin = arguments["--clang++-bin"]
    llvm_link_bin = arguments["--llvm-link-bin"]
    execution_mode = arguments["--exec-mode"]

    try:
        execution_mode = ExecutionMode(execution_mode)
    except ValueError:
        raise ValueError("Value of argument 'execution_mode': '" + execution_mode + "' not allowed. " +
                         "Please set a valid value.")

    run_configuration = RunConfiguration()
    run_configuration.target_makefile = target
    run_configuration.target_project_root = target_project_root
    run_configuration.compilers = compilers
    run_configuration.execution_mode = execution_mode
    run_configuration.dp_path = dp_path
    run_configuration.dp_build_path = dp_build_path
    run_configuration.clang_bin = clang_bin
    run_configuration.clangxx_bin = clangxx_bin
    run_configuration.llvm_link_bin = llvm_link_bin

    logger.info("\n%s", run_configuration)

    # run the analyzer with the provided configuration
    analyze_makefile(run_configuration)

    logger.info("STOPPED Makefile Analyzer")


if __name__ == "__main__":
    main()