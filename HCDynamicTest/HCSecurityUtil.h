//
//  HCSecurityUtil.h
//  HCDynamicTest
//
//  Created by 贺超 on 2020/6/20.
//  Copyright © 2020 hechao. All rights reserved.
//

#ifndef HCSecurityUtil_h
#define HCSecurityUtil_h

#include <stdio.h>

//char *hc_aes(char *someString);
char *hc_aes(char *someString) asm("HC_112233");
char *hc_des(char *someString);

#endif /* HCSecurityUtil_h */
