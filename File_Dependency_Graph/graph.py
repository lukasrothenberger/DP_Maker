import networkx as nx  # type:ignore
import matplotlib.pyplot as plt  # type:ignore

from networkx.drawing.nx_agraph import graphviz_layout  # type:ignore
from typing import List, Tuple, Dict
from enum import Enum


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