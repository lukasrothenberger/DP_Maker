"""Discopop Makefile Analyzer and Execution Driver

Usage:
    Makefile_Analyzer --dp-path <path> --dp-build-path <path --exec-mode <mode> [--target <path>] [--compiler <name>]

Options:
    --exec-mode=<mode>      Specifies the mode of operation. Available values are: [dep, cu_gen, dp_red]
    --dp-path=<path>        Path to DiscoPoP folder
    --dp-build-path=<path>  Path to DiscoPoP build folder
    --target=<path>         Path of the target Makefile [default: ./Makefile]
    --compiler=<name>       Name of the used compile command (e.g. gcc, clang etc.)
                            If multiple compilers are used, a comma separated list can be supplied (e.g gcc,clang)
                            [default: gcc,clang,g++,clang++]
    -h --help               Show this screen
"""
import os
import sys

from docopt import docopt  # type:ignore
from schema import SchemaError, Schema, Use  # type:ignore

from DP_Maker_Classes.RunConfiguration import RunConfiguration
from .analyzer import analyze_makefile
from DP_Maker_Classes.RunConfiguration import ExecutionMode

docopt_schema = Schema({
    '--target': Use(str),
    '--compiler': Use(str),
    '--dp-path': Use(str),
    '--dp-build-path': Use(str),
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
    arguments = docopt(__doc__)
    try:
        arguments = docopt_schema.validate(arguments)
    except SchemaError as e:
        exit(e)

    target = arguments["--target"]
    compilers = arguments["--compiler"].split(",")
    dp_path = arguments["--dp-path"]
    dp_build_path = arguments["--dp-build-path"]
    execution_mode = arguments["--exec-mode"]

    try:
        execution_mode = ExecutionMode(execution_mode)
    except ValueError:
        raise ValueError("Value of argument 'execution_mode': '" + execution_mode + "' not allowed. " +
                         "Please set a valid value.")

    run_configuration = RunConfiguration()
    run_configuration.target_makefile = target
    run_configuration.compilers = compilers
    run_configuration.execution_mode = execution_mode
    run_configuration.dp_path = dp_path
    run_configuration.dp_build_path = dp_build_path
    print(str(run_configuration))

    analyze_makefile(run_configuration)


if __name__ == "__main__":
    main()