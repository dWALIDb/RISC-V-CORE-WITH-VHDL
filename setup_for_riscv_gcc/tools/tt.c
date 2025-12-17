#include<stdio.h>
#include<stdint.h>
#include<math.h>
float factorial(uint32_t n){
    float fact=1;
    for (int i = 1; i < (n+1); i++)
    {
       fact=fact*i;
    }
    return fact;
}

float mult(float num,int pow){
    float prod=num;
    for (int i = 1; i < pow; i++)
    {
        prod*=num;
    }
    return prod;
}

#define PI 3.1415f
int main(){

    float input=0.01;
    float l0=1.0f;
    float l1=1.0f;
    float f;

    for (int i = 1; i < 6; i++)
    {
        f=factorial(2*i);
        printf("%.8f\n",f);
        l0=mult(input,2*i);
        printf("%.8f\n",l0);
        l0*=mult(-1.0f,i);
        printf("%.8f\n",l0);
        l1+= (l0/((float)f));
        printf("%.8f\n",l1);
        // l0*=(-1.0f)*input*input;
        // l0/=(float)(2*i*(2*i-1));
        // l1+=l0;
    }

    printf("real result: %f\n",cosf(input));
    printf("approximated result: %f\n",l1);

    return 0;
}