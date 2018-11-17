#include "myl.h"

int main()
{
	int i;
	float f;
	printStr("Enter integer number: ");
	readInt(&i);
	printStr("Enter float number: ");
	readFlt(&f);

	printStr("The integer is ");
	printInt(i);

	printStr("The float is ");
	printFlt(f);
}
