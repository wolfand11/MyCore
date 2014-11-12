#ifndef StringCrypter_H
#define StringCrypter_H
#include <string>

class StringCrypter
{
public:
    static bool Encrypt(std::string& str,const std::string& key);
    static bool Decrypt(std::string& str,const std::string& key);
};
#endif