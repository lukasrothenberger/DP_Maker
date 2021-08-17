from typing import List, Tuple


class RunConfiguration(object):
    target_makefile: str
    compilers: List[str]
    dp_path: str
    dp_build_path: str

    def __init__(self):
        pass

    def __str__(self):
        return  "########################" + "\n" + \
                "### RUN COFIGURATION ###" + "\n" + \
                "\ttarget: " + self.target_makefile + "\n" + \
                "\tcompilers: " + str(self.compilers) + "\n" + \
                "\tdp_path: " + self.dp_path + "\n" + \
                "\tdp_build_path: " + self.dp_build_path + "\n" + \
                "########################" + "\n"
