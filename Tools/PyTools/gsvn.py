# -*- coding: utf-8 -*-
import os
import subprocess
import pysvn
import sys
import shutil
sys.path.append(os.path.realpath(os.path.dirname(__file__)) + "/../../Tools/PyTools/log.py")
from log import *

# svn checkout http://路径(目录或文件的全路径) [本地目录全路径] --username　用户名 --password 密码 --revision revision_number
def update(local_url=None, revision=None, user=None, pwd=None, remote_url=None, svn_bin_path=None):
    svn_client = pysvn.Client()
    svn_client.checkout("", "")
    is_need_checkout = False

    if svn_bin_path is None:
        svn_bin_path = "svn"
    else:
        if not os.path.exists(svn_bin_path):
            return False, "svn bin path not exist!"

    if local_url is None:
        local_url = os.getcwd()
    if not os.path.exists(local_url):
        os.makedirs(local_url)
    if not os.path.exists(local_url + "/.svn"):
        is_need_checkout = True

    sys_command_list = []
    sys_command_list.append(svn_bin_path)
    if is_need_checkout:
        sys_command_list.append("checkout")
        if remote_url is None:
            return False, "remote url is None!"
        else:
            sys_command_list.append(remote_url)
    else:
        sys_command_list.append("update")
    sys_command_list.append(local_url)

    if not user is None:
        sys_command_list.append("--username")
        sys_command_list.append(user)
    if not pwd is None:
        sys_command_list.append("--password")
        sys_command_list.append(pwd)
    if not revision is None:
        sys_command_list.append("--revision")
        sys_command_list.append(revision)

    output = subprocess.check_output(sys_command_list)
    return True, output.decode("utf-8")

def checkout_revert_update():
    pass

class SvnClient:
    def __init__(self, remote_path="", local_path="", user="", pwd=""):
        self.__remote_path = remote_path
        self.__local_path = local_path
        self.__user = user
        self.__pwd = pwd
        self.__svn_client = pysvn.Client(local_path)
        self.__svn_client.callback_get_login = self.__get_login
        self.__svn_client.exception_style = 1
        pass

    def __get_login(self):
        log_info("request account")
        return True, self.__user, self.__pwd, True

    # opt_args --opt_type1 opt-arg1#opt-arg2 --opt_type2 opt-arg1#opt-arg2
    # opt_type1 - checkout_revert_update
    def do_opts(self, opt_args):
        pass

    def __is_valid_svn_proj(self):
        result = False
        status = None
        try:
            status = self.__svn_client.status(".")
            result = True
        except pysvn.ClientError, e:
            log_error(e.args[0])
        return result, status

    def checkout_revert_update(self, path=None):
        result = False
        try:
            is_valid_svn, svn_status = self.__is_valid_svn_proj()
            if is_valid_svn:
                if not path:
                    path = "."
                self.__svn_client.revert(path, recurse=True)
                self.__svn_client.update(path, recurse=True)
            else:
                self.__svn_client.checkout(self.__remote_path, self.__local_path)
        except Exception, e:
            log_error(e)
        return result

if __name__ == '__main__':
    svn_client = SvnClient(local_path="./test_svn/", remote_path="svn://192.168.105.21:8443/svn/wooolMobileGames/程序/Test/AnimTest/ProjectSettings/")
    svn_client.checkout_revert_update()















