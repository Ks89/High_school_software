[ComVisibleAttribute(true)] 
public ref class MD5CryptoServiceProvider sealed : public MD5

public:
virtual property array<unsigned char>^ Hash {
    array<unsigned char>^ get ();
}