#coding=utf-8
#author:guodong

import os
import os.path
import sys
import subprocess
import ConfigParser
import platform
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
    InitGoAgent = 1
    RunGoAgent  = 2
    InitAndRun  = 3
    Invalid = 4
    @staticmethod
    def ConvertStrTypeToType(strArg,default):
        if strArg=="-h":
            return ProcessType.ShowHelp
        elif strArg=="-i" or strArg=="-init":
            return ProcessType.InitGoAgent
        elif strArg=="-r" or strArg=="-run":
            return ProcessType.RunGoAgent
        elif ContainsAll(strArg,["-","i","r"]):
            return ProcessType.InitAndRun
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
    print("usage (argcount=2): python ./XXXX.py -h         show help")
    print("usage (argcount=2): python ./XXXX.py -i[-init]  init goagent")   
    print("usage (argcount=2): python ./XXXX.py -r[-run]   run goagent")
    print("usage (argcount=2): python ./XXXX.py -ir        init and run goagent")   

def InitGoAgent():
    script_path = os.path.split(os.path.realpath(sys.argv[0]))[0]
    goagent_path = os.path.join(script_path,"goagent")
    goagent_config_path = os.path.join(goagent_path,"local/proxy.ini")
    my_goagent_config_path = os.path.join(script_path,"MyGoAgentConfig.ini")

    old_cwd = os.getcwd()    
    if os.path.exists(goagent_path):
        shutil.rmtree(goagent_path)
        os.makedirs(goagent_path)
        
    os.chdir(goagent_path)
    sys_command_list = ["git"]
    sys_command_list.append("clone")
    sys_command_list.append("git@github.com:goagent/goagent.git")
    subprocess.call(sys_command_list)
    os.chdir(old_cwd)

    backup_config = ConfigParser.ConfigParser()    
    backup_config.readfp(open('./MyGoAgentConfig.ini'))
    listen_usename  = backup_config.get("my_listen","username")
    listen_password = backup_config.get("my_listen","password")
    gae_appid       = backup_config.get("my_gae","appid")
    gae_password    = backup_config.get("my_gae","password")

    config = ConfigParser.ConfigParser()
    config.readfp(open(goagent_config_path))
    config.set("listen", "usename", listen_usename)
    config.set("listen", "password", listen_password)
    config.set("gae", "appid", gae_appid)
    config.set("gae", "password", gae_password)
    config.write(open(goagent_config_path, "w"))    
    pass

def RunGoAgent():
    script_path = os.path.split(os.path.realpath(sys.argv[0]))[0]
    goagent_path = os.path.join(script_path,"goagent")
    if os.path.exists(goagent_path):
        goagent_local_path = os.path.join(goagent_path,"local")
        goagent_app_path = ""
        platform_str = platform.system()

        sys_command_list=[]
        if platform_str=="Windows":
            goagent_app_path = os.path.join(goagent_local_path,"goagent.exe")            
        else:
            sys_command_list.append("sudo")
            sys_command_list.append("bash")
            if platform_str=="Darwin":
                goagent_app_path = os.path.join(goagent_local_path,"goagent-osx.command")
            elif platform_str=="Linux":
                goagent_app_path = os.path.join(goagent_local_path,"goagent-gtk.py")
            else:
                print("Error:unsupport platform")
                return                            
        sys_command_list.append(goagent_app_path)
        subprocess.call(sys_command_list)
    else:
        print("Error: goagent don't eixst!")

def Process(process_type):
    if process_type==ProcessType.ShowHelp:
        ShowHelpInfo()
    elif process_type==ProcessType.InitGoAgent:
        InitGoAgent()
    elif process_type==ProcessType.RunGoAgent:
        RunGoAgent()
    elif process_type==ProcessType.InitAndRun:
        InitGoAgent()
        RunGoAgent()
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

