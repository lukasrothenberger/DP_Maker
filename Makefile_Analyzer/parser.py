from typing import List, Tuple, Dict
from DP_Maker_Classes.Command import CmdType, Command
from Helper.compiler_information import CompilerFlagInformation


def parse_command(cmd: str, compilers: List[str],
                  compiler_flag_information_dict: Dict[str, List[CompilerFlagInformation]]) -> Command:
    """parses the given command and returns the gathered information in form of a Command-object.
    :param cmd: command to be parsed
    :param compilers: List of known compiler commands
    :param compiler_flag_information_dict: Dictionary containing information on available Flags per compiler
    :return: Command-Object representation of the given command."""
    # split cmd into elements
    cmd_elements = cmd.split(" ")
    # filter out empty elements
    cmd_elements = [e for e in cmd_elements if len(e) > 0]
    # check for type of command
    if cmd_elements[0].startswith("make["):
        return __check_for_directory_changes(cmd, cmd_elements)
    elif cmd_elements[0] in compilers:
        # compiler command
        # group flags and arguments together
        print()
        print(cmd_elements)
        modification_found = True
        while modification_found:
            modification_found, cmd_elements = __group_flags_and_arguments(cmd_elements, compiler_flag_information_dict)
        print(cmd_elements)
    else:
        # unknown command, leave as is
        return Command(cmd, CmdType.UNKNOWN)


def __check_for_directory_changes(cmd: str, cmd_elements: List[str]) -> Command:
    """checks if the given command represents a directory change and returns the resulting Command object."""
    # check for directory changes
    if cmd_elements[1] == "Leaving":
        leave_dir = cmd_elements[-1].replace("\n", "")
        ret_cmd = Command(cmd, CmdType.EXIT_DIR)
        ret_cmd.exit_dir = leave_dir
        return ret_cmd
    elif cmd_elements[1] == "Entering":
        enter_dir = cmd_elements[-1].replace("\n", "")
        ret_cmd = Command(cmd, CmdType.ENTER_DIR)
        ret_cmd.enter_dir = enter_dir
        return ret_cmd
    else:
        # unknown operation
        return Command(cmd, CmdType.UNKNOWN)


def __group_flags_and_arguments(cmd_elems: List[str], compiler_flag_information_dict: Dict[str, List[CompilerFlagInformation]])\
        -> Tuple[bool, List[str]]:
    """groups flags and arguments together into one string, if they belong together.
    returns a tuple containing a boolean, which is true if a modification has been done,
    and the updated list of command elements."""
    modification_found = False
    for idx, cur_str in enumerate(cmd_elems):
        # check if last element is reached
        if idx+1 == len(cmd_elems):
            continue


    return modification_found, cmd_elems
