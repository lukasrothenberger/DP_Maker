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
    node_id: int
    commands: List[Tuple[(Optional[Command], GraphCommandType)]]
    consumed_files: List[str]
    produced_files: List[str]

    def __init__(self):
        self.node_id = -42  # -42 acts as a dummy for the initialization
        self.commands = []
        self.consumed_files = []
        self.produced_files = []

    def __str__(self):
            return_str = ""
            #for cmd, cmd_type in self.commands:
            #    return_str += str(cmd_type) + ", "
            return_str += str(self.node_id)
            return return_str


class FileDependencyGraph(object):
    graph: nx.DiGraph

    def __init__(self):
        self.graph = nx.DiGraph()

    def plot_graph(self):
        plt.subplot(121)
        pos = nx.fruchterman_reingold_layout(self.graph)
        edges = self.graph.edges()
        colors = ["green" if self.graph[u][v]["type"] == "successor" else "red" for u, v in edges] # [self.graph[u][v]['color'] for u, v in edges]
        nx.draw(self.graph, pos, with_labels=False, arrows=True, font_weight='bold', edge_color=colors)
        labels = {}
        for node in self.graph.nodes:
            labels[node] = str(self.graph.nodes[node]["data"])
        nx.draw_networkx_labels(self.graph, pos, labels)
        plt.show()


    def simplify_graph(self):
        """checks for possible simplifications of the graph"""
        # todo breaks correctness
        # remove nodes from the graph
        # self.__no_branch_simplification()

        # graph optimization to generate better parallelizable makefiles
        self.__add_requirement_edges()
        # remove successor edges, if possible
        self.__remove_successor_edges()
        pass


    def __remove_successor_edges(self):
        """removes successor type edges from the graph"""
        to_be_removed = []
        for edge in self.graph.edges:
            if self.graph[edge[0]][edge[1]]["type"] == "successor":
                # if target node has any incoming or outgoing requirement edge, the current successor edge can be removed
                edge_can_be_removed = False
                # check incoming edges
                for in_edge in self.graph.in_edges(edge[1]):
                    if self.graph[in_edge[0]][in_edge[1]]["type"] == "requirement":
                        edge_can_be_removed = True
                        break
                # check outgoing edges
                if not edge_can_be_removed:
                    for out_edge in self.graph.out_edges(edge[1]):
                        if self.graph[out_edge[0]][out_edge[1]]["type"] == "requirement":
                            edge_can_be_removed = True
                            break
                # remove edge if possible
                if edge_can_be_removed:
                    to_be_removed.append(edge)
        for edge in to_be_removed:
            self.graph.remove_edge(edge[0], edge[1])


    def __add_requirement_edges(self):
        """creates requirement type edges from producing to consuming nodes"""
        # iterate over all nodes in graph
        for node in self.graph.nodes:
            # iterate over consumed files
            for consumed_file in self.graph.nodes[node]["data"].consumed_files:
                # search for producing nodes by upwards-search through the graph
                for predecessor, _ in self.graph.in_edges(node):
                    self.__recursive_add_requirement_edges(predecessor, consumed_file, node, [])


    def __recursive_add_requirement_edges(self, root_node, file, target, visited):
        """recursively checks for nodes producing the specified file and creates requirement edges to the target node."""
        if file in self.graph.nodes[root_node]["data"].produced_files:
            # producer has been found
            self.graph.add_edge(root_node, target, type="requirement")
            return
        visited.append(root_node)
        # traverse upwards
        # iteratively, if only one predecessor exists, recursively if multiple exist
        while len(self.graph.in_edges(root_node)) == 1:
            root_node = list(self.graph.in_edges(root_node))[0][0]
            if file in self.graph.nodes[root_node]["data"].produced_files:
                # producer has been found
                self.graph.add_edge(root_node, target, type="requirement")
                return
            visited.append(root_node)

        for predecessor, _ in self.graph.in_edges(root_node):
            if predecessor in visited:
                continue
            self.__recursive_add_requirement_edges(predecessor, file, target, visited)


    def __requirement_based_simplification(self):
        """creates direct edges from requirement producing to consuming nodes.
        removes redundant edges if possible.
        the abstract purpose of this pass is to reduce the average length of paths through the graph,
        potentially resulting in a better parallel performance of the makefile."""
        # todo


    def __no_branch_simplification(self):
        """combines two nodes, if the predecessor has exactly one successor, and the successor has exactly
        one predecessor."""
        combination_found = True
        while combination_found:
            combination_found = False
            for node in self.graph.nodes:
                if len(self.graph.out_edges(node)) == 1:
                    __, successor_node = list(self.graph.out_edges(node))[0]
                    if len(self.graph.in_edges(successor_node)) == 1:
                        # combination possible
                        # append commands of successor to the first node
                        self.graph.nodes[node]["data"].commands += self.graph.nodes[successor_node]["data"].commands
                        # combine produced files
                        self.graph.nodes[node]["data"].produced_files += self.graph.nodes[successor_node]["data"].produced_files
                        # no need to combine consumed files, as the successor only has a requirement to the preceeding node
                        # redirect child edges of successor
                        to_be_removed = []
                        for src, dest in self.graph.out_edges(successor_node):
                            # create new edge
                            self.graph.add_edge(node, dest, type="successor")
                            # mark old edge for removal
                            to_be_removed.append((src, dest))
                        for edge in to_be_removed:
                            self.graph.remove_edge(edge[0], edge[1])
                        # remove successor node
                        self.graph.remove_node(successor_node)
                        combination_found = True
                        break


    def write_makefile(self, makefile, run_configuration, last_dir):
        """exports the contents of the graph into a makefile"""
        for node_id in sorted(self.graph.nodes):
            # check for root node
            if node_id == -1:
                # root node
                # get all nodes without successors as requirements
                root_requirements = [id for id in self.graph.nodes if len(self.graph.out_edges(id)) == 0]
                # write first line
                makefile.write("all:")
                for requirement in root_requirements:
                    makefile.write(" " + str(requirement))
                makefile.write("\n")

            # use node_id as rule_id
            rule_id = node_id
            # gather requirements
            requirement_node_ids = [source for source, _ in self.graph.in_edges(node_id)]
            # write rule definition line to makefile
            makefile.write(str(rule_id) + ":")
            for requirement in requirement_node_ids:
                makefile.write(" " + str(requirement))
            makefile.write("\n")

            # write commands to makefile
            for cmd_idx, (cmd, cmd_type) in enumerate(self.graph.nodes[node_id]["data"].commands):
                if cmd is None:
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

                # add llvm-link instruction to the makefile, if the execution mode is DEP
                if run_configuration.execution_mode is ExecutionMode.DEP_ANALYSIS:
                    # if cmd is link type, add llvm-link instruction to the makefile
                    if cmd_type == GraphCommandType.LINK:
                        makefile.write("\t")
                        # add cd instruction at the beginning of the current command if necessary
                        if cmd_idx > 0:
                            if not str(self.graph.nodes[node_id]["data"].commands[cmd_idx - 1][0]).endswith("\\"):
                                makefile.write("cd " + last_dir + " && ")
                        else:
                            makefile.write("cd " + last_dir + " && ")

                        # add llvm-link instruction # todo: replace llvm-link with parameter (path to llvm-link)
                        makefile.write(run_configuration.llvm_link_bin + " -S -o ")
                        # write produced file
                        produced_file = self.graph.nodes[node_id]["data"].produced_files[0]
                        produced_file = produced_file+"_dp_inst.ll"
                        makefile.write(produced_file+" ")
                        # write consumed files
                        makefile.write(" ".join(self.graph.nodes[node_id]["data"].consumed_files))
                        makefile.write(";\n")




