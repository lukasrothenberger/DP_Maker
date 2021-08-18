import networkx as nx  # type:ignore
import matplotlib.pyplot as plt  # type:ignore

from networkx.drawing.nx_agraph import graphviz_layout  # type:ignore
from typing import List, Tuple, Dict
from enum import Enum
from DP_Maker_Classes.Command import Command


class FileDependencyGraph(object):
    graph: nx.DiGraph

    def __init__(self):
        self.graph = nx.DiGraph()

    class NodeType(Enum):
        COMPILE = "compile"
        LINK = "link"
        OTHER = "other"

    def plot_graph(self):
        plt.subplot(121)
        pos = nx.fruchterman_reingold_layout(self.graph)
        nx.draw(self.graph, pos, with_labels=False, arrows=True, font_weight='bold')
        labels = {}
        for node in self.graph.nodes:
            labels[node] = str(self.graph.nodes[node]["data"][1])
        nx.draw_networkx_labels(self.graph, pos, labels)
        plt.show()

    def write_makefile(self, makefile):
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
            is_regular = True
            if len(self.graph.out_edges(node)) == 0:
                entry_nodes.append(node)
                is_regular = False
            if len(self.graph.out_edges(node)) > 0:
                split_nodes.append(node)
                is_regular = False
            if len(self.graph.in_edges(node)) > 0:
                merge_nodes.append(node)
                is_regular = False
            if is_regular:
                regular_nodes.append(node)

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
                if len(list(self.graph.predecessors(node))) != 1:
                    continue
                # check if predecessor has no rule_id assigned yet (split nodes already have an assigned rule_id)
                predecessor = list(self.graph.predecessors(node))[0]
                if predecessor in command_to_rule_dict:
                    continue
                # assign rule_id to predecessor
                command_to_rule_dict[predecessor] = command_to_rule_dict[node]
                # restart outer loop
                found_modification = True
                break

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
        makefile.write("all: "+ " ".join([str(r) for r in rule_requirement_dict[0]]) + "\n")



        makefile.write("asdf\n")