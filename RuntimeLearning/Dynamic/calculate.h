//
//  calculate.h
//  RuntimeLearning
//
//  Created by hechao on 2019/4/29.
//  Copyright © 2019 hechao. All rights reserved.
//

#ifndef calculate_h
#define calculate_h

#include <stdio.h>

int add(int a, int b);
//int calculate_add(int a, int b);
int calculate_add(int a, int b) asm("HC_Login_Action");

#endif /* calculate_h */
