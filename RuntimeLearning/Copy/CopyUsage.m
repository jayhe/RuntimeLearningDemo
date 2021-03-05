//
//  CopyUsage.m
//  RuntimeLearning
//
//  Created by hechao on 2019/7/3.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "CopyUsage.h"

@interface CopyUsage ()

@property (nonatomic, copy) NSString *pCopyStr; // copy修饰的str
@property (nonatomic, strong) NSString *pStrongStr; // strong修饰的str

@property (nonatomic, copy) NSArray *pCopyArray; // copy修饰的array
@property (nonatomic, strong) NSArray *pStrongArray; // strong修饰的array

@property (nonatomic, copy) NSDictionary *pCopyDict; // copy修饰的dict
@property (nonatomic, strong) NSDictionary *pStrongDict; // strong修饰的dict

@end

@implementation CopyUsage

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    
    return self;
}

- (void)testCopyAndMutableCopy {
//    [self testNSStringCopy];
//    [self testNSMutableStringCopy];
    
    [self testNSArrayCopy];
//    [self testNSMutableArrayCopy];
    
//    [self testNSDictionaryCopy];
//    [self testNSMutableDictionaryCopy];
    /*
     心法：不到必须开辟新空间，编译器不会新开辟内存，能引用的就使用引用计数
     */
}

- (void)testNSStringCopy {
    NSLog(@"========NSString========");
    NSString *aStr = @"111";
    self.pCopyStr = aStr;
    /*
     (lldb) po aStr.class
     __NSCFConstantString

     (lldb) po aStr.superclass
     __NSCFString

     (lldb) po [aStr.superclass superclass]
     NSMutableString

     (lldb) po [[aStr.superclass superclass] superclass]
     NSString

     (lldb)
     */
    self.pStrongStr = aStr;
    NSString *aCopyStr = aStr.copy;
    NSMutableString *aMutableCopyStr = aStr.mutableCopy;
    NSLog(@"original str address:%p", aStr); // "_NSCFConstantString"
    NSLog(@"str by copy address:%p", aCopyStr); // "_NSCFConstantString"
    NSLog(@"str by mutableCopy address:%p", aMutableCopyStr); // "_NSCFString"
    NSLog(@"property str by copy address:%p", _pCopyStr); // "_NSCFConstantString"
    NSLog(@"property str by strong address:%p", _pStrongStr); // "_NSCFConstantString"
    /*
     2019-07-03 16:40:13.196722+0800 RuntimeLearning[58240:1958024] original str address:0x10d551fa0
     2019-07-03 16:40:13.196802+0800 RuntimeLearning[58240:1958024] str by copy address:0x10d551fa0
     2019-07-03 16:40:13.196875+0800 RuntimeLearning[58240:1958024] str by mutableCopy address:0x600000910030
     2019-07-03 16:40:13.196949+0800 RuntimeLearning[58240:1958024] property str by copy address:0x10d551fa0
     2019-07-03 16:40:13.197014+0800 RuntimeLearning[58240:1958024] property str by strong address:0x10d551fa0
     
     总结：对于不可变的字符串，copy strong都是引用指向同一块内存；mutableCopy会创建一个新的副本
     */
    NSLog(@"========NSString Changed========");
    aStr = @"222"; // 这里修改了aStr指针的指向
    NSLog(@"original str:%@ and address:%p", aStr, aStr);
    NSLog(@"str by copy:%@ and address:%p", aCopyStr, aCopyStr);
    NSLog(@"str by mutableCopy:%@ and address:%p", aMutableCopyStr, aMutableCopyStr);
    NSLog(@"property str by copy:%@ and address:%p", _pCopyStr, _pCopyStr);
    NSLog(@"property str by strong:%@ and address:%p", _pStrongStr, _pStrongStr);
    /*
     2019-07-03 16:40:18.596564+0800 RuntimeLearning[58240:1958024] original str:222 and address:0x10d552080
     2019-07-03 16:40:18.596627+0800 RuntimeLearning[58240:1958024] str by copy:111 and address:0x10d551fa0
     2019-07-03 16:40:18.596683+0800 RuntimeLearning[58240:1958024] str by mutableCopy:111 and address:0x600000910030
     2019-07-03 16:40:18.596770+0800 RuntimeLearning[58240:1958024] property str by copy:111 and address:0x10d551fa0
     2019-07-03 16:40:18.596850+0800 RuntimeLearning[58240:1958024] property str by strong:111 and address:0x10d551fa0
     */
}

