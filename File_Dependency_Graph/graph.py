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
            print("node: ", node_id)
            # check for root node
            if node_id == -1:
                # root node
                # get all nodes without successors as requirements
                root_requirements = [id for id in self.graph.nodes if len(self.graph.out_edges(id)) == 0]
                print("Root requirements: ", root_requirements)
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
            for cmd, cmd_type in self.graph.nodes[node_id]["data"].commands:
                if cmd is None:
                    # todo marker: could be used to identify root
                    continue
                cmd.prepare_output()
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
                makefile.write("\t" + cmd_str + "\n")





    def write_makefile(self, makefile, run_configuration, last_dir):
        """exports the contents of the graph into a makefile"""
        next_free_rule_id = 1
        rule_command_dict: Dict[int, List[Command]] = dict()
        rule_requirement_dict: Dict[int, List[int]] = dict()
        rule_command_dict[0] = []
        rule_requirement_dict[0] = []
        command_to_rule_dict: Dict[Command, int] = dict()

        # get nodes of different types:
        entry_nodes = []
        split_nodes = []
        merge_nodes = []
        regular_nodes = []
        for node in self.graph.nodes:
            if len(self.graph.out_edges(node)) == 1 and len(self.graph.in_edges(node)) == 1:
                regular_nodes.append(node)
                continue
            if len(self.graph.out_edges(node)) == 0:
                entry_nodes.append(node)
                continue
            if len(self.graph.out_edges(node)) > 0:
                split_nodes.append(node)
                continue
            if len(self.graph.in_edges(node)) > 0:
                merge_nodes.append(node)

        # give rule_id's to entry nodes
        for cur_node in entry_nodes:
            rule_id = next_free_rule_id
            next_free_rule_id += 1
            # root nodes have no requirements
            rule_requirement_dict[rule_id] = []
            rule_command_dict[rule_id] = [cur_node]
            # add root nodes as requirements to rule 0
            rule_requirement_dict[0].append(rule_id)
            command_to_rule_dict[cur_node] = rule_id

        # give rule_id's to merge predecessors
        for merge_node in merge_nodes:
            for predecessor in self.graph.predecessors(merge_node):
                # give each predecessor a rule id
                rule_id = next_free_rule_id
                next_free_rule_id += 1
                rule_command_dict[rule_id] = [predecessor]
                command_to_rule_dict[predecessor] = rule_id

        # give rule_id's to split nodes
        for split_node in split_nodes:
            rule_id = next_free_rule_id
            next_free_rule_id += 1
            rule_command_dict[rule_id] = [split_node]
            command_to_rule_dict[split_node] = rule_id

        # escalate rule id's from already assigned nodes to such with no assigned rule id
        # todo not efficient, can probably be improved
        found_modification = True
        while found_modification:
            found_modification = False
            for node in self.graph.nodes:
                # check if rule assigned
                if node not in command_to_rule_dict:
                    continue
                # check if only one predecessor exists
                if len(list(self.graph.predecessors(node))) == 1:
                    predecessor = list(self.graph.predecessors(node))[0]
                    # check if predecessor has rule_id
                    if predecessor in command_to_rule_dict:
                        continue
                    else:
                        # assign rule_id to predecessor
                        command_to_rule_dict[predecessor] = command_to_rule_dict[node]
                        # todo maybe remove
                        rule_command_dict[command_to_rule_dict[node]].insert(0, predecessor)
                        # restart outer loop
                        found_modification = True
                        break

        # fix nodes which are still without rule by stealing from the successor
        for node in regular_nodes:
            if node not in command_to_rule_dict:
                successor = list(self.graph.successors(node))[0]
                if successor not in merge_nodes:
                    command_to_rule_dict[node] = command_to_rule_dict[successor]
                    rule_command_dict[command_to_rule_dict[node]].insert(0, node)

        # set requirements
        for node in self.graph.nodes:
            for predecessor in self.graph.predecessors(node):
                # check if predecessor belongs to different rule
                if command_to_rule_dict[node] == command_to_rule_dict[predecessor]:
                    continue
                # predecessor belongs to different rule
                # create requirement list in not already existing
                if command_to_rule_dict[node] not in rule_requirement_dict:
                    rule_requirement_dict[command_to_rule_dict[node]] = []
                # add requirement if not already existing
                if command_to_rule_dict[predecessor] not in rule_requirement_dict[command_to_rule_dict[node]]:
                    rule_requirement_dict[command_to_rule_dict[node]].append(command_to_rule_dict[predecessor])

        ### write makefile ###
        # write root rule
        makefile.write("all: " + " ".join([str(r) for r in rule_requirement_dict[0]]) + "\n\n")
        # remove root rule from requirements dict and rule_command_dict
        del rule_requirement_dict[0]
        del rule_command_dict[0]

        # create rule_requirement_dict entries if necessary
        for rule_id in rule_command_dict:
            if rule_id not in rule_requirement_dict:
                rule_requirement_dict[rule_id] = []

        # iterate over rule id's
        for rule_id in rule_command_dict:
            # write rule number and requirements
            makefile.write("" + str(rule_id) + ": " + " ".join([str(r) for r in rule_requirement_dict[rule_id]]) + "\n")
            # write commands
            for cmd_idx, cmd in enumerate(rule_command_dict[rule_id]):
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

                # add cd prior to the cmd if it's the beginning of a rule's body or the previous statement belongs to a different group
                if cmd_idx == 0:
                    makefile.write("\tcd " + last_dir + " && ")
                elif rule_command_dict[rule_id][cmd_idx].group_id != rule_command_dict[rule_id][cmd_idx - 1].group_id:
                    makefile.write("\tcd " + last_dir + " && ")

                makefile.write("\t" + cmd_str)
                # write \\ to the end of the line if group_id of the current and next cmd are equal
                if cmd_idx + 1 < len(rule_command_dict[rule_id]):
                    if cmd.group_id == rule_command_dict[rule_id][cmd_idx + 1].group_id:
                        makefile.write(" \\")
                makefile.write("\n")
