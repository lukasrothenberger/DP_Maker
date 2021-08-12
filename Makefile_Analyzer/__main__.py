"""Discopop Makefile Analyzer and Execution Driver

Usage:
    Makefile_Analyzer [--t <path>] [--compiler <name>]

Options:
    --t=<path>              Path of the target Makefile [default: ./Makefile]
    --compiler=<name>       Name of the used compile command (e.g. gcc, clang etc.)
                            If multiple compilers are used, a comma separated list can be supplied (e.g gcc,clang)
                            [default: gcc,clang,g++,clang++]
    -h --help               Show this screen
"""
import os

from docopt import docopt  # type:ignore
from schema import SchemaError, Schema, Use  # type:ignore

from .analyzer import analyze_makefile

docopt_schema = Schema({
    '--t': Use(str),
    '--compiler': Use(str)
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

    target = arguments["--t"]
    compilers = arguments["--compiler"].split(",")
    print("Target: ", target)
    print("Compilers: ", compilers)

    analyze_makefile(target, compilers)

if __name__ == "__main__":
    main()