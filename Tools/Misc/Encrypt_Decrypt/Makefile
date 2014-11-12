#此行为注释
Encrypter: Encrypter.o StringCrypter.o
	g++ -o Encrypter Encrypter.o StringCrypter.o

Encrypter.o: Encrypter.cpp StringCrypter.h
	g++ -c Encrypter.cpp

StringCrypter.o: StringCrypter.cpp StringCrypter.h
	g++ -c StringCrypter.cpp

clean:
	rm *.o
	rm Encrypter