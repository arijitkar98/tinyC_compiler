int insertion_sort(int arr[], int n)
{
   int i, key, j;
   for (i = 1; i < n; i++)
   {
       key = arr[i];
       j = i-1;

       while (j >= 0 && arr[j] > key)
       {
           arr[j+1] = arr[j];
           j = j-1;
       }
       arr[j+1] = key;
   }
   return 0;
}

int main()
{
    printStr("This Program implements insertion sort\n");
    int arr[100];
    int n, err = 1;
    printStr("Enter the size of an array: \n");
    n = readInt(&err);
    printStr("Enter the elements of the array to be sorted: \n");
    for(i=0;i<n;i++)
    {
         arr[i] = readInt(&err);
    }

    insertion_sort(arr, n);
    printStr("The sorted array is: \n");
    for (i=0; i < n-1; i++)
    {
        printInt(arr[i]);
        printStr(", ");
    }
    printInt(arr[n-1]);
    printStr("\n");

    return 0;
}
