import os
import subprocess
from typing import List


class CompilerFlagInformation(object):
    flag: str
    separators: List[str]  # note: separator " " can also be ""
    has_argument: bool

    def __init__(self, flag: str, separators: List[str], has_argument: bool):
        self.flag = flag
        self.separators = separators
        self.has_argument = has_argument

    def get_tuple(self):
        return self.flag, self.separators, self.has_argument

    def __str__(self):
        if self.has_argument:
            return self.flag + " " + str(self.separators) + " <ARG>"
        else:
            return self.flag


def get_compiler_argument_information(compiler_cmd: str) -> List[CompilerFlagInformation]:
    res_list: List[CompilerFlagInformation] = []
    # get help screen from compile-command
    get_help_command = "LANGUAGE=en " + compiler_cmd + " --help -v"
    stream = subprocess.Popen(get_help_command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
    out,err = stream.communicate()
    for line in out.splitlines():
        # split at spaces
        split_line = line.split(" ")
        split_line = [e for e in split_line if len(e) > 0]
        # get indices of flags
        flag_indices: List[int] = []
        for idx, elem in enumerate(split_line):
            if elem.startswith("-"):
                flag_indices.append(idx)
        for idx in flag_indices:
            # ignore flags mentioned at the end of a line
            if idx + 1 >= len(split_line):
                continue
            # check for arguments in element
            has_required_argument = False
            has_optional_argument = False
            separators = []
            if "[=" in split_line[idx]:
                # has optional argument
                has_optional_argument = True
                separators.append("=")
            elif "=" in split_line[idx]:
                # has required argument
                has_required_argument = True
                separators.append("=")
            # check for arguments after element
            if split_line[idx+1].isupper():
                # gcc style argument after flag
                has_required_argument = True
                separators.append(" ")
                separators.append("")
            elif split_line[idx+1].startswith("<"):
                # clang style argument after flag
                has_required_argument = True
                separators.append(" ")
                separators.append("")
            # create (multiple) CompilerFlagInformation object
            if "[" in split_line[idx]:
                flag = split_line[idx][:split_line[idx].index("[")]
            elif "=" in split_line[idx]:
                flag = split_line[idx][:split_line[idx].index("=")]
            else:
                flag = split_line[idx]

            if flag.endswith(","):
                flag = flag.replace(",", "")
            if flag == "-" or flag == "--":
                continue

            if has_required_argument:
                res_list.append(CompilerFlagInformation(flag, separators, has_required_argument))
            elif has_optional_argument:
                res_list.append(CompilerFlagInformation(flag, separators, True))
                res_list.append(CompilerFlagInformation(flag, separators, False))
            else:
                res_list.append(CompilerFlagInformation(flag, separators, False))
    # remove duplicates from res_list
    filtered_res_list: List[CompilerFlagInformation] = []
    tmp_seen_tuples = []

    for e in res_list:
        if e.get_tuple() in tmp_seen_tuples:
            continue
        tmp_seen_tuples.append(e.get_tuple())
        filtered_res_list.append(e)
    return filtered_res_list
