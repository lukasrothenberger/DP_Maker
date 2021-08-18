import sys
from .graph import FileDependencyGraph
from typing import Dict, List, Optional
from DP_Maker_Classes.Command import Command, CmdType


def construct_graph_from_commands(grouped_commands: List[List[Command]]) -> FileDependencyGraph:
    cmd_graph = FileDependencyGraph()

    compiled_files_dict: Dict[str, Command] = dict()  # maps compiled file to the generating command
    last_command_buffer: Optional[Command] = None
    for group_idx, group in enumerate(grouped_commands):
        for cmd in group:
            cmd.group_id = group_idx
            if cmd.cmd_type == CmdType.COMPILE:
                if "-c" in cmd.flags:
                    # cmd is compilation statement
                    # get name of output file:
                    output_file_name = ""
                    for flag in cmd.flags:
                        if flag.startswith("-o "):
                            output_file_name = flag.split(" ")[1]
                    # add / overwrite entries in compiled_files_dict
                    compiled_files_dict[output_file_name] = cmd
                    # add compilation statements to the graph
                    cmd_graph.graph.add_node(cmd, data=(FileDependencyGraph.NodeType.COMPILE, output_file_name))
                    if last_command_buffer is not None:
                        cmd_graph.graph.add_edge(last_command_buffer, cmd)
                else:
                    # cmd is linking statement
                    # get output file name
                    output_file_name = "UNDEF"
                    for flag in cmd.flags:
                        if flag.startswith("-o "):
                            output_file_name = flag.split(" ")[1]
                    compiled_files_dict[output_file_name] = cmd
                    # add graph node for link statement
                    cmd_graph.graph.add_node(cmd, data=(FileDependencyGraph.NodeType.LINK, output_file_name))
                    # get input files
                    for input_file in cmd.non_flag_arguments:
                        if input_file.endswith(".ll"):
                            # get command producing the current input file
                            if input_file in compiled_files_dict:
                                producing_cmd = compiled_files_dict[input_file]
                                # add edges to the graph
                                cmd_graph.graph.add_edge(producing_cmd, cmd)
                    last_command_buffer = cmd

            else:
                # cmd is not a compile statement
                # add node for current cmd
                cmd_graph.graph.add_node(cmd, data=(FileDependencyGraph.NodeType.OTHER, "Unknown"))
                if last_command_buffer is not None:
                    cmd_graph.graph.add_edge(last_command_buffer, cmd)
                last_command_buffer = cmd

    return cmd_graph