- (void)testNSMutableStringCopy {
    NSLog(@"========NSMutableString========");
    NSMutableString *aStr = [[NSMutableString alloc] initWithString:@"111"];
    NSString *aCopyStr = aStr.copy;
    self.pCopyStr = aStr;
    self.pStrongStr = aStr;
    
    NSMutableString *aMutableCopyStr = aStr.mutableCopy;
    NSLog(@"original str address:%p", aStr); // __NSCFString
    NSLog(@"str by copy address:%p", aCopyStr); // NSTaggedPointerString
    NSLog(@"str by mutableCopy address:%p", aMutableCopyStr); // "_NSCFString"
    NSLog(@"property str by copy address:%p", _pCopyStr); // NSTaggedPointerString
    NSLog(@"property str by strong address:%p", _pStrongStr); // __NSCFString
    /*
     2019-07-03 16:40:21.124140+0800 RuntimeLearning[58240:1958024] original str address:0x600000914540
     2019-07-03 16:40:21.124224+0800 RuntimeLearning[58240:1958024] str by copy address:0x89d19d7a3ea43c1c
     2019-07-03 16:40:21.124293+0800 RuntimeLearning[58240:1958024] str by mutableCopy address:0x600000914420
     2019-07-03 16:40:21.124357+0800 RuntimeLearning[58240:1958024] property str by copy address:0x89d19d7a3ea43c1c
     2019-07-03 16:40:21.124429+0800 RuntimeLearning[58240:1958024] property str by strong address:0x600000914540
     总结：对于可变的字符串，copy和mutableCopy都会创建一个新的副本；strong修饰的属性则是引用
     */
    NSLog(@"========NSMutableString Changed========");
    [aStr appendString:@"222"];
    NSLog(@"original str:%@ and address:%p", aStr, aStr);
    NSLog(@"str by copy:%@ and address:%p", aCopyStr, aCopyStr);
    NSLog(@"str by mutableCopy:%@ and address:%p", aMutableCopyStr, aMutableCopyStr);
    NSLog(@"property str by copy:%@ and address:%p", _pCopyStr, _pCopyStr);
    NSLog(@"property str by strong:%@ and address:%p", _pStrongStr, _pStrongStr);
    /*
     2019-07-03 16:41:02.698996+0800 RuntimeLearning[58240:1958024] original str:111222 and address:0x600000914540
     2019-07-03 16:41:02.699106+0800 RuntimeLearning[58240:1958024] str by copy:111 and address:0x89d19d7a3ea43c1c
     2019-07-03 16:41:02.699185+0800 RuntimeLearning[58240:1958024] str by mutableCopy:111 and address:0x600000914420
     2019-07-03 16:41:02.699257+0800 RuntimeLearning[58240:1958024] property str by copy:111 and address:0x89d19d7a3ea43c1c
     2019-07-03 16:41:02.699333+0800 RuntimeLearning[58240:1958024] property str by strong:111222 and address:0x600000914540
     总结：如果原对象修改了，那么strong修饰的也就变了，这也是为什么我们在定义不可变字符串属性如果我们不希望原字符串变了产生影响而使用copy的原因
     */
}

- (void)testNSArrayCopy {
    NSLog(@"========NSArray========");
    TestObj *obj1 = [TestObj new];
    obj1.name = @"111";
    TestObj *obj0 = [TestObj new];
    obj0.name = @"111";
    NSArray *aArray = [[NSArray alloc] initWithObjects:obj0, obj1, nil];
    NSArray *aCopyArray = aArray.copy;
    NSMutableArray *aMutableCopyArray = aArray.mutableCopy;
    /*
     (lldb) po aArray.class
     __NSArrayI

     (lldb) po aArray.superclass
     NSArray

     (lldb) po [aArray.superclass superclass]
     NSObject
     
     (lldb) po aCopyArray.class
     __NSArrayI

     (lldb) po aMutableCopyArray.class
     __NSArrayM

     (lldb) po [aMutableCopyArray.class superclass]
     NSMutableArray

     (lldb) po [[aMutableCopyArray.class superclass] superclass]
     NSArray

     (lldb) po [[[aMutableCopyArray.class superclass] superclass] superclass]
     NSObject

     (lldb)
     */
    self.pCopyArray = aArray;
    self.pStrongArray = aArray;
    NSLog(@"original array:%@ and address:%p", aArray, aArray);
    NSLog(@"array by copy:%@ and address:%p", aCopyArray, aCopyArray);
    NSLog(@"array by mutableCopy:%@ and address:%p", aMutableCopyArray, aMutableCopyArray);
    NSLog(@"property array by copy:%@ and address:%p", _pCopyArray, _pCopyArray);
    NSLog(@"property array by strong:%@ and address:%p", _pStrongArray, _pStrongArray);
    /*
     2019-07-04 15:51:34.060634+0800 RuntimeLearning[10159:2611061] original array:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     2019-07-04 15:51:34.060746+0800 RuntimeLearning[10159:2611061] array by copy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     2019-07-04 15:51:34.060861+0800 RuntimeLearning[10159:2611061] array by mutableCopy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x600000dfd5c0
     2019-07-04 15:51:34.060944+0800 RuntimeLearning[10159:2611061] property array by copy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     2019-07-04 15:51:34.061017+0800 RuntimeLearning[10159:2611061] property array by strong:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     总结：对于不可变数组的copy和strong都是引用；mutableCopy会新开辟空间，但是数组内部的对象还是引用，所以如果改变数组中元素的属性，copy、strong、mutableCopy修饰的也会跟着变
     */
    NSLog(@"========NSArray Changed========");
    aArray = [[NSArray alloc] initWithObjects:[NSObject new], nil];
    NSLog(@"original array:%@ and address:%p", aArray, aArray);
    NSLog(@"array by copy:%@ and address:%p", aCopyArray, aCopyArray);
    NSLog(@"array by mutableCopy:%@ and address:%p", aMutableCopyArray, aMutableCopyArray);
    NSLog(@"property array by copy:%@ and address:%p", _pCopyArray, _pCopyArray);
    NSLog(@"property array by strong:%@ and address:%p", _pStrongArray, _pStrongArray);
    /*
     2019-07-04 15:51:34.061164+0800 RuntimeLearning[10159:2611061] original array:(
     "<NSObject: 0x6000001f41c0>"
     ) and address:0x6000001f41e0
     2019-07-04 15:51:34.074807+0800 RuntimeLearning[10159:2611061] array by copy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     2019-07-04 15:51:34.074933+0800 RuntimeLearning[10159:2611061] array by mutableCopy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x600000dfd5c0
     2019-07-04 15:51:34.075018+0800 RuntimeLearning[10159:2611061] property array by copy:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     2019-07-04 15:51:35.212313+0800 RuntimeLearning[10159:2611061] property array by strong:(
     "<NSObject: 0x6000001f80c0>",
     "<NSObject: 0x6000001f80a0>"
     ) and address:0x6000003fe2a0
     */
    NSLog(@"========NSArray element Changed========");
    obj1.name = @"222";
    NSLog(@"original array:%@ and address:%p", aArray, aArray);
    NSLog(@"array by copy:%@ and address:%p", aCopyArray, aCopyArray);
    NSLog(@"array by mutableCopy:%@ and address:%p", aMutableCopyArray, aMutableCopyArray);
    NSLog(@"property array by copy:%@ and address:%p", _pCopyArray, _pCopyArray);
    NSLog(@"property array by strong:%@ and address:%p", _pStrongArray, _pStrongArray);
    
    /*
     总结：针对NSArray类型的属性是使用strong还是copy修饰；取决于场景，数组内部元素是引用，所以也是无法保证完全不可变，如果你希望你的数组是NSArray对象而不是其子类NSMutableArray对象，那么用copy，否则使用strong
     */
}

