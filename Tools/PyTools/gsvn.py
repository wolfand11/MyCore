# -*- coding: utf-8 -*-
import os
import subprocess

# svn checkout http://路径(目录或文件的全路径) [本地目录全路径] --username　用户名 --password 密码 --revision revision_number
def update(local_url=None, revision=None, user=None, pwd=None, remote_url=None, svn_bin_path=None):
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
