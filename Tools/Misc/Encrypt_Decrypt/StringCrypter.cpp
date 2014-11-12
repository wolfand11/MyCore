#include <string>
#include <iostream>
#include "StringCrypter.h"
using namespace std;

#ifdef CRYPTER_DEBUG
#define CRYPTER_LOG(format, ...) printf(format, ##__VA_ARGS__)
#else
#define CRYPTER_LOG(format, ...)
#endif

void operator ^(string&, const string&);

bool StringCrypter::Encrypt(string& str,const std::string& key)
{
    str ^ key;
    return true;
}

bool StringCrypter::Decrypt(string& str,const std::string& key)
{
    str ^ key;
    return true;
}

void operator ^(string& toBeEncrypted, const string& encryptionKey)
{
    CRYPTER_LOG("Key:     ----------------------------------\n%s\n",encryptionKey.c_str());
    CRYPTER_LOG("OldData: ----------------------------------\n%s\n",toBeEncrypted.c_str());
    
	int i = 0, j = 0;
	while(toBeEncrypted[i] != '\0')
	{
        if ( (toBeEncrypted[i] ^ encryptionKey[j]) != '\0')
        {
            toBeEncrypted[i] = toBeEncrypted[i] ^ encryptionKey[j];
        }
		i++;
		j++;
		if(encryptionKey[j] == '\0')
		{
			j = 0;
		}
	}
    
    CRYPTER_LOG("NewData: ----------------------------------\n%s\n",toBeEncrypted.c_str());
}
