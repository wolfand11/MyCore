#coding=utf-8

import os
import os.path
import sys
import subprocess

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
    Update = 1
    Cleanup = 2
    UpdateAndCleanup = 3
    Invalid = 4
    
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg=="-h":
            return ProcessType.ShowHelp
        elif strArg=="-u":
            return ProcessType.Update
        elif strArg=="-c":
            return ProcessType.Cleanup
        elif ContainsAll(strArg,["-","u","c"]):
            return ProcessType.UpdateAndCleanup
        return default
        
class ProcessDesType:
    All  = 0
    Code = 1
    CodeRes  = 2
    DesignerArterRes = 3
    Invalid = 4
    
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg=="-all":
            return ProcessDesType.All
        elif strArg=="-code":
            return ProcessDesType.Code
        elif strArg=="-res":
            return ProcessDesType.CodeRes
        elif strArg=="-art":
            return ProcessDesType.DesignerArterRes
        return default
        
class ProjectManager:
    def __init__(self):
        my_documents_path = "/Users/guodong/Documents/MyProject/Private"
        self.__art_svn_path = my_documents_path+"/hero2/art_svn"
        self.__client_svn_path = my_documents_path+"/hero2/client_svn"
        self.__res_svn_path = my_documents_path+"/hero2/client_svn/trunk/HappyHero/res"
        self.__common_js_svn_path = my_documents_path+"/hero2/client_svn/trunk/HappyHero/src/common_js"
        self.__svr_shared_svn_path = my_documents_path+"/hero2/client_svn/trunk/share"

    def Process(self,process_type,process_des_type):
        process_des_path_list = []
        if process_des_type==ProcessDesType.All:
            process_des_path_list.append(self.__client_svn_path)
            process_des_path_list.append(self.__common_js_svn_path)
            process_des_path_list.append(self.__res_svn_path)
            process_des_path_list.append(self.__art_svn_path)
            process_des_path_list.append(self.__svr_shared_svn_path)
        elif process_des_type==ProcessDesType.Code:
            process_des_path_list.append(self.__client_svn_path)
            process_des_path_list.append(self.__common_js_svn_path)
            process_des_path_list.append(self.__svr_shared_svn_path)
        elif process_des_type==ProcessDesType.CodeRes:
            process_des_path_list.append(self.__res_svn_path)
        elif process_des_type==ProcessDesType.DesignerArterRes:
            process_des_path_list.append(self.__art_svn_path)
            
        for des_path in process_des_path_list:
            sys_command_list = ["svn"];
            if process_type==ProcessType.Update:
                sys_command_list.append("update")
                sys_command_list.append(des_path)
                subprocess.call(sys_command_list)
            elif process_type==ProcessType.Cleanup:
                sys_command_list.append("cleanup")
                sys_command_list.append(des_path)
                subprocess.call(sys_command_list)            
            elif process_type==ProcessType.UpdateAndCleanup:
                sys_command_list.append("cleanup")
                sys_command_list.append(des_path)
                subprocess.call(sys_command_list)            

                sys_command_list = ["svn"];
                sys_command_list.append("update")
                sys_command_list.append(des_path)
                subprocess.call(sys_command_list)
                
def ParseArgs(args):
    argcount = len(args)
    process_type = ProcessType.Update
    process_des_type = ProcessDesType.All

    if argcount == 1:
        pass
    elif argcount == 2:
        process_type = ProcessType.ConvertStrTypeToType(args[1],ProcessType.Update)
    elif argcount==3:
        process_type = ProcessType.ConvertStrTypeToType(args[1],ProcessType.Update)        
        process_des_type = ProcessDesType.ConvertStrTypeToType(args[2],ProcessDesType.All)
    
    return process_type,process_des_type

def ShowHelpInfo():
    print("usage (argcount=2): python ./XXXX.py -h  show help")
    print("usage (argcount=2): python ./XXXX.py -u  update all")
    print("usage (argcount=2): python ./XXXX.py -c  cleanup all")

    print("usage (argcount=3): python ./XXXX.py -[u|c] -all   update|cleanup all")
    print("usage (argcount=3): python ./XXXX.py -[u|c] -code  update|cleanup code")
    print("usage (argcount=3): python ./XXXX.py -[u|c] -res   update|cleanup res")
    print("usage (argcount=3): python ./XXXX.py -[u|c] -art   update|cleanup art")    
    
def main():
    print(sys.argv)
    process_type,process_des_type = ParseArgs(sys.argv)
    
    if process_type==ProcessType.ShowHelp:
       ShowHelpInfo()
       return;
       
    project_mgr = ProjectManager()
    project_mgr.Process(process_type,process_des_type)
    
if __name__ == '__main__':
    main()
else:
    print(__name__)
    main()
