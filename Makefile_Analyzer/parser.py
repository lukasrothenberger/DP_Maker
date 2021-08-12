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
    raw_cmd_elements = cmd.split(" ")
    # filter out empty elements
    raw_cmd_elements = [e for e in raw_cmd_elements if len(e) > 0]
    # check for type of command
    if raw_cmd_elements[0].startswith("make["):
        return __check_for_directory_changes(cmd, raw_cmd_elements)
    elif raw_cmd_elements[0] in compilers:
        # compiler command
        # group flags and arguments together
        print()
        print(raw_cmd_elements)
        modification_found = True
        finished_cmd_elements = []
        while modification_found:
            modification_found, raw_cmd_elements, finished_cmd_elements = __group_flags_and_arguments(raw_cmd_elements, finished_cmd_elements,
                                                                           compiler_flag_information_dict[raw_cmd_elements[0]])
        print("raw: ", raw_cmd_elements)
        print("finished: ", finished_cmd_elements)
        # todo return Command
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


def __group_flags_and_arguments(raw_cmd_elems: List[str], finished_cmd_elems: List[str], available_compiler_flags: List[CompilerFlagInformation])\
        -> Tuple[bool, List[str]]:
    """groups a single flag and its arguments together into one string, if they belong together.
    returns a tuple containing a boolean, which is true if a modification has been done,
    and the updated list of command elements."""
    sorted_avail_compiler_flags = sorted(available_compiler_flags, key=lambda x: len(x.flag), reverse=True)

    for idx, cur_str in enumerate(raw_cmd_elems):
        # check if last element is reached
        if idx+1 == len(raw_cmd_elems):
            continue
        if not cur_str.startswith("-"):
            continue
        # check if cur_str is flag
        print("CUR STR: ", cur_str)
        for cfi in sorted_avail_compiler_flags:
            if cur_str.startswith(cfi.flag):
                # cur_str is flag
                print("\t-->Is flag: ", cfi.get_tuple())
                print("\t-->Separators: ", cfi.separators)

                # check if argument included
                if cfi.has_argument:
                    for sep in cfi.separators:
                        if cur_str.startswith(cfi.flag + sep) and len(cur_str) > len(cfi.flag + sep):
                            # cur_elem includes argument, mark cur_str as finished
                            finished_cmd_elems.append(raw_cmd_elems.pop(idx))
                            return True, raw_cmd_elems, finished_cmd_elems
                else:
                    # no argument necessary
                    finished_cmd_elems.append(raw_cmd_elems.pop(idx))
                    return True, raw_cmd_elems, finished_cmd_elems


    return False, raw_cmd_elems, finished_cmd_elems
