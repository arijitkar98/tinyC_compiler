#include "myl.h"

#define BUFF 20

int printStr(char* str)
{
    int number_of_bytes=0;
    while(str[number_of_bytes]!='\0')
    	number_of_bytes++;

	// Printing the string via syscall 
    __asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"
        "syscall \n\t"
        :
        :"S"(str), "d"(number_of_bytes)
    );
    return number_of_bytes;
}

int readInt(int *n)
{
	int i = 0;
	int number_of_bytes = BUFF;
	char buffer[BUFF];
	int flag = 0;

	// Reading via syscall
	__asm__ __volatile__ (
		// To read the input eax <- 0
		"movl $0, %%eax \n\t"
        "movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		// Reading the int number with maximum buffer length BUFF
		:"S"(buffer), "d"(number_of_bytes)
	);

	number_of_bytes = 0;

	// Finding length of buffer input
	while(buffer[number_of_bytes]!='\0' && buffer[number_of_bytes]!='\n')
		number_of_bytes++;

	// Adding '\0' at the end of the buffer to terminate
	buffer[number_of_bytes]='\0';

	if(buffer[0] == '-') 
		i = 1;
	else 
		i = 0;

	int num = 0;

	while(i != number_of_bytes)
	{
		char c = buffer[i];
		if( c >= '0' && c <= '9')
		{
			// Value of the integer in buffer
			num = 10*num + (c - '0');
		}
		else 
		{
			flag = 1;
			break;
		}
		i++;
	}

	if(buffer[0]=='-')
		*n = -num;
	else 
		*n = num;

	if(flag == 1)
		return ERR;
	return OK;
}

int printInt(int n)
{
    char buffer[BUFF];
    int i = 0;
    int j, k, number_of_bytes;

    if(n == 0) 
    	buffer[i++] = '0';
    else
    {
    	if(n < 0) 
       	{
        	buffer[i++]='-';
          	n = -n;
       	}
       	
       	while(n)
       	{
       		// Finding all the digits in the number
        	int digit = n%10;
        	// Convert integer to char and store in buffer
          	buffer[i++] = (char)('0' + digit);
          	n /= 10;
       	}

       	if(buffer[0] == '-') 
       		// Ignoring the -ve sign 
       		j = 1;
       	else 
       		j = 0;
       	k = i - 1;

       	while(j < k)
       	{ 	
       		// Reversing the contents of buffer
          	char temp = buffer[j];
          	buffer[j++] = buffer[k];
          	buffer[k--] = temp;
       	}
    } 

    // Adding '\n' at the end of the buffer to terminate
    buffer[i]= '\n';
    // Buffer length will be length + 1
    number_of_bytes = i + 1;

    // Printing the int number via syscall
    __asm__ __volatile__ (
    		// To print string eax <- 1
	        "movl $1, %%eax \n\t"
	        // Argument to function 
    	    "movq $1, %%rdi \n\t"
          	"syscall \n\t"
          	:
          	// buffer and buffer length
          	:"S"(buffer), "d"(number_of_bytes)
    ) ;  // $1: write, $1: on stdin

    return number_of_bytes;
}

int readFlt(float *f)
{
	int i = 0;
	int number_of_bytes = BUFF;
	char buffer[BUFF];
	int flag = 0;

	// Reading via syscall
	__asm__ __volatile__ (
		// To read the input eax <- 0
		"movl $0, %%eax \n\t" 	
        "movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		// Reading the float number with maximum buffer length BUFF
		:"S"(buffer), "d"(number_of_bytes) 
	);

	number_of_bytes = 0;

	// Finding length of buffer input
	while(buffer[number_of_bytes]!='\0' && buffer[number_of_bytes]!='\n')
		number_of_bytes++;
	// Adding '\0' at the end of the buffer to terminate
	buffer[number_of_bytes]='\0';

	if(buffer[0] == '-') 
		i = 1;
	else 
		i = 0;

	float num = 0.0;
	float dec = 1.0;

	while(i != number_of_bytes)
	{
		char c = buffer[i];
		if(c == '.')
		{
			if(dec == 1.0)
				dec /= 10.0;
			else 
			{	// Already considered decimal point, thus this case is invalid
				flag = 1;
				break;
			}
		}
		else if(c >= '0' && c <= '9')
		{
			// Integer part of the float number
			if(dec == 1)		
				num = 10*num + (c-'0');
			else 
			{	
				// Decimal part of the float number
				num = num + (c-'0')*dec;
				dec /= 10;
			} 
		}
		else 
		{	
			// Any other random character should not be valid
			flag = 1;
			break;
		}
		i++;
	}

	if(buffer[0]=='-')
		*f = -num;
	else 
		*f = num;

	if(flag == 1)
		return ERR;
	return OK;
}

int printFlt(float f)
{
	char buffer[BUFF];
	int i = 0, j, k, number_of_bytes;

	if(f == 0) 
		buffer[i++] = '0';
	else 
	{	
		// Integer part of float number
		int n = f;	
		
		if(n == 0) 
			buffer[i++]='0';
		else
		{
			if(n < 0) 
			{
				f = -f;
				buffer[i++] = '-';
				n = -n;
			}

			// Calculating the decimal part of the float number
			f = f - n;
			
			// Finding all the digits in integer part of float number
			while(n)
			{
				int digit = n%10; 
				// Convert integer to char and store in buffer
				buffer[i++] = (char)('0' + digit); 
				n /= 10;
			}

			if(buffer[0] == '-')
				// Ignoring the -ve sign 
				j = 1; 
			else 
				j = 0;
			k = i - 1;
			
				// Reversing the contents of buffer
			while(j < k)
			{
				char temp = buffer[j];
				buffer[j++] = buffer[k];
				buffer[k--] = temp;
			} 
		}

		// Adding the decimal part of float number
		buffer[i++] = '.';
		for(int j = 0; j<7; j++)
		{
			f *= 10; 
			int digit = f; 
			buffer[i++] = (digit + '0');
			f -= digit; 	
		}
	}

	// Adding '\n' at the end of the buffer to terminate
	buffer[i] = '\n';
	// Buffer length will be length + 1
	number_of_bytes = i + 1;

	// Printing the float number via syscall
	__asm__ __volatile__ (
		// To print string eax <- 1 
		"movl $1, %%eax \n\t"
		// Argument to function 	
		"movq $1, %%rdi \n\t"
		"syscall \n\t"
		:
		// buffer and buffer length
		:"S"(buffer), "d"(number_of_bytes) 
	);
	return number_of_bytes;
}
