//
//  TestCategory+Test.m
//  RuntimeLearning
//
//  Created by 贺超 on 2021/3/2.
//  Copyright © 2021 hechao. All rights reserved.
//

#import "TestCategory+Test.h"

@implementation TestCategory (Test)

//+ (void)load {
//
//}

- (void)testSomeMethod {
    
}

@end

/*
 case 1: 当分类中没有实现load方法的时候，在MachO的__DATA,__objc_catlist段是看不到对应的分类
 通过otool来查看macho的文件信息
 -o print the Objective-C segment
 -v print verbosely (symbolically) when possible
 
 otool -ov RuntimeLearning
 
 0000000100054970 0x100061410 _OBJC_CLASS_$_TestCategory
     isa        0x1000613e8 _OBJC_METACLASS_$_TestCategory
     superclass 0x0 _OBJC_CLASS_$_NSObject
     cache      0x0 __objc_empty_cache
     vtable     0x0
     data       0x100055530 __OBJC_CLASS_RO_$_TestCategory
         flags          0x80
         instanceStart  8
         instanceSize   8
         reserved       0x00000000
         ivarLayout     0x0
         name           0x100043da5 TestCategory
         baseMethods    0x100055498 __OBJC_$_INSTANCE_METHODS_TestCategory(Test1|Test)
             entsize 24
             count   3
             name    0x10004462c testSomeMethod
             types   0x100048deb v16@0:8
             imp     0x10000fa3c -[TestCategory(Test) testSomeMethod]
             name    0x10004462c testSomeMethod
             types   0x100048deb v16@0:8
             imp     0x10000d820 -[TestCategory(Test1) testSomeMethod]
             name    0x10004462c testSomeMethod
             types   0x100048deb v16@0:8
             imp     0x10000d7a0 -[TestCategory testSomeMethod]
         baseProtocols  0x0
         ivars          0x0
         weakIvarLayout 0x0
         baseProperties 0x0
 Meta Class
     isa        0x0 _OBJC_METACLASS_$_NSObject
     superclass 0x0 _OBJC_METACLASS_$_NSObject
     cache      0x0 __objc_empty_cache
     vtable     0x0
     data       0x1000554e8 __OBJC_METACLASS_RO_$_TestCategory
         flags          0x81 RO_META
         instanceStart  40
         instanceSize   40
         reserved       0x00000000
         ivarLayout     0x0
         name           0x100043da5 TestCategory
         baseMethods    0x100055478 __OBJC_$_CLASS_METHODS_TestCategory(Test1|Test)
             entsize 24
             count   1
             name    0x100044451 load
             types   0x100048deb v16@0:8
             imp     0x10000d7e0 +[TestCategory(Test1) load]
         baseProtocols  0x0
         ivars          0x0
         weakIvarLayout 0x0
         baseProperties 0x0

 */
