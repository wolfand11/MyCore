#coding=utf-8
#author=guodong

import os
import os.path
import sys
import subprocess

class ProcessType:    
    ShowHelp = 0
    ExtractFile = 1
    ExtractFilesInDir = 2
    Invalid = 3
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg=="-h":
            return ProcessType.ShowHelp
        else:
            if os.path.exists(strArg):
                if os.path.isfile(strArg):
                    return ProcessType.ExtractFile
                else:
                    return ProcessType.ExtractFilesInDir
        return default

def ParseArgs(args):
    argcount = len(args)
    process_type = ProcessType.ShowHelp
    file_or_dir  = ""

    if argcount==1:
        pass
    elif argcount==2:
        process_type = ProcessType.ConvertStrTypeToType(args[1],ProcessType.ShowHelp)
        file_or_dir  = args[1]

    return process_type,file_or_dir

def ShowHelpInfo():
    print("usage (argcount=2): python ./XXXX.py -h  show help")
    print("usage (argcount=2): python ./XXXX.py unity-res-path")
    print("usage (argcount=2): python ./XXXX.py unity-res-file")

def Process(type,file_or_dir):
    if type==ProcessType.ShowHelp:
        ShowHelpInfo()
    elif type==ProcessType.ExtractFile:
        ExtractUnityResFile(file_or_dir)
    elif type==ProcessType.ExtractFilesInDir:
        ExtractUnityResInDir(file_or_dir)
        
def ExtractUnityResFile(file_full_path):
    disunity_tool_path = os.path.join(os.path.split(os.path.realpath(sys.argv[0]))[0],"disunity/disunity.jar")
    sys_command_list = ["java"];
    sys_command_list.append("-jar")
    sys_command_list.append(disunity_tool_path)
    sys_command_list.append("extract")
    sys_command_list.append(file_full_path)
    subprocess.call(sys_command_list)
    pass

def ExtractUnityResInDir(res_dir):
    for root,dirs,files in os.walk(res_dir):
        for file in files:                
            ExtractUnityResFile(os.path.join(root,file))
    pass
    
def main():
    print(sys.argv)
    process_type,file_or_dir = ParseArgs(sys.argv)
    Process(process_type,file_or_dir)
    
if __name__ == '__main__':
    main()
else:
    print(__name__)
    main()
