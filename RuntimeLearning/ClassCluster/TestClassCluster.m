//
//  TestClassCluster.m
//  RuntimeLearning
//
//  Created by 贺超 on 2019/12/4.
//  Copyright © 2019年 hechao. All rights reserved.
//

#import "TestClassCluster.h"

@implementation TestClassCluster

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
    }
    
    return self;
}

- (void)test {
    /*
     类簇（Class  Cluster）是定义相同的接口并提供相同功能的一组类的集合，仅公开接口的抽象类也可以称之为类簇的公共类，每个具体类的接口有公共类的接口抽象化，并隐藏在簇的内部。这些类一般不能够直接使用，一般都是由公共类的子类来实现，可以称之为私有子类。
     eg：NSString、 NSNumber、NSArray、NSDictionary、NSDate、NSSet、NSHashMap等
     */
    [self testNSString];
    [self testArray];
    [self testNumber];
    [self testNSDate];
    [self testNSSet];
    [self testNSMap];
}

- (void)testNSString {
    NSString *aString = [NSString stringWithFormat:@"111"];
    if ([aString isMemberOfClass:[NSString class]]) {
        NSLog(@"[aString isMemberOfClass:[NSString class]]");
    } else if ([aString isKindOfClass:[NSString class]]) {
        NSLog(@"[aString isKindOfClass:[NSString class]]");
    }
    NSLog(@"aString class is %@", NSStringFromClass([aString class])); // aString class is NSTaggedPointerString
    NSString *bString = @"111";
    NSLog(@"bString class is %@", NSStringFromClass([bString class])); // bString class is __NSCFConstantString
    NSString *cString = [NSString stringWithFormat:@"111111111111"];
    NSLog(@"cString class is %@", NSStringFromClass([cString class])); // cString class is __NSCFString
}

- (void)testArray {
    NSArray *array = @[];
    if ([array isMemberOfClass:[NSArray class]]) {
        NSLog(@"[array isMemberOfClass:[NSArray class]]");
    } else if ([array isKindOfClass:[NSArray class]]) {
        NSLog(@"[array isKindOfClass:[NSArray class]]");
    }
    NSLog(@"arrary class is %@", NSStringFromClass([array class])); // arrary class is __NSArray0
    
    NSMutableArray *mutableArray = @[].mutableCopy;
    if ([mutableArray isMemberOfClass:[NSMutableArray class]]) {
        NSLog(@"[mutableArray isMemberOfClass:[NSMutableArray class]]");
    } else if ([mutableArray isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"[mutableArray isKindOfClass:[NSMutableArray class]]");
    }
    NSLog(@"mutableArray class is %@", NSStringFromClass([mutableArray class])); // mutableArray class is __NSArrayM
}

- (void)testNumber {
    NSNumber *boolNumber = [NSNumber numberWithBool:NO];
    if ([boolNumber isMemberOfClass:[NSNumber class]]) {
        NSLog(@"[boolNumber isMemberOfClass:[NSNumber class]]");
    } else if ([boolNumber isKindOfClass:[NSNumber class]]) {
        NSLog(@"[boolNumber isKindOfClass:[NSNumber class]]");
    }
    NSLog(@"boolNumber class is %@", NSStringFromClass([boolNumber class])); // boolNumber class is __NSCFBoolean
}

- (void)testNSDate {
    NSDate *date = [NSDate date];
    if ([date isMemberOfClass:[NSDate class]]) {
        NSLog(@"[date isMemberOfClass:[NSDate class]]");
    } else if ([date isKindOfClass:[NSDate class]]) {
        NSLog(@"[date isKindOfClass:[NSDate class]]");
    }
    NSLog(@"date class is %@", NSStringFromClass([date class]));
    // date class is __NSTaggedDate
    // date class is __NSDate
}

- (void)testNSSet {
    NSSet *set = [NSSet new];
    if ([set isMemberOfClass:[NSSet class]]) {
        NSLog(@"[set isMemberOfClass:[NSSet class]]");
    } else if ([set isKindOfClass:[NSSet class]]) {
        NSLog(@"[set isKindOfClass:[NSSet class]]");
    }
    NSLog(@"set class is %@", NSStringFromClass([set class])); // set class is __NSSetI
}

- (void)testNSMap {
    NSMapTable *table = [NSMapTable new];
    if ([table isMemberOfClass:[NSMapTable class]]) {
        NSLog(@"[table isMemberOfClass:[NSMapTable class]]");
    } else if ([table isKindOfClass:[NSMapTable class]]) {
        NSLog(@"[table isKindOfClass:[NSMapTable class]]");
    }
    NSLog(@"NSMapTable class is %@", NSStringFromClass([table class])); // NSMapTable class is NSConcreteMapTable
}

@end
