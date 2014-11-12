#coding=utf-8
#author:guodong

import os
import os.path
import sys
import shutil

def ContainsAny(str, set):
    for c in set:
        if c in str: return 1;
    return 0;


def ContainsAll(str, set):
    for c in set:
        if c not in str: return 0;
    return 1;

class ProcessType:    
    ShowHelp = 0
    ProcessSrc = 1
    ProcessRes = 2
    ProcessAll = 3
    Invalid = 4
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg=="-h":
            return ProcessType.ShowHelp
        elif strArg=="-src":
            return ProcessType.ProcessSrc
        elif strArg=="-res":
            return ProcessType.ProcessRes
        elif strArg=="-all":
            return ProcessType.ProcessAll                    
        return default

def ParseArgs(args):
    argcount = len(args)
    process_type = ProcessType.ShowHelp

    if argcount==1:
        pass
    elif argcount==2:
        process_type = ProcessType.ConvertStrTypeToType(args[1],ProcessType.ShowHelp)
    return process_type

def ShowHelpInfo():
    print("usage (argcount=2): python ./XXXX.py -h     show help")   
    print("usage (argcount=2): python ./XXXX.py -src   update src")
    print("usage (argcount=2): python ./XXXX.py -res   update res")    
    print("usage (argcount=2): python ./XXXX.py -all   update all")
    
def Process(process_type):
    src_full_path = "/Volumes/ResourceHD/guodong/Documents/MyCloud/SkyDrive/MyWebService/HtmlGame/Aypnia"
    des_full_path = "/Volumes/ResourceHD/guodong/Library/Application Support/iPhone Simulator/7.1-64/Applications/ABA065E9-C1F0-4BFD-AB41-C54C4A50D1AA/Aypnia iOS.app"
    
    src_sub_path = "src"
    res_sub_path = "res"
    
    need_removed_dirs = []
    need_copy_dirs = []
    if process_type == ProcessType.ShowHelp:
        ShowHelpInfo()
        return
    elif process_type == ProcessType.ProcessRes:
        need_removed_dirs.append(res_sub_path)
        need_copy_dirs.append(res_sub_path)
    elif process_type == ProcessType.ProcessSrc:
        need_removed_dirs.append(src_sub_path)
        need_copy_dirs.append(src_sub_path)
    else:
        need_removed_dirs.append(res_sub_path)
        need_removed_dirs.append(src_sub_path)
        need_copy_dirs.append(res_sub_path)
        need_copy_dirs.append(src_sub_path)
        
    # remove old data
    for t_dir in need_removed_dirs:
        t_dir = os.path.join(des_full_path,t_dir)
        if os.path.exists(t_dir):            
            shutil.rmtree(t_dir)

    # copy new data
    for index in range(len(need_copy_dirs)):
        src_dir = os.path.join(src_full_path,need_copy_dirs[index])
        des_dir = os.path.join(des_full_path,need_copy_dirs[index])
        if os.path.exists(src_dir):
            shutil.copytree(src_dir,des_dir)
    pass

def main():
    print(sys.argv)
    process_type = ParseArgs(sys.argv)
    Process(process_type)
    
if __name__ == '__main__':
    main()
else:
    print(__name__)
    main()

