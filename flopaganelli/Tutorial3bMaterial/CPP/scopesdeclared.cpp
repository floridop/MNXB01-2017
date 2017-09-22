#include <iostream>
using namespace std;
int globalScope = 0; //This is a global variable, visible everywhere.

void foo() {
    int fooScope = 1; //Only visible within foo function
    int localScope = 2;
    cout << "fooScope: " << fooScope << endl;
    cout << "localScope declared in foo(): " << localScope << endl; 
}
int main() {
    cout << "globalScope: " << globalScope << endl;

    { //Any block declares a scope, even this useless one
        int localScope = 3; 
        cout << "localScope declared in useless block: " << localScope << endl;
        foo();
        int fooScope = 4;
        cout << "fooScope declared in useless block after calling foo(): " << fooScope << endl; 
        int globalScope = 100; // variable hiding, very bad practice!
        cout << "globalScope declared in useless block that hides the global environment: " << globalScope << endl;
    }
    int localScope = 5;
    cout << "localScope declared in main(): " << localScope << endl;
    cout << "globalScope: " << globalScope << endl;
}
