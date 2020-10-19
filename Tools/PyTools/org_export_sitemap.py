import sys
import os
import platform
from enum import Enum
from log import *

__all__ = ["GOrgExportSitemap"]

class GOrgExportSitemap:
    def __init__(self):
        pass

    @classmethod
    def ExportSitemap(cls, path_arr):
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
        sitemap_str = cls.GenSitemap(file_arr, post_path)
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
    def GenSitemap(cls, file_arr, post_path):
        #log_info(file_arr)
        blog_dict = {}
        for file in file_arr:
            file_name = os.path.basename(file).replace(".org", "")
            dir_name = os.path.dirname(file)
            dir_name = dir_name[dir_name.rfind("/")+1:]
            dir_entry = "+ {}\n".format(dir_name)
            file_entry = "    + [[file:.{}][{}]]\n".format(file.replace(post_path, ""), file_name)
            if not dir_entry in blog_dict:
                blog_dict[dir_entry] = []
            blog_dict[dir_entry].append(file_entry)
        sitemap_str = "#+TITLE: Sitemap\n"
        for k,v in blog_dict.items():
            sitemap_str = sitemap_str + k
            for t_file_entry in v:
                sitemap_str = sitemap_str + t_file_entry
        return sitemap_str
