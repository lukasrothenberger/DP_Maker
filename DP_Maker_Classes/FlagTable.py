import csv
from typing import Dict, List, Tuple
from xmlrpc.client import Boolean

# TODO return None instead of empty strings?

class FlagTable(object):

    # TODO use instead dict[str, dict[str,str]] ??
    flagTable:List[Tuple[str, Dict[str, str]]] = []
    # e.g.:
    # gcc:  "-someFlag"  --> ""
    #       "-otherFlag" --> "-differentFlag"
    # g++:  ...          --> ...

    def __init__(self, compilerFilenameMapping:List[Tuple[str,str]]) -> None:
        for compiler, filename in compilerFilenameMapping:
            dict={}
            with open(filename, newline="") as f:
                reader = csv.reader(f)
                try:
                    for row in reader:
                        dict[row[0]]=row[1]
                except csv.Error as e:
                    print(f"ERROR: Could not initialize flagTable due to csv error: filename={filename} line={reader.line_num}: {e}" )
                    # TODO better error handling
            self.flagTable.append((compiler, dict))
    
    def __repr__(self) -> str:
        return f"{type(self).__name__}(filename={self.filename})"

    def getReplacementForFlag(self, compilerName:str, flag:str) -> str:
        for tuple in self.flagTable:
            if tuple[0] == compilerName:
                return tuple[1].get(flag, flag) # return replacement (or original flag, if there is no replacement configured)
        
        print(f"ERROR: no flag table for compiler found: {compilerName}")


    # Optimization so we do not have to find the correct dictionary for each query of a flag
    defaultCompilerSet:Boolean  = False
    defaultCompiler:str         = ""
    defaultFlagTable:Dict       = {}

    def setDefaultCompiler(self, compiler: str)-> None:
        found=False
        for tuple in self.flagTable:
            if tuple[0] == compiler:
                self.defaultCompilerSet=True
                self.defaultCompiler=compiler
                self.defaultFlagTable=tuple[1]
                return
        print(f"ERROR: there is no flagTable for compiler: {compiler}")
        # TODO better error handling
    
    def getDefaultCompilerReplacementForFlag(self, flag) -> str:
        if not self.defaultCompilerSet:
            print("ERROR: cannot get flag replacement as the default compiler is not set")
            # TODO better error handling
            return
        return self.defaultFlagTable.get(flag, flag) # return replacement (or original flag, if there is no replacement configured)
