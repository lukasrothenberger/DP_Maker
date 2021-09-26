import sys
from .graph import FileDependencyGraph, Node, GraphCommandType
from typing import Dict, List, Optional
from DP_Maker_Classes.Command import Command, CmdType


def construct_graph_from_commands(grouped_commands: List[List[Command]]) -> FileDependencyGraph:
    """nodes in the graph represent a rule in the resulting makefile, and thus contain a set of instructions"""
    cmd_graph = FileDependencyGraph()

    compiled_files_dict: Dict[str, int] = dict()  # maps compiled file to the generating graph node id
    last_node_id: int = -1
    # construct root node
    root_node = Node()
    root_node.commands.append((None, GraphCommandType.ROOT))
    cmd_graph.graph.add_node(-1, data=root_node)

    for group_idx, group in enumerate(grouped_commands):
        # all commands from one group are gathered in a single graph node
        group_node = Node()
        for cmd_idx, cmd in enumerate(group):
            cmd.group_id = group_idx
            # set line ending if command is contained in group with >1 element
            group_len = len(group)
            if group_len > 1:
                if cmd_idx < group_len - 1:
                    cmd.line_ending += " \\"
            if cmd.cmd_type == CmdType.COMPILE:
                if "-c" in cmd.flags:
                    # cmd is compilation statement
                    # get name of output file:
                    output_file_name = ""
                    for flag in cmd.flags:
                        if flag.startswith("-o "):
                            output_file_name = flag.split(" ")[1]
                    # add / overwrite entries in compiled_files_dict
                    compiled_files_dict[output_file_name] = group_idx
                    # add compilation statements to the graph node
                    group_node.commands.append((cmd, GraphCommandType.COMPILE))
                else:
                    # cmd is linking statement
                    # get output file name
                    output_file_name = "UNDEF"
                    for flag in cmd.flags:
                        if flag.startswith("-o "):
                            output_file_name = flag.split(" ")[1]
                    compiled_files_dict[output_file_name] = group_idx
                    # add graph node for link statement
                    group_node.commands.append((cmd, GraphCommandType.LINK))
                    # get input files
                    for input_file in cmd.non_flag_arguments:
                        if input_file.endswith(".ll"):
                            # get command producing the current input file
                            if input_file in compiled_files_dict:
                                group_node.consumed_files.append(input_file)
                                producing_node_id = compiled_files_dict[input_file]
                                # add edges to the graph
                                cmd_graph.graph.add_edge(producing_node_id, group_idx)

            else:
                # cmd is not a compile statement
                # add current cmd
                group_node.commands.append((cmd, GraphCommandType.OTHER))
        # add node to the graph
        cmd_graph.graph.add_node(group_idx, data=group_node)
        # add edge from previously created node
        cmd_graph.graph.add_edge(last_node_id, group_idx)
        # update last_node_id
        last_node_id = group_idx

    return cmd_graph
