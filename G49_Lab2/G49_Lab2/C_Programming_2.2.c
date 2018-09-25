 extern int MAX_2(int x, int y);

int main(){

  // int a, b, c;
  // a=4;
  // b=2;
  // c = MAX_2(a, b);
  // return c;

 int a[5] = {1, 20, 3, 4, 5};
int max_val = a[0];
int i;
for(i=0; i < sizeof(a)/sizeof(a[0]); i++) {
     max_val = MAX_2(max_val, a[i]);
     
}
return max_val;

}

