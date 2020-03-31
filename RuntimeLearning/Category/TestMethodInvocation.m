//
//  TestMethodInvocation.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/3/14.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestMethodInvocation.h"
#import <objc/runtime.h>

@interface TestMethodInvocation ()

@property (nonatomic, copy) NSString *Name;
@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *address;

@end

@implementation TestMethodInvocation

//@synthesize address = _address;

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
    _address = @"address";
    NSLog(@"Name = %@ name = %@", self.Name, self.name); // RuntimeLearning[25015:409263] Name = JayHe name = (null)
}

- (void)logMethodListDescription {
    unsigned int count;
    Method *mList = class_copyMethodList(self.class, &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = mList[i];
        struct objc_method_description *description = method_getDescription(method);
        NSLog(@"%@", NSStringFromSelector(description->name));
    }
    free(mList);
}

- (void)logIvarListDescription {
    unsigned int count;
    Ivar *ivarList = class_copyIvarList(self.class, &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        NSLog(@"%@", [NSString stringWithCString:ivar_getName(ivar) encoding:NSUTF8StringEncoding]);
    }
    free(ivarList);
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
