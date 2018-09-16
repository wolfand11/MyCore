# -*- coding: utf-8 -*-
import os
import sys
from optparse import OptionParser
log_module_path = os.path.split(os.path.realpath(__file__))[0] + "./../../Tools/PyTools/log.py"
import imp
imp.load_source("log", log_module_path)
from log import *
import subprocess

def OptUnityProjs(options, path_arr):
    path_arr = path_arr.split("#")
    path_arr_len = len(path_arr)
    if path_arr_len<2 :
        log_error("OptUnityProjs len(path_arr)<2")
        return
    unity_path = path_arr[0]
    opt_cmd_str = "TMPTools.EditorCMD.ImportAssetsAll"
    if options.opt_unity_opt_type and options.opt_unity_opt_type==1:
        opt_cmd_str = "TMPTools.EditorCMD.BuildAllApp"
    unity_platform_types = "StandaloneWindows"
    if options.opt_unity_platform_types:
        unity_platform_types = options.opt_unity_platform_type

    for i in range(1,path_arr_len):
        sys_command_list = [unity_path]
        sys_command_list.append("-quit")
        sys_command_list.append("-batchmode")
        sys_command_list.append("-projectPath")
        sys_command_list.append(path_arr[i])
        sys_command_list.append("-executeMethod")
        sys_command_list.append(opt_cmd_str)
        sys_command_list.append("platforms-"+unity_platform_types)
        sys_command_list.append("-logFile")
        sys_command_list.append(path_arr[i]+"/build_log.txt")
        log_info(sys_command_list)
        subprocess.call(sys_command_list)
    pass

def RebootComputer(options, delay_time):
    cmd_str = "shutdown -r -f {0}".format(delay_time)
    os.system(cmd_str)

def ParseOption():
    parser = OptionParser(usage="%prog [options]")
    parser.add_option("--OptUnityProj", action="store", type="string", dest="opt_unity_proj_path_arr", help="operate multi unity projects!")
    parser.add_option("--OptUnityOptTpye", action="store", type="int", dest="opt_unity_opt_type", help="opt type. default-importAssets 1-buildApp")
    parser.add_option("--OptUnityPlatformTypes", action="store", type="string", dest="opt_unity_platform_types", help="unity platform types")
    parser.add_option("--Reboot", action="store", type="int", dest="reboot_delaytime", help="reboot computer delay seconds time")
    options,args = parser.parse_args()

    if options.opt_unity_proj_path_arr:
        OptUnityProjs(options, options.opt_unity_proj_path_arr)
    elif options.reboot_delaytime:
        RebootComputer(options, options.reboot_delaytime)
    return options,args

if __name__ == '__main__':
    log_info("START LOOP-LIFE Python Stage")
    options,args = ParseOption()
    print(options)
    print(args)
    log_info("END   LOOP-LIFE Python Stage")
    log_error("TEST ERROR")
    log_warning("TEST WARNING")

