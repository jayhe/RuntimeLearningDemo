//
//  TestCode.m
//  RuntimeLearning
//
//  Created by hechao on 2019/9/19.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "TestCode.h"

auto f=[](int a,int b){return a>b;}; // Lambda

typedef struct  Obs {
    id        observer;   /* Object to receive message.   */
    int       retained;
    Obs() {
        NSLog(@"Obs Constructor");
    };
    ~Obs() {
        NSLog(@"Obs Destructor");
    };
} Observation;

@implementation TestCode

- (void)dealloc {
    //[super dealloc]; // -fno-objc-arc
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self test];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(testNotification:) name:@"TEST" object:nil];
    }
    
    return self;
}

- (void)testNotification:(NSNotification *)notification {
    
}

/*
 從 top-down 的角度分析，是 Objective-C++ 需要考慮 ObjC 指針在 ARC 下的 ownership 的問題。用 __strong 和 __weak 的 ObjC 指針作爲 C++ 對象的成員將導致編譯器在爲這個 C++ 對象生成 destructor 時考慮注入這個 ObjC 指針的生命週期管理代碼。__strong 很好理解，如果我們不置 nil，那麼就會造成泄漏；__weak 的話則是 C++ 對象消失後在 side table 內的 weak 指針地址也應該被清除。這種行爲將導致這個 C++ 類型從 POD 變成 non-POD，我們可以用 std::is_pod 模板函數進行驗證。這裏面唯一的例外就是 __unsafe_retained 的 ObjC 指針。
 
 void
 objc_storeStrong(id *location, id obj)
 {
     id prev = *location;
     if (obj == prev) {
         return;
     }
     objc_retain(obj);
     *location = obj;
     objc_release(prev);
 }
 */
- (void)test {
    NSLog(@"TestCode.retaincount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
    Observation *obs = new Obs(); // malloc(sizeof(Observation))
//    obs->retained = 0;
    obs->observer = self;
    NSLog(@"TestCode.retaincount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(self)));
    delete obs;
    /*
     2019-09-19 09:57:41.229922+0800 RuntimeLearning[99635:3579888] 1
     2019-09-19 09:57:44.509753+0800 RuntimeLearning[99635:3579888] 1
     */
}

@end
