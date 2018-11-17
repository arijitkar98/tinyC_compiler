#include <stdio.h>

/*
Arijit Kar 16CS30005
C Program to test tinyC lexer

Keywords:
auto enum restrict unsigned break extern return void case float short volatile char for signed while const goto sizeof Bool
continue if static Complex default inline struct Imaginary do int switch double long typedef else register union

*/

// also tests punctuators

#define tester "this is for \t testing purposes\n"

void inline test(char ch[], int *restrict )
{
    printf("Inline test\n");
}

typedef struct node {
    struct node* next;
    volatile signed short d = 5;

}node;

extern "C" {
    void foo();
}

void foo(){

}

int main() 
{
    static auto a = -5;
    register float b = 4.0;
    double bb = -23.9;
    unsigned long c = 23;

    _Bool boolean;
    _Complex complex;
    _Imaginary imag;

    node* root = NULL;
    root->next = NULL;
    root->d = 5 + 1 - 1 / 1 * 1;


    int j = 1;
    char ch[] = "sad";
    for(int i = 0; i<10; i++)
    {
        j+=1;
        j*=2;
        j-=2;
        j/=2;
        j--;

        if(1 && 0 || !1)
            j = ~j;
    }

    do{
        if(a>=b)
        {
            j%=2;
            j>>=2;
            j<<=2;
            j&=0;
            j^=2;
            j|=23;
        }
        else if(a<=b)
        {
            if(a>b);
            if(a<b);
            if(a==b);
            break;
        }

    }while(1);
    enum enums{h,k,l};
    j = sizeof('c');


    for(int i=0;i<5;i++) {
        switch(i) {
            case(1) : continue;
            case(2) : break;
            default : return 0;
        }
    }

    return 0;
}