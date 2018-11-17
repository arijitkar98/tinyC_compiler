//handling global variables
int dog = 6;
int main()
{
	printStr("This Program handles global variables\n");
	int i;
	i = dog + 2; //6+2
	printStr("i = ");
	printInt(i);
	printStr("\n");
	dog = 5;
	i = dog;   //5
	printStr("i = ");
	printInt(i);
	printStr("\n");
	return 0;
}
