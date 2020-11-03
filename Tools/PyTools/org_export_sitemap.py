import sys
import os
import platform
from enum import Enum
from log import *
import json
import shutil
import time

__all__ = ["GOrgExportSitemap"]

class GOrgExportSitemap:
    s_priority_config = None

    def __init__(self):
        pass

    @classmethod
    def ExportSitemap(cls, path_arr, init_priority_config):
        post_path = None
        if not path_arr:
            sys_str = platform.system()
            if sys_str=="Windows":
                post_path = "D:/Documents/MyProject/Public/wolfand11/_post"
                pass
            else:
                post_path = "~/Documents/MyProject/Public/wolfand11/_post"
                pass
            pass
        elif len(path_arr) > 1:
            post_path = path_arr[0]
            pass

        file_arr = cls.CollectFiles(post_path)
        sitemap_file_path = os.path.join(post_path, "sitemap.org")
        sitemap_str = cls.GenSitemap(file_arr, post_path, init_priority_config)
        log_info(sitemap_str)
        fs = open(sitemap_file_path, "w")
        fs.write(sitemap_str)
        fs.close()
        return sitemap_str

    @classmethod
    def CollectFiles(cls, post_path):
        file_arr = []
        for parent_dir, dirs, files in os.walk(post_path):
            for file in files:
                # ignore hide dirs
                if parent_dir.find(".")!=-1:
                    continue
                # ignore hide files
                if file.find(".") == 0:
                    continue
                # ignore other files except .org
                if file.find(".org") == -1:
                    continue
                # ignore special org files
                if file.find("index.org")==0 or file.find("about.org")==0 or file.find("sitemap")==0:
                    continue
                a_path = os.path.join(parent_dir, file)
                a_path = a_path.replace("\\", "/")
                file_arr.append(a_path)
        return file_arr

    @classmethod
    # 默认优先级为10000，优先级越低排序越靠前
    def GetBlogEntryPriority(cls, entry, priority_config):
        if not priority_config:
            return 10000
        if entry in priority_config:
            return priority_config.index(entry)
        else:
            return 10000

    @classmethod
    # priority_config 结构如下：
    # dir_priority = ["dir1", "dir2"]
    # file_priorty = {
    #     "dir1" : ["file1", "file2"],
    #     "dir2" : ["file1", "file2"]
    # }
    def LoadPriorityConfig(cls, post_path):
        priority_config_path = os.path.join(post_path, "priority_config.json")
        if not os.path.exists(priority_config_path):
            return
        fs = open(priority_config_path, "r")
        json_str = fs.read()
        cls.s_priority_config = json.loads(json_str)
        return

    @classmethod
    def InitPriorityConfig(cls, post_path, priority_config):
        priority_config_path = os.path.join(post_path, "priority_config.json")
        config_str = json.dumps(priority_config, sort_keys=False, indent=4, separators=(',', ': '))
        log_info(config_str)
        if os.path.exists(priority_config_path):
            time_str = time.strftime("%m%d_%H%M%S")
            bak_config_path = os.path.join(post_path, ".priority_config_{}.json".format(time_str))
            shutil.copy(priority_config_path, bak_config_path)
        fs = open(priority_config_path, "w")
        fs.write(config_str)
        fs.close()

    @classmethod
    def GetDirPriorityConfig(cls):
        if not cls.s_priority_config:
            return None
        else:
            return cls.s_priority_config["dir_priority"]

    @classmethod
    def GetFilePriority(cls, dir_name):
        if not cls.s_priority_config:
            return None
        if not isinstance(cls.s_priority_config, dict):
            return None
        if "file_priority" not in cls.s_priority_config:
            return None
        if dir_name not in cls.s_priority_config["file_priority"]:
            return None
        return cls.s_priority_config["file_priority"][dir_name]

    @classmethod
    def GenSitemap(cls, file_arr, post_path, init_priority_config):
        #log_info(file_arr)
        cls.LoadPriorityConfig(post_path)
        priority_config = {'dir_priority': [], 'file_priority': {}}
        file_tree_dict = {}
        for file in file_arr:
            dir_name = os.path.dirname(file)
            dir_name = dir_name[dir_name.rfind("/")+1:]
            if dir_name not in file_tree_dict:
                file_tree_dict[dir_name] = []
            file_path = file.replace(post_path, "")
            file_tree_dict[dir_name].append(file_path)
            if not init_priority_config:
                continue
            if dir_name not in priority_config['dir_priority']:
                priority_config['dir_priority'].append(dir_name)
            if dir_name not in priority_config['file_priority']:
                priority_config['file_priority'][dir_name] = []
            priority_config['file_priority'][dir_name].append(file_path)
        if init_priority_config:
            priority_config['dir_priority'].append("+++++")
            for k,v in priority_config['file_priority'].items():
                priority_config['file_priority'][k].append("+++++")
            cls.InitPriorityConfig(post_path, priority_config)

        sitemap_str = "#+TITLE: Sitemap\n"
        dir_name_list = list(file_tree_dict.keys())
        dir_priority_config = cls.GetDirPriorityConfig()
        dir_name_list.sort(key=lambda elem: cls.GetBlogEntryPriority(elem, dir_priority_config))
        for t_dir_name in dir_name_list:
            dir_entry = "+ {}\n".format(t_dir_name)
            sitemap_str = sitemap_str + dir_entry
            file_path_list = file_tree_dict[t_dir_name]
            file_priority_config = cls.GetFilePriority(t_dir_name)
            file_path_list.sort(key=lambda elem:cls.GetBlogEntryPriority(elem, file_priority_config))
            for t_file_path in file_path_list:
                file_name = os.path.basename(t_file_path).replace(".org", "")
                file_entry = "    + [[file:.{}][{}]]\n".format(t_file_path, file_name)
                sitemap_str = sitemap_str + file_entry
        return sitemap_str
