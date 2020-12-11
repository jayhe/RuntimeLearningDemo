//
//  TestMethodInvocation.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/14.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestMethodInvocation.h"
#import <objc/runtime.h>
#import "NSObject+HCLog.h"

@interface TestMethodInvocation ()

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *name;

@end

@implementation TestMethodInvocation

- (void)testKVCSetProperty {
    // Name定义在name之后
    [self setValue:@"JayHe" forKey:@"Name"];
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[24880:398327] Name = (null) name = JayHe
}

- (void)testSetProperty {
    // Name定义在name之后
    self.Name = @"JayHe";
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[24955:405445] Name = (null) name = JayHe
}
/*
 (lldb) po [self _shortMethodDescription]
 <TestMethodInvocation: 0x600001730240>:
 in TestMethodInvocation:
     Properties:
         @property (copy, nonatomic) NSString* Name;  (@synthesize Name = _Name;)
         @property (copy, nonatomic) NSString* name;  (@synthesize name = _name;)
     Instance Methods:
         - (void) testKVCSetProperty; (0x10507b160)
         - (void) testSetProperty; (0x10507b230)
         - (void) testSetPropertyWhenChangeDeclareOrder; (0x105068d90)
         - (void) callOriginalClassMethod; (0x10507b300)
         - (id) name; (0x105068eb0)
         - (void) .cxx_destruct; (0x105068f00)
         - (void) setName:(id)arg1; (0x10507b460)
         - (void) setName:(id)arg1; (0x10507b4c0)
         - (id) Name; (0x105068e60)
 (NSObject ...)

 (lldb)
 */
- (void)testSetPropertyWhenChangeDeclareOrder {
    // Name定义在前
    self.Name = @"JayHe";
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[25015:409263] Name = JayHe name = (null)
}

- (void)callOriginalClassMethod {
    unsigned int count;
    Method *mList = class_copyMethodList(self.class, &count);
    unsigned int findIndex = 0;
    for (unsigned int i = 0; i < count; i++) {
        Method method = mList[i];
        struct objc_method_description *description = method_getDescription(method);
        NSLog(@"%@", NSStringFromSelector(description->name));
        if (description->name == @selector(setName:)) {
            findIndex = i;
        }
    }
    if (findIndex) {
        Method method = mList[findIndex];
        SEL selector = method_getName(method);
        IMP imp = method_getImplementation(method);
        ((void (*)(id, SEL, NSString *))imp)(self,selector, @"JayHe");//_objc_msgForward
        //            ((void (*)(id,SEL, NSString *))objc_msgSend)(self, selector, @"JayHe");
    }
    
    free(mList);
}

@end

@implementation TestMethodInvocation(Category)

//- (void)setName:(NSString *)Name {
//    NSLog(@"类别中的方法调用了");
//}

@end
