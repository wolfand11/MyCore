# -*- coding: utf-8 -*-
import sys
import os
from enum import Enum
from log import *

__all__ = ["GFileDirOperator"]

GCMDType = Enum('GCMDType', ('File', 'Dir', 'Opt'))


class GCommand:
    self.cmd_type
    self.subcmd_list

    def __init__(self):
        pass


class GFileDirOperator:
    def __init__(self):
        pass

    @classmethod
    def parse_argv(cls, argv):
        if len(argv) < 2:
            help()
        else:
            is_recursive_dir = False
            if argv[1] == "./":
                input_dir_path = os.path.split(os.path.realpath(__file__))[0]
            else:
                input_dir_path = os.path.realpath(argv[1])

            command_str_list = []
            if argv[2] == "-R":
                is_recursive_dir = True
                command_str_list.extend(argv[3:])
            else:
                command_str_list.extend(argv[2:])
                pass

            if os.path.exists(input_dir_path):
                file_list = []
                dir_list = []

                # 1 fill dir file list
                cls.fill_file_dir_list(
                    input_dir_path,
                    is_recursive_dir,
                    file_list,
                    dir_list)

                # 2 fill command list
                command_list = cls.parse_command(
                    command_str_list, file_list, dir_list)

                # 3 Do Command
                cls.do_command_list(command_list, file_list, dir_list)

                log(command_str_list)
                log(file_list)
                log(dir_list)
            else:
                log_error("input_dir_path not exist!")

    @staticmethod
    def fill_file_dir_list(
            input_dir_path,
            is_recursive_dir,
            file_list,
            dir_list):
        if os.path.exists(input_dir_path):
            if is_recursive_dir:
                for parent_dir, dirs, files in os.walk(input_dir_path):
                    for file in files:
                        file_list.append(os.path.join(parent_dir, file))
                    for dir in dirs:
                        dir_list.append(os.path.join(parent_dir, dir))
            else:
                file_dir_list = os.listdir(input_dir_path)
                for file_or_dir in file_dir_list:
                    file_or_dir_abs_path = os.path.join(dir, file_or_dir)
                    if os.path.isfile(file_or_dir_abs_path):
                        file_list.append(file_or_dir_abs_path)
                    else:
                        dir_list.append(file_or_dir_abs_path)
        pass

    @staticmethod
    def parse_command(command_str_list, file_list, dir_list):
        command_list = []
        for cmd_str in command_str_list:
            cmd_type_str = cmd_str[:1]
            if cmd_type_str == '-f':
                pass
            elif cmd_type_str == '-d':
                pass
            elif cmd_type_str == '-opt':
                pass
        return command_list

    @staticmethod
    def do_command_list(command_list, file_list, dir_list):
        pass

    @staticmethod
    def help():
        print("usage :")
        print(" python ./FileDirOperator.py [dir-path] [-R] [command-list]")
        print(" command : ")
        print(" -f==size[<|>|=10K|M|G]==name[*|]    #collect files (name support regex)")
        print(" -d==size[<|>|=10K|M|G]==name[*|]    #collect directory")
        print(" -opt==p==d==r[]                     #operate files or dirs")
        pass
