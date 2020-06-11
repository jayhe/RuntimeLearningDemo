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
    [self setValue:@"JayHe" forKey:@"Name"];
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[24880:398327] Name = (null) name = JayHe
}

- (void)testSetProperty {
    self.Name = @"JayHe";
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[24955:405445] Name = (null) name = JayHe
}

- (void)testSetPropertyWhenChangeDeclareOrder {
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

- (void)setName:(NSString *)Name {
    NSLog(@"类别中的方法调用了");
}

@end
