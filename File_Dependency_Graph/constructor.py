import sys
from .graph import FileDependencyGraph
from typing import Dict, List, Optional
from DP_Maker_Classes.Command import Command, CmdType


def construct_graph_from_commands(grouped_commands: List[List[Command]]):
    cmd_graph = FileDependencyGraph()

    compiled_files_dict: Dict[str, Command] = dict()  # maps compiled file to the generating command
    last_command_buffer: Optional[Command] = None
    for group in grouped_commands:
        for cmd in group:
            if cmd.cmd_type == CmdType.COMPILE:
                if "-c" in cmd.flags:
                    print("COMP: ", cmd)
                    # cmd is compilation statement
                    # get name of output file:
                    output_file_name = ""
                    for flag in cmd.flags:
                        if flag.startswith("-o "):
                            output_file_name = flag.split(" ")[1]
                    print("--> ", output_file_name)
                    # add / overwrite entries in compiled_files_dict
                    compiled_files_dict[output_file_name] = cmd
                    # add compilation statements to the graph
                    cmd_graph.graph.add_node(cmd, data=(FileDependencyGraph.NodeType.COMPILE, output_file_name))
                    if last_command_buffer is not None:
                        cmd_graph.graph.add_edge(last_command_buffer, cmd)
                else:
                    # cmd is linking statement
                    print("LINK: ", cmd)
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
                print("OTHER: ", cmd)
                # add node for current cmd
                cmd_graph.graph.add_node(cmd, data=(FileDependencyGraph.NodeType.OTHER, "Unknown"))
                if last_command_buffer is not None:
                    cmd_graph.graph.add_edge(last_command_buffer, cmd)
                last_command_buffer = cmd


    cmd_graph.plot_graph()
    sys.exit(0)