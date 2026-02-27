// i found this code http://www.netlib.org/benchmark/whetstone.c
// i changed the type double since i have dloat support only 


/*
 * C Converted Whetstone float Precision Benchmark
 *		Version 1.2	22 March 1998
 *
 *	(c) Copyright 1998 Painter Engineering, Inc.
 *		All Rights Reserved.
 *
 *		Permission is granted to use, duplicate, and
 *		publish this text and program as long as it
 *		includes this entire comment block and limited
 *		rights reference.
 *
 * Converted by Rich Painter, Painter Engineering, Inc. based on the
 * www.netlib.org benchmark/whetstoned version obtained 16 March 1998.
 *
 * A novel approach was used here to keep the look and feel of the
 * FORTRAN version.  Altering the FORTRAN-based array indices,
 * starting at element 1, to start at element 0 for C, would require
 * numerous changes, including decrementing the variable indices by 1.
 * Instead, the array E1[] was declared 1 element larger in C.  This
 * allows the FORTRAN index range to function without any literal or
 * variable indices changes.  The array element E1[0] is simply never
 * used and does not alter the benchmark results.
 *
 * The major FORTRAN comment blocks were retained to minimize
 * differences between versions.  Modules N5 and N12, like in the
 * FORTRAN version, have been eliminated here.
 *
 * An optional command-line argument has been provided [-c] to
 * offer continuous repetition of the entire benchmark.
 * An optional argument for setting an alternate LOOP count is also
 * provided.  Define PRINTOUT to cause the POUT() function to print
 * outputs at various stages.  Final timing measurements should be
 * made with the PRINTOUT undefined.
 *
 * Questions and comments may be directed to the author at
 *			r.painter@ieee.org
 */
/*
C**********************************************************************
C     Benchmark #2 -- float  Precision Whetstone (A001)
C
C     o	This is a REAL*8 version of
C	the Whetstone benchmark program.
C
C     o	DO-loop semantics are ANSI-66 compatible.
C
C     o	Final measurements are to be made with all
C	WRITE statements and FORMAT sttements removed.
C
C**********************************************************************   
*/

/* standard C library headers required */
#include <stdint.h>
#include "cosine_table.h"
#include "custom_instructions.h"
#include "hex_to_ascii.h"
#include "ee_printf.h"

// #define PRINTOUT
/* map the FORTRAN math functions, etc. to the C versions */

float sine_from_rads_interp(float angle_rad){
	// uart_write("SINE\n\r",7);
	// Wrap angle
    while ((int32_t)angle_rad < 0) angle_rad += TWO_PI;
    while ((int32_t)(angle_rad*10.0f) >= 62) angle_rad += (MINUS_TWO_PI);

    // Compute float index
    float f_index = angle_rad / TWO_PI * TABLE_SIZE;
    uint8_t i0 = (uint8_t)(f_index + 64) %TABLE_SIZE;
    uint8_t i1 = (i0 + 1 + 64) % TABLE_SIZE;
    float frac = f_index + (-i0);

    // Linear interpolation
    int16_t y0 = cosine_table[i0];
    int16_t y1 = cosine_table[i1];
	float dif=(float)(y1 + (-y0));
	float acc=dif*frac;
    return ((float)y0 + acc);
}

float my_sub(float a, float b)
{
    float neg_b, result;
	float val=-1.0f;
    asm volatile("fmul.s %0, %1, %2" : "=f"(neg_b) : "f"(b),"f"(val));
    asm volatile("fadd.s %0, %1, %2" : "=f"(result) : "f"(a), "f"(neg_b));
    return result;
}

float atan_approx(float x)
{
	// uart_write("atan\n\r",7);
    // handle negative inputs
    int sign = 1;
    if ((uint32_t) x*1000.0f < 0) { x *= -1.0f; sign = -1; }

    float y;
    if ((uint32_t)x > 1){ 
        y = x/(x*x + 0.28f); // π/2 - correction
		y=my_sub(1.57079632679f,y);
	}
    else
        y = x / (1.0f + (0.28f * x*x));

    return sign * y;
}
float log_approx(float x)
{
	// uart_write("log\t",4);
	// print_float(x);
	// uart_write("\n\r",2);
    int exponent = 0;

    // normalize x to [1, 2)
    while ((int32_t) (x*1000.0f) > 2000) { x *= 0.5f; exponent++; }
    while ((int32_t)(x*1000.0f) < 1000) { x *= 2.0f; exponent--; }
	
    x = my_sub( x,1.0f); // shift: ln(1+x)
    float result = my_sub(my_sub (x , 0.5f*x*x + x*x*x/3.0f) , x*x*x*x/4.0f); // Taylor series
    return result + exponent * 0.69314718056f; // add e*ln(2)
}
float exp_approx(float x)
{
	// uart_write("exp\t",4);
	// print_float(x);
	// uart_write("\n\r",2);

	float sum = 1.0f; // first term
    float term = 1.0f;
    for (int i = 1; i < 11; i++) // 10 terms
    {
        term *= x / i;
        sum += term;
    }
    return sum;
}

float sqrt_newton(float x)
{
	// uart_write("sqrt\t",4);
	// print_float(x);
	// uart_write("\n\r",2);

    if ((uint32_t)(x*10000.0f) <= 0) return 0;  // handle zero/negative

    float y = x;  // initial guess
    for (int i = 0; i < 5; i++)
    {
        y = 0.5f * (y + x / y);
    }
    return y;
}
#define DSIN	sine_from_rads_interp  //good 
#define DCOS	cosine_from_rads_interp	 //good 
#define DATAN	atan_approx //fine
#define DLOG	log_approx  //bad
#define DEXP	exp_approx  //bad
#define DSQRT	sqrt_newton //fine
#define IF		if


#define TWO_PI (6.283185f)
#define PI (3.141592f)
#define FS (8000.0f)
#define F0 (440.0f)
#define STEP (float)(2*PI*F0/FS)


/* function prototypes */
void POUT(long N, long J, long K, float X1, float X2, float X3, float X4);
void PA(float E[]);
void P0(void);
void P3(float X, float Y, float *Z);
#define USAGE	"usage: whetdc [-c] [loops]\n"

/*
	COMMON T,T1,T2,E1(4),J,K,L
*/
float T,T1,T2,E1[5];
int J,K,L;

int
main()
{
	uart_write("main\n\r",7);
	/* used in the FORTRAN version */
	long I;
	long N1, N2, N3, N4, N6, N7, N8, N9, N10, N11;
	float X1,X2,X3,X4,X,Y,Z;
	long LOOP;
	int II, JJ;

	/* added for this version */
	long loopstart;
	long startsec, finisec,startsec_upper, finisec_upper;
	float KIPS;
	int continuous;

	loopstart = 1000;		/* see the note about LOOP below */
	continuous = 1;

LCONT:
/*
C
C	Start benchmark timing at this point.
C
*/
uint32_t data=0;
output_data((uint8_t*)&data,0,WORD);   
input_data((uint8_t*)&startsec,0,WORD);
asm volatile(
        "la t0, 0x0\n"  // load address 0 into t0
        "lw %0, 0(t0)\n"
        : "=r"(startsec)    // output
        :               // no input
        : "t0"          // clobbered register
    );
data=1;
output_data((uint8_t*)&data,0,WORD);   
input_data((uint8_t*)&startsec_upper,0,WORD);
asm volatile(
        "la t0, 0x0\n"  // load address 0 into t0
        "lw %0, 0(t0)\n"
        : "=r"(startsec_upper)    // output
        :               // no input
        : "t0"          // clobbered register
    );

/*
C
C	The actual benchmark starts here.
C
*/
	T  = .499975f;
	T1 = 0.50025f;
	T2 = 2.0f;
/*
C
C	With loopcount LOOP=10, one million Whetstone instructions
C	will be executed in EACH MAJOR LOOP..A MAJOR LOOP IS EXECUTED
C	'II' TIMES TO INCREASE WALL-CLOCK TIMING ACCURACY.
C
	LOOP = 1000;
*/
	LOOP = loopstart;
	II   = 10;

	JJ = 1;

IILOOP:
	N1  = 0;
	N2  = 12 * LOOP;
	N3  = 14 * LOOP;
	N4  = 345 * LOOP;
	N6  = 210 * LOOP;
	N7  = 32 * LOOP;
	N8  = 899 * LOOP;
	N9  = 616 * LOOP;
	N10 = 0;
	N11 = 93 * LOOP;

/*
C
C	Module 1: Simple identifiers
C
*/
	// uart_write("Module 1: Simple identifiers\n\r",31);

	X1  =  1.0f;
	X2  = -1.0f;
	X3  = -1.0f;
	X4  = -1.0f;

	for (I = 1; I < N1; I++) {
	    X1 = (X1 + X2 + my_sub(X3 , X4)) * T;
	    X2 = (X1 + my_sub(X2,X3) + X4) * T;
	    X3 = (my_sub(X1,X2) + X3 + X4) * T;
	    X4 = (my_sub((X2), X1) + X3 + X4) * T;
	}
#ifdef PRINTOUT
	IF (JJ==II)POUT(N1,N1,N1,X1,X2,X3,X4);
#endif

/*
C
C	Module 2: Array elements
C
*/
	// uart_write("Module 2: Array elements\n\r",27);
	E1[1] =  1.0f;
	E1[2] = -1.0f;
	E1[3] = -1.0f;
	E1[4] = -1.0f;

	for (I = 1; I < N2; I++) {
	    E1[1] = ( E1[1] + E1[2] + my_sub(E1[3] , E1[4])) * T;
	    E1[2] = ( E1[1] + my_sub(E1[2] , E1[3]) + E1[4]) * T;
	    E1[3] = ( my_sub(E1[1] , E1[2]) + E1[3] + E1[4]) * T;
	    E1[4] = (my_sub(E1[2] , E1[1]) + E1[3] + E1[4]) * T;
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N2,N3,N2,E1[1],E1[2],E1[3],E1[4]);
#endif

/*
C
C	Module 3: Array as parameter
C
*/
	// uart_write("Module 3: Array as parameter\n\r",31);
	for (I = 1; I < N3; I++)
		PA(E1);

#ifdef PRINTOUT
	IF (JJ==II)POUT(N3,N2,N2,E1[1],E1[2],E1[3],E1[4]);
#endif

/*
C
C	Module 4: Conditional jumps
C
*/
	// uart_write("Module 4: Conditional jumps\n\r",30);
	J = 1;
	for (I = 1; I < N4; I++) {
		if (J == 1)
			J = 2;
		else
			J = 3;

		if (J > 2)
			J = 0;
		else
			J = 1;

		if (J < 1)
			J = 1;
		else
			J = 0;
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N4,J,J,X1,X2,X3,X4);
#endif

/*
C
C	Module 5: Omitted
C 	Module 6: Integer arithmetic
C
*/
// uart_write("Module 5: Omitted\n\rModule 6: Integer arithmetic\n\r",50);

	J = 1;
	K = 2;
	L = 3;
	for (I = 1; I < N6; I++) {
	    J = J * (K-J) * (L-K);
	    K = L * K - (L-J) * K;
	    L = (L-K) * (K+J);
	    E1[L-1] = J + K + L;
	    E1[K-1] = J * K * L;
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N6,J,K,E1[1],E1[2],E1[3],E1[4]);
#endif

/*
C
C	Module 7: Trigonometric functions
C
*/
// uart_write("Module 7: Trigonometric functions\n\r",36);

X = 0.5f;
Y = 0.5f;

for (I = 1; I < N7; I++) {
		// uart_write("iter_stuck\n\r",13);
		X = T * DATAN(T2*DSIN(X)*DCOS(X)/(DCOS(X+Y)+DCOS(my_sub(my_sub(X,Y),1.0f))));
		Y = T * DATAN(T2*DSIN(Y)*DCOS(Y)/(DCOS(X+Y)+DCOS(my_sub(my_sub(X,Y),1.0f))));
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N7,J,K,X,X,Y,Y);
#endif

/*
C
C	Module 8: Procedure calls
C
*/
// uart_write("Module 8: Procedure calls\n\r",28);

	X = 1.0f;
	Y = 1.0f;
	Z = 1.0f;
	for (I = 1; I <= N8; I++)
		P3(X,Y,&Z);

#ifdef PRINTOUT
	IF (JJ==II)POUT(N8,J,K,X,Y,Z,Z);
#endif

/*
C
C	Module 9: Array references
C
*/
// uart_write("Module 9: Array references\n\r",29);

	J = 1;
	K = 2;
	L = 3;
	E1[1] = 1.0f;
	E1[2] = 2.0f;
	E1[3] = 3.0f;

	for (I = 1; I < N9; I++)
		P0();

#ifdef PRINTOUT
	IF (JJ==II)POUT(N9,J,K,E1[1],E1[2],E1[3],E1[4]);
#endif

/*
C
C	Module 10: Integer arithmetic
C
*/
// uart_write("Module 10: Integer arithmetic\n\r",32);

	J = 2;
	K = 3;


	for (I = 1; I < N10; I++) {
	    J = J + K;
	    K = J + K;
	    J = K - J;
	    K = K - J - J;
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N10,J,K,X1,X2,X3,X4);
#endif

/*
C
C	Module 11: Standard functions
C
*/
// uart_write("Module 11: Standard functions\n\r",32);

	X = 0.75f;

	for (I = 1; I < N11; I++){
		X = DSQRT(DEXP(DLOG(X)/T1));
	}

#ifdef PRINTOUT
	IF (JJ==II)POUT(N11,J,K,X,X,X,X);
#endif

/*
C
C      THIS IS THE END OF THE MAJOR LOOP.
C
*/
	if (++JJ <= II)
		goto IILOOP;

/*
C
C      Stop benchmark timing at this point.
C
*/
data=0;
output_data((uint8_t*)&data,0,WORD);   
input_data((uint8_t*)&finisec,0,WORD);
asm volatile(
        "la t0, 0x0\n"  // load address 0 into t0
        "lw %0, 0(t0)\n"
        : "=r"(finisec)    // output
        :               // no input
        : "t0"          // clobbered register
    );
data=1;
output_data((uint8_t*)&data,0,WORD);   
input_data((uint8_t*)&finisec_upper,0,WORD);
asm volatile(
        "la t0, 0x0\n"  // load address 0 into t0
        "lw %0, 0(t0)\n"
        : "=r"(finisec_upper)    // output
        :               // no input
        : "t0"          // clobbered register
    );

/*
C----------------------------------------------------------------
C      Performance in Whetstone KIP's per second is given by
C
C	(100*LOOP*II)/TIME
C
C      where TIME is in seconds.
C--------------------------------------------------------------------
*/
	ee_printf("\n\r");
	if (finisec-startsec <= 0) {
		ee_printf("Insufficient duration- Increase the LOOP count\n");
		return(1);
	}
	// 50MHZ CLK
	// 64 bit counter
	// upper 32 bits are accessed when lower 32 bits over flow, 2**32-1 /50000000 = 85.89 SEC
	float duration_sec=(float)(finisec-startsec)/50000000.0f;
	float duration_sec_upper=(float)(finisec_upper-startsec_upper);
	float total_duration=duration_sec+(duration_sec_upper*85.90f);
	
	ee_printf("Loops: %ld, Iterations: %d, ",LOOP, II);
	// ee_printf("Duration Cycles : ");
	// print_int(finisec-startsec);
	ee_printf("Duration secs : ");
	print_float(total_duration);
	ee_printf("\n\r");
	
	KIPS = (100.0*LOOP*II)/(float)(total_duration);
	
	ee_printf("KIPS : ");
	print_float(KIPS);
	ee_printf("\n\r");
	// if (KIPS >= 1000.0)
	// 	// ee_printf("C Converted float Precision Whetstones: %.1f MIPS\n", KIPS/1000.0);
	// else
	// 	// ee_printf("C Converted float Precision Whetstones: %.1f KIPS\n", KIPS);

	if (continuous)
		goto LCONT;

	return(0);
}

