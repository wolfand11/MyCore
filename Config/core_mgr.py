# -*- coding: utf-8 -*-
import sys
import os
import os.path
import shutil
import subprocess

g_config_abs_path = os.path.split(os.path.realpath(__file__))[0]

def InitEmacs(is_spacemacs):
    emacs_config_abs_path = os.path.join(g_config_abs_path,"EmacsConfig")
    dot_emacs_abs_path = os.path.expanduser("~")
    src_dot_emacs = os.path.join(emacs_config_abs_path,"dot_emacs.el")
    des_dot_emacs = os.path.join(dot_emacs_abs_path,".emacs")
    src_dot_emacs_local = os.path.join(emacs_config_abs_path,"dot_emacs_local.el")
    des_dot_emacs_local = os.path.join(dot_emacs_abs_path,".emacs.local")
    shutil.copy(src_dot_emacs,des_dot_emacs)
    shutil.copy(src_dot_emacs_local,des_dot_emacs_local)
    if is_spacemacs:
        src_dot_spacemacs = os.path.join(emacs_config_abs_path,"dot_spacemacs.el")
        des_dot_spacemacs = os.path.join(dot_emacs_abs_path,".spacemacs")
        shutil.copy(src_dot_spacemacs,des_dot_spacemacs)

        spacemacs_elpa = os.path.join(os.path.expanduser("~"),".emacs.d/elpa")
        os.chdir(spacemacs_elpa)
        if os.path.exists(os.path.join(spacemacs_elpa,".git")):
            result = subprocess.check_output("git pull origin master:master",shell=True)
            result_list = result.decode("utf-8").split(' ')
            print(result_list)
        else:
            result = subprocess.check_output("git clone https://github.com/wolfand11/_spacemacs_elpa.git ./")
        os.chdir(g_config_abs_path)

def InitOhMyZsh():
    ohmyzsh_config_abs_path = os.path.join()
    dot_zsh_abs_path = os.path.expanduser("~")
    src_dot_zsh = os.path.join(ohmyzsh_config_abs_path,"dot_zshrc")
    des_dot_zsh = os.path.join(dot_zsh_abs_path,".zshrc")
    src_dot_zsh_local = os.path.join(ohmyzsh_config_abs_path,"dot_zshrc.local")
    des_dot_zsh_local = os.path.join(dot_zsh_abs_path,".zshrc.local")
    shutil.copy(src_dot_zsh,des_dot_zsh)
    shutil.copy(src_dot_zsh_local,des_dot_zsh_local)

def ShowHelper():
    cmd_prefix = " python ./core_mgr.py "
    print("usage :")
    print(cmd_prefix+"-i                     #init core")
    print(cmd_prefix+"-i no-spacemacs-elpa   #init core except spacemacs-elpa")
    print(cmd_prefix+"-i only-spacemacs-elpa #init core only spacemacs-elpa")
    print(cmd_prefix+"-u                     #update core")
    print(cmd_prefix+"-u no-spacemacs-elpa   #update core except spacemacs-elpa")
    print(cmd_prefix+"-u only-spacemacs-elpa #update core only spacemacs-elpa")
    print(cmd_prefix+"-c                     #commit core")
    print(cmd_prefix+"-c no-spacemacs-elpa   #commit core except spacemacs-elpa")
    print(cmd_prefix+"-c only-spacemacs-elpa #commit core only spacemacs-elpa")
    pass

## Logic Start
if len(sys.argv)<2:
    ShowHelper()
else:
    opt_type = sys.argv[1]
    if opt_type=="-i":
        print("++++ START INIT MY CORE")
        InitEmacs(True)
        InitOhMyZsh()
        print("---- END INIT MY CORE")
    else:
        print("UNSUPPORT!")
