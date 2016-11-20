#include <iostream>

using namespace std;

void swap(int &a, int &b) {
    a ^= b;
    b ^= a;
    a ^= b;
}
int main() {
    int a=5, b=10;
    cout<<"A = "<< a<<" B = "<<b<<endl;
    swap(a, b);
    cout<<"A = "<< a<<" B = "<<b;
	system("PAUSE");
    return 0;
}