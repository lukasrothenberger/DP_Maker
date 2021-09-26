import networkx as nx  # type:ignore
import matplotlib.pyplot as plt  # type:ignore

from networkx.drawing.nx_agraph import graphviz_layout  # type:ignore
from typing import List, Tuple, Dict, Optional
from enum import Enum
from DP_Maker_Classes.Command import Command, CmdType
from DP_Maker_Classes.RunConfiguration import ExecutionMode


class GraphCommandType(Enum):
    COMPILE = "compile"
    LINK = "link"
    OTHER = "other"
    ROOT = "root"


class Node(object):
    commands: List[Tuple[(Optional[Command], GraphCommandType)]]
    consumed_files: List[str]
    produced_files: List[str]

    def __init__(self):
        self.commands = []
        self.consumed_files = []
        self.produced_files = []

    def __str__(self):
            return_str = ""
            for cmd, cmd_type in self.commands:
                return_str += str(cmd_type) + ", "
            return return_str


class FileDependencyGraph(object):
    graph: nx.DiGraph

    def __init__(self):
        self.graph = nx.DiGraph()

    def plot_graph(self):
        plt.subplot(121)
        pos = nx.fruchterman_reingold_layout(self.graph)
        nx.draw(self.graph, pos, with_labels=False, arrows=True, font_weight='bold')
        labels = {}
        for node in self.graph.nodes:
            labels[node] = str(self.graph.nodes[node]["data"])
        nx.draw_networkx_labels(self.graph, pos, labels)
        plt.show()


    def simplify_graph(self):
        """TODO"""
        # todo
        pass


    def new_write_makefile(self, makefile, run_configuration, last_dir):
        """exports the contents of the graph into a makefile"""
        for node_id in sorted(self.graph.nodes):
            # check for root node
            if node_id == -1:
                # root node
                # get all nodes without successors as requirements
                root_requirements = [id for id in self.graph.nodes if len(self.graph.out_edges(id)) == 0]
                # write first line
                makefile.write(str(node_id) + ":")
                for requirement in root_requirements:
                    makefile.write(" " + str(requirement))
                makefile.write("\n")
                continue
            # use node_id as rule_id
            rule_id = node_id
            # gather requirements
            requirement_node_ids = [source for source, _ in self.graph.in_edges(node_id)]
            # write rule definition line to makefile
            makefile.write(str(rule_id) + ":")
            for requirement in requirement_node_ids:
                # exclude root node from requirements
                # todo: more efficient solution: delete edges from root
                if requirement == -1:
                    continue
                makefile.write(" " + str(requirement))
            makefile.write("\n")

            # write commands to makefile
            for cmd_idx, (cmd, cmd_type) in enumerate(self.graph.nodes[node_id]["data"].commands):
                if cmd is None:
                    # todo marker: could be used to identify root
                    continue
                cmd.prepare_output()
                if cmd.cmd_type in [CmdType.EXIT_DIR, CmdType.ENTER_DIR]:
                    last_dir = "" + cmd.exit_dir + cmd.enter_dir
                cmd_str = str(cmd)
                # replace DP-Shared Object marker with Instrumentation
                if run_configuration.execution_mode is ExecutionMode.DEP_ANALYSIS:
                    cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                              run_configuration.dp_build_path + "/libi/LLVMDPInstrumentation.so")
                elif run_configuration.execution_mode is ExecutionMode.CU_GENERATION:
                    cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                              run_configuration.dp_build_path + "/libi/LLVMCUGeneration.so")
                elif run_configuration.execution_mode is ExecutionMode.DP_REDUCTION:
                    cmd_str = cmd_str.replace("##DPSHAREDOBJECT##",
                                              run_configuration.dp_build_path + "/libi/LLVMDPReduction.so")
                else:
                    raise ValueError("Unrecognized Execution Mode: ", run_configuration.execution_mode)
                # replace DP-FMAP marker with path of FileMapping.txt
                cmd_str = cmd_str.replace("##DPFILEMAPPING##",
                                          run_configuration.target_project_root + "/FileMapping.txt")
                # replace § signs introduced by the preprocessor with whitespaces
                cmd_str = cmd_str.replace("§", " ")
                # replace # signs introduced by the preprocessor with semicolon
                cmd_str = cmd_str.replace("#", ";")
                makefile.write("\t")
                # add cd instruction at the beginning of the current command if necessary
                if cmd_idx > 0:
                    if not str(self.graph.nodes[node_id]["data"].commands[cmd_idx-1][0]).endswith("\\"):
                        makefile.write("cd " + last_dir + " && ")
                else:
                    makefile.write("cd " + last_dir + " && ")

                makefile.write(cmd_str + "\n")
