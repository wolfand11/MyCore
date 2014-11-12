#coding=utf-8

import os.path
import sys
from ImageAtlasSlicer import ImageAtlasSlicer

EHelpTip, \
    EFileDontExist = range(2)

def PrintTips(type,*info):
    if type==EHelpTip:
        print("Usage: python ./SliceAtlas.py atlas_image_file atlas_info_file")
    elif type==EFileDontExist:
        temp = "\n".join(info)
        print("Error: file dont eixst!\n"+temp+"\n")
    
def main():
    argc = len(sys.argv)
    atlas_image_file = ""
    atlas_info_file  = ""
    atlas_info_type = 0;

    # check arguments
    # argv1=atlas_image_file argv2=atlas_info_file
    if argc!=3 and argc!=4:
        print("ERROR: argc("+str(argc)+") isn't 3 and 4")
        PrintTips(EHelpTip)
        return

            
    atlas_image_file = os.path.abspath(sys.argv[1])
    atlas_info_file  = os.path.abspath(sys.argv[2])
    # check files exists
    if os.path.exists(atlas_image_file) and os.path.exists(atlas_info_file):
        pass
    else:
        PrintTips(EFileDontExist,atlas_image_file,atlas_info_file)
        return;    
    if argc==4:
        atlas_info_type = int(sys.argv[3])

    # slice atlas
    ImageAtlasSlicer.SliceAtlas(atlas_image_file,atlas_info_file,atlas_info_type)
    
main()

