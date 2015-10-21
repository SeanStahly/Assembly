#include <stdio.h>
#include <string.h>
#include <stdlib.h>

// By Sean Stahly 10/16/2015

int functionA(int a, int b, int c) {
  int d = a + b +c;
  d = d % b;
  return d;
}

char functionB(short a, short b, short c, short d, short e) {
	int i;
  int j;
  i=a;
  j=e;
	i = i * 256;
  i = b + i;
  i = i * 256;
  i = c + i;
  i = i * 256;
  i = d + i;
  return i % j;
}

short functionC(short a, short b) {
  int i;
  short j[20];
  for (i =0; i < 19; i++) {
    j[i] = b + (a*i);
  }
  for (i =0; i < 19; i++) {
    b += j[i];
  }
  return b;
}

double functionD(float a, float b, int c) {
  double d;
  int i;
  d =a*b;
  for (i =0; i < c; i++) {
    d = d*d;
  }
  return d;
}

int main(int argc, char ** argv, char ** envp) {
  char b;
  short c;
  int a;
  double d;

  a = functionA(1, 2, 19);
  printf("A=%d\n", a);

  b = functionB(97, 98, 99, 33, 32);
  printf("B=%08X\n", b);

  scanf("%hu", &c);
  c = functionC(c, 255);
  printf("C=%04X\n", c);

  d = functionD(66741862, 67344793, 10);
  printf("D=%lf\n", d);

}