void
PA(float E[])
{
	J = 0;

L10:
		E1[1] = ( E1[1] + E1[2] + my_sub(E1[3] , E1[4])) * T;
	    E1[2] = ( E1[1] + my_sub(E1[2] , E1[3]) , E1[4]) * T;
	    E1[3] = ( my_sub(E1[1] , E1[2]) + E1[3] + E1[4]) * T;
	    E1[4] = (my_sub(E1[2] , E1[1]) + E1[3] + E1[4]) * T;
		J += 1;
	if (J < 6)
		goto L10;
}

void
P0(void)
{
	E1[J] = E1[K];
	E1[K] = E1[L];
	E1[L] = E1[J];
}

void
P3(float X, float Y, float *Z)
{
	float X1, Y1;

	X1 = X;
	Y1 = Y;
	X1 = T * (X1 + Y1);
	Y1 = T * (X1 + Y1);
	*Z  = (X1 + Y1) / T2;
}

#ifdef PRINTOUT
void
POUT(long N, long J, long K, float X1, float X2, float X3, float X4)
{
	ee_printf("%7ld %7ld %7ld\n\r",N, J, K);
	print_float(X1);
	uart_write(" ",1);
	print_float(X2);
	uart_write(" ",1);
	print_float(X3);
	uart_write(" ",1);
	print_float(X4);
	uart_write("\n\r",2);
}
#endif

extern int _stack_start;
__attribute__((naked, noreturn))
void __attribute__((section(".text.Reset"))) Reset(){
    
    __asm__ volatile ("la sp,_stack_start\n\t");//set sp to last memory location
    disable_interrupts();    
    uart_disable(TX_ENABLE|RX_ENABLE);
    main();
}