#coding=utf-8

import os.path
import shutil
import sys
import Image

EAtlasInfoType_InvalidType, \
    EAtlasInfoType_FlappyBirdType, \
    EAtlasInfoType_TPType = range(3)

def GetFileSuffix(file):    
    suffix = os.path.splitext(file)[1]
    return suffix
def GetFileNameWithoutSuffix(file):
    name = os.path.splitext(file)[0]
    return name

class ClipInfo:
    """"""
    def __init__(self):
        self.name = ""
        self.start_x = 0.0
        self.start_y = 0.0
        self.width = 0.0
        self.height = 0.0

class ImageAtlasSlicer:
    @staticmethod
    def __GenerateClipInfoArray_FlappyBirdType(atlas_file,info_stream,clip_info_array):        
        lines = info_stream.readlines()
        property_list = None
        del clip_info_array[:]
        image = Image.open(atlas_file)
        print(image.format,image.size,image.mode)
        for line in lines:
            temp_clip_info = ClipInfo()
            property_list = line.split(" ")            
            temp_clip_info.name   = property_list[0]+"."+image.format
            temp_clip_info.start_x= int(round(float(property_list[3])*image.size[0],0))
            temp_clip_info.start_y= int(round(float(property_list[4])*image.size[1],0))
            temp_clip_info.end_x  = temp_clip_info.start_x+int(round(float(property_list[1]),0))
            temp_clip_info.end_y  = temp_clip_info.start_y+int(round(float(property_list[2]),0))            
            clip_info_array.append(temp_clip_info)
            print("%s sx:%d sy:%d ex:%d ey:%d" %(temp_clip_info.name, \
                                                 temp_clip_info.start_x, \
                                                 temp_clip_info.start_y, \
                                                 temp_clip_info.end_x, \
                                                 temp_clip_info.end_y))
        pass

    @staticmethod
    def __GenerateClips(atlas_image_file,clip_info_array):
        image = Image.open(atlas_image_file)
        # remove old data
        atlas_path = os.path.dirname(atlas_image_file)
        atlas_file_name = GetFileNameWithoutSuffix(atlas_image_file)
        clips_path = os.path.join(atlas_path,atlas_file_name+"_clips")
        if os.path.exists(clips_path):
            shutil.rmtree(clips_path)
                    
        # generate new data
        os.makedirs(clips_path)        
        for clip_info in clip_info_array:            
            clip_file_path = os.path.join(clips_path,clip_info.name)
            crop_box = (clip_info.start_x,clip_info.start_y,clip_info.end_x,clip_info.end_y)
            clip = image.crop(crop_box)
            clip.save(clip_file_path,image.format)
        pass

    @staticmethod
    def SliceAtlas(atlas_image_file,atlas_info_file,atlas_info_type):
        # get atlas info type
        if atlas_info_type==0:        
            info_file_suffix = GetFileSuffix(atlas_info_file)
            if info_file_suffix==".txt":
                atlas_info_type = EAtlasInfoType_FlappyBirdType;
            elif info_file_suffix == ".plist":
                atlas_info_type = EAtlasInfoType_TPType;
            
        print(atlas_image_file+"\n"+atlas_info_file+"\n"+str(atlas_info_type))

        # generate clip info array
        clip_info_array=[]
        info_f_stream = open(atlas_info_file,"r")
        if atlas_info_type==EAtlasInfoType_FlappyBirdType:
            ImageAtlasSlicer.__GenerateClipInfoArray_FlappyBirdType(atlas_image_file,info_f_stream,clip_info_array)

        info_f_stream.close()
            
        # generate clips
        ImageAtlasSlicer.__GenerateClips(atlas_image_file,clip_info_array)    
