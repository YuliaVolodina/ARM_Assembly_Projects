#include "address_map_arm.h"


int main()
{
	int a[5] = {1, 20, 3, 4, 5};
    int max_val;
    max_val = -100;
    int i;
   for ( i=0; i < 5; i++) {
     if ( a[i] > max_val){
      max_val = a[i];
}

}
    return max_val;
}