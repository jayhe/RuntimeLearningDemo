//
//  TestCode.m
//  RuntimeLearning
//
//  Created by hechao on 2019/9/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestCode.h"

typedef struct  Obs {
    id        observer;   /* Object to receive message.   */
    int       retained;
} Observation;

@implementation TestCode

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }
    
    return self;
}

- (void)test {
    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
    Observation *obs = malloc(sizeof(Observation));
//    obs->retained = 0;
    obs->observer = self;
    NSLog(@"%ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
    /*
     2019-09-19 09:57:41.229922+0800 RuntimeLearning[99635:3579888] 1
     2019-09-19 09:57:44.509753+0800 RuntimeLearning[99635:3579888] 1
     */
}

@end