- (void)testNSMutableArrayCopy {
    NSLog(@"========NSMutableArray========");
    TestObj *obj1 = [TestObj new];
    obj1.name = @"111";
    TestObj *obj0 = [TestObj new];
    obj0.name = @"111";
    NSMutableArray *aArray = [[NSMutableArray alloc] initWithObjects:obj0, obj1, nil];
    NSArray *aCopyArray = aArray.copy;
    NSMutableArray *aMutableCopyArray = aArray.mutableCopy;
    self.pCopyArray = aArray;
    self.pStrongArray = aArray;
    NSLog(@"original array:%@ and address:%p", aArray, aArray);
    NSLog(@"array by copy:%@ and address:%p", aCopyArray, aCopyArray);
    NSLog(@"array by mutableCopy:%@ and address:%p", aMutableCopyArray, aMutableCopyArray);
    NSLog(@"property array by copy:%@ and address:%p", _pCopyArray, _pCopyArray);
    NSLog(@"property array by strong:%@ and address:%p", _pStrongArray, _pStrongArray);
    /*
     2019-07-04 15:57:25.663040+0800 RuntimeLearning[10290:2618951] original array:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002c1c000
     2019-07-04 15:57:25.663156+0800 RuntimeLearning[10290:2618951] array by copy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002276f40
     2019-07-04 15:57:25.663247+0800 RuntimeLearning[10290:2618951] array by mutableCopy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002c1c810
     2019-07-04 15:57:25.663320+0800 RuntimeLearning[10290:2618951] property array by copy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002277260
     2019-07-04 15:57:25.663388+0800 RuntimeLearning[10290:2618951] property array by strong:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002c1c000
     总结：对于可变数组的copy和mutableCopy都会开辟新空间，区别是副本不可变和可变；strong是引用，但是数组内部的对象还是引用
     */
    NSLog(@"========NSMutableArray Changed========");
    [aArray addObject:[TestObj new]];
    obj1.name = @"222";
    NSLog(@"original array:%@ and address:%p", aArray, aArray);
    NSLog(@"array by copy:%@ and address:%p", aCopyArray, aCopyArray);
    NSLog(@"array by mutableCopy:%@ and address:%p", aMutableCopyArray, aMutableCopyArray);
    NSLog(@"property array by copy:%@ and address:%p", _pCopyArray, _pCopyArray);
    NSLog(@"property array by strong:%@ and address:%p", _pStrongArray, _pStrongArray);
    /*
     2019-07-04 15:57:25.663511+0800 RuntimeLearning[10290:2618951] original array:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>",
     "<NSObject: 0x60000206a3c0>"
     ) and address:0x600002c1c000
     2019-07-04 15:57:25.678074+0800 RuntimeLearning[10290:2618951] array by copy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002276f40
     2019-07-04 15:57:25.678182+0800 RuntimeLearning[10290:2618951] array by mutableCopy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002c1c810
     2019-07-04 15:57:25.678278+0800 RuntimeLearning[10290:2618951] property array by copy:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>"
     ) and address:0x600002277260
     2019-07-04 15:57:26.406277+0800 RuntimeLearning[10290:2618951] property array by strong:(
     "<NSObject: 0x60000206a490>",
     "<NSObject: 0x60000206a330>",
     "<NSObject: 0x60000206a3c0>"
     ) and address:0x600002c1c000
     总结：strong修饰的数组，当将可变数组赋给它时，当发生变化时，strong修饰的对象也变化了；当修改可变数组的其中某个对象的属性时，由于内部元素是引用，所以也会跟着变化
     */
}

- (void)testNSDictionaryCopy {
    NSLog(@"========NSDictionary========");
    TestObj *obj1 = [TestObj new];
    obj1.name = @"111";
    NSDictionary *aDict = [NSDictionary dictionaryWithObjectsAndKeys:obj1, @"obj1", nil];
    NSDictionary *aCopyDict = aDict.copy;
    NSMutableDictionary *aMutableCopyDict = aDict.mutableCopy;
    self.pCopyDict = aDict;
    self.pStrongDict = aDict;
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-05 16:01:11.194734+0800 RuntimeLearning[35716:3257134] original dict:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.194825+0800 RuntimeLearning[35716:3257134] dict by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.194955+0800 RuntimeLearning[35716:3257134] dict by mutableCopy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000026c8140
     2019-07-05 16:01:11.195036+0800 RuntimeLearning[35716:3257134] property dict by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.195105+0800 RuntimeLearning[35716:3257134] property dict by strong:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     */
    NSLog(@"========NSDictionary element changed========");
    obj1.name = @"222";
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-05 16:01:11.195239+0800 RuntimeLearning[35716:3257134] original dict:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.195305+0800 RuntimeLearning[35716:3257134] dict by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.195375+0800 RuntimeLearning[35716:3257134] dict by mutableCopy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000026c8140
     2019-07-05 16:01:11.202206+0800 RuntimeLearning[35716:3257134] property dict by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:01:11.202290+0800 RuntimeLearning[35716:3257134] property dict by strong:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     */
    NSLog(@"========NSDictionary changed========");
    TestObj *obj0 = [TestObj new];
    obj0.name = @"111";
    aDict = [NSDictionary dictionaryWithObjectsAndKeys:obj0, @"obj0", nil];
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-05 16:02:26.560404+0800 RuntimeLearning[35716:3257134] original dict:{
     obj0 = "<TestObj: 0x600002490480>";
     } and address:0x6000033e7040
     2019-07-05 16:02:26.560504+0800 RuntimeLearning[35716:3257134] array by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:02:26.560598+0800 RuntimeLearning[35716:3257134] array by mutableCopy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000026c8140
     2019-07-05 16:02:26.560686+0800 RuntimeLearning[35716:3257134] property array by copy:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     2019-07-05 16:02:26.560756+0800 RuntimeLearning[35716:3257134] property array by strong:{
     obj1 = "<TestObj: 0x600002490450>";
     } and address:0x6000033e6fc0
     总结：对于不可变字典，copy和strong都是引用；mutableCopy会新开辟空间，但是字典内部的对象还是引用，所以如果改变字典中元素的属性，copy、strong、mutableCopy修饰的也会跟着变
     */
}

