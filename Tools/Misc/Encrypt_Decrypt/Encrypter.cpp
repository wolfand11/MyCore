//
//  AES256Worker.c
//  
//
//  Created by guodong on 13-4-17.
//
//

#include <stdio.h>
#include <string>
#include <vector>
#include <unistd.h>
#include "StringCrypter.h"
using namespace std;

#define kHelpFullArg            "--help"
#define kHelpArg                "-h"
#define kWorkType_Decode        "--decode"
#define kWorkType_Code          "--code"
string  g_workTypeString;
string  g_codeDecodeKey;
string  g_codeDecodeFilePath;

bool AssignCodeDecodeKey(const string& keyStr);
void ReadFile(vector<char>& fileContent, const string &filePath);
void WriteFile(const vector<char>& fileContent, const string& filePath);
void CodeString(vector<char> &str);
void DecodeString(vector<char> &str);
void PrintUsage();
bool IsFileExist(const string& filePath);

int main (int argc, char *argv[])
{
    if(argc == 2)
    {
        if(strcmp(kHelpFullArg,argv[1]) ||
           strcmp(kHelpArg,argv[1]))
        {
            PrintUsage();
            return 0;
        }
    }
    else if(argc==4)
    {
        g_workTypeString = argv[1];

if(!AssignCodeDecodeKey(argv[2]))
{
    return 0;
}

        g_codeDecodeFilePath = argv[3];
        if(!IsFileExist(g_codeDecodeFilePath))
        {
            printf("file(%s) don't exist!",g_codeDecodeFilePath.c_str());
            return 0;
        }

        if(kWorkType_Code==g_workTypeString)
        {
            vector<char> fileContent;
            ReadFile(fileContent,g_codeDecodeFilePath);
            CodeString(fileContent);
            WriteFile(fileContent,g_codeDecodeFilePath);
        }
        else if(kWorkType_Decode==g_workTypeString)
        {
            vector<char> fileContent;
            ReadFile(fileContent,g_codeDecodeFilePath);
            DecodeString(fileContent);
            WriteFile(fileContent,g_codeDecodeFilePath);
        }
        else
        {
            printf("work type(%s) error\n",g_workTypeString.c_str());
            PrintUsage();
            return 0;
        }
    }
    else
    {
        printf("argument count(%d) error\n",argc);
        PrintUsage();
        return 0;
    }
}

void PrintUsage()
{
    printf("Usage:---------------------------------------------\n");
    printf("DecodeFile:\n");
    printf("./Encrypter --decode keystring /User/guodong/..../file.lua\n");
    printf("CodeFile:\n");
    printf("./Encrypter --code keystring /User/guodong/..../file.lua\n");
}

bool IsFileExist(const string &filePath)
{
    if (access(filePath.c_str(), 0) == 0)
    {
        return true;
    }
    else
    {
        return false;
    }
}

bool AssignCodeDecodeKey(const string& keyStr)
{
    if(keyStr.length() > 32 || keyStr.length() < 1)
    {
        printf("keyStr length must be in area [1 32]!");
        return false;
    }
    g_codeDecodeKey = keyStr;
    return true;
}

void ReadFile(vector<char>& fileContent, const string &filePath)
{
    FILE *filePointer = fopen(filePath.c_str(),"r");
    if(filePointer==NULL)
    {
        printf("open file(%s) failed!",filePath.c_str());
        return;
    }

    fseek( filePointer , 0 , SEEK_END );
    int fileSize;
    char* temp = new char[fileSize];
    fileSize = ftell( filePointer );
    fseek( filePointer , 0 , SEEK_SET);
    fread(temp, fileSize, sizeof(char), filePointer);
    fileContent.clear();
    fileContent.assign(temp,temp+fileSize);
    fclose(filePointer);
    delete[] temp;
}

void WriteFile(const vector<char>& fileContent, const string &filePath)
{
    if(fileContent.empty())
    {
        printf("you can't write empty data to file(%s)",filePath.c_str());
        return;
    }
    FILE *filePointer = fopen(filePath.c_str(),"w");
    if(filePointer==NULL)
    {
        printf("open file(%s) failed!",filePath.c_str());
        return;
    }
    for(int i=0; i<fileContent.size(); i++)
        fprintf(filePointer,"%c", fileContent.at(i));
    fclose(filePointer);
}

void CodeString(vector<char> &str)
{
    string temp(str.begin(),str.end());
    StringCrypter::Encrypt(temp,g_codeDecodeKey);
    str.clear();
    str.assign(temp.begin(),temp.end());
}

void DecodeString(vector<char>& str)
{
    string temp(str.begin(),str.end());
    StringCrypter::Decrypt(temp,g_codeDecodeKey);
    str.clear();
    str.assign(temp.begin(),temp.end());
}