- (void)testNSMutableDictionaryCopy {
    NSLog(@"========NSMutableDictionary========");
    TestObj *obj1 = [TestObj new];
    obj1.name = @"111";
    NSMutableDictionary *aDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:obj1, @"obj1", nil];
    NSDictionary *aCopyDict = aDict.copy;
    NSMutableDictionary *aMutableCopyDict = aDict.mutableCopy;
    self.pCopyDict = aDict;
    self.pStrongDict = aDict;
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-08 09:44:14.803063+0800 RuntimeLearning[88506:4441532] original dict:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     2019-07-08 09:44:14.803202+0800 RuntimeLearning[88506:4441532] dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c960
     2019-07-08 09:44:14.803295+0800 RuntimeLearning[88506:4441532] dict by mutableCopy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c860
     2019-07-08 09:44:14.803380+0800 RuntimeLearning[88506:4441532] property dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c880
     2019-07-08 09:44:14.803461+0800 RuntimeLearning[88506:4441532] property dict by strong:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     总结：对于可变字典，进行copy、mutableCopy都会开辟新的内存，区别在于copy之后生成的是_NSFrozenDictionaryM实例是不可变的，mutableCopy生成的是_NSDictionaryM是可变的副本，strong修饰的是直接引用；同时字典内部的元素的value都是引用的，key是copy的
     */
    NSLog(@"========NSMutableDictionary element changed========");
    obj1.name = @"222";
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-08 09:44:14.803599+0800 RuntimeLearning[88506:4441532] original dict:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     2019-07-08 09:44:14.819818+0800 RuntimeLearning[88506:4441532] dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c960
     2019-07-08 09:44:14.819939+0800 RuntimeLearning[88506:4441532] dict by mutableCopy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c860
     2019-07-08 09:44:14.820022+0800 RuntimeLearning[88506:4441532] property dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c880
     2019-07-08 09:44:14.820098+0800 RuntimeLearning[88506:4441532] property dict by strong:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     */
    NSLog(@"========NSMutableDictionary changed========");
    TestObj *obj0 = [TestObj new];
    obj0.name = @"111";
    [aDict setObject:obj0 forKey:@"obj0"];
    NSLog(@"original dict:%@ and address:%p", aDict, aDict);
    NSLog(@"dict by copy:%@ and address:%p", aCopyDict, aCopyDict);
    NSLog(@"dict by mutableCopy:%@ and address:%p", aMutableCopyDict, aMutableCopyDict);
    NSLog(@"property dict by copy:%@ and address:%p", _pCopyDict, _pCopyDict);
    NSLog(@"property dict by strong:%@ and address:%p", _pStrongDict, _pStrongDict);
    /*
     2019-07-08 09:45:52.201509+0800 RuntimeLearning[88506:4441532] original dict:{
     obj0 = "<TestObj: 0x6000038caba0>";
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     2019-07-08 09:45:52.201599+0800 RuntimeLearning[88506:4441532] dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c960
     2019-07-08 09:45:52.201681+0800 RuntimeLearning[88506:4441532] dict by mutableCopy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c860
     2019-07-08 09:45:52.201744+0800 RuntimeLearning[88506:4441532] property dict by copy:{
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c880
     2019-07-08 09:45:57.505842+0800 RuntimeLearning[88506:4441532] property dict by strong:{
     obj0 = "<TestObj: 0x6000038caba0>";
     obj1 = "<TestObj: 0x6000038d8310>";
     } and address:0x600003a9c900
     */
}

@end


@implementation TestObj


@end
