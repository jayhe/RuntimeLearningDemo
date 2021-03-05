//
//  AttributeUsage.m
//  RuntimeLearning
//
//  Created by hechao on 2019/4/10.
//  Copyright © 2019 hechao. All rights reserved.
//

#import "AttributeUsage.h"
#import "RuntimeLearningMacro.h"

//@compatibility_alias

void unexcept(void) __attribute__ ((noreturn));

@interface AttributeUsage ()

@property (strong, nonatomic) NSLock *lock;

@end

@implementation AttributeUsage

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _lock = [NSLock new];
        [self testUsages];
    }
    
    return self;
}

- (void)testUsages {
    [self cleanupUsage];
    [self testNoReturn:NO];
}

#pragma mark - cleanup
//#define onExit \
//__strong void(^block)(void) __attribute__((cleanup(blockCleanUp), unused)) = ^ \

//static void blockCleanUp(__strong void(^*block)(void)) {
//    (*block)();
//}

- (void)cleanupUsage {
    //C++中的RAII机制
    [self.lock lock];
    onExit {
        [self.lock unlock];
    };
    // 做很多事情
    NSLog(@"%s", __FUNCTION__);
    return;
}

#pragma mark - constructor && destructor

__attribute__((constructor(2))) static void AttributeUsageConstructor1(void) {
    NSLog(@"Excute before main"); // 执行顺序 优先于main，在load之后；_objc_init中的static_init()是C++类的构造函数，这个是dyld在加载镜像之后，调用的
}

__attribute__((constructor(1))) static void AttributeUsageConstructor(void) {
    NSLog(@"Excute before main");
}

__attribute__((destructor)) static void AttributeUsageDestructor(void) {
    NSLog(@"Excute after main");
}

#pragma mark -

- (NSInteger)testNoReturn:(BOOL)aBool {
    if (aBool == NO) {
        return 0;
    } else {
        unexcept();
    }
}

void unexcept(void) {
    exit(1);
}

@end

/*
 * thread #1, queue = 'com.apple.main-thread', stop reason = breakpoint 79.1
     frame #0: 0x0000000101328b64 RuntimeLearning`AttributeUsageConstructor1 at AttributeUsage.m:65:5
   * frame #1: 0x000000010156d0e0 dyld`ImageLoaderMachO::doModInitFunctions(ImageLoader::LinkContext const&) + 412
     frame #2: 0x000000010156d314 dyld`ImageLoaderMachO::doInitialization(ImageLoader::LinkContext const&) + 36
     frame #3: 0x0000000101568398 dyld`ImageLoader::recursiveInitialization(ImageLoader::LinkContext const&, unsigned int, char const*, ImageLoader::InitializerTimingList&, ImageLoader::UninitedUpwards&) + 464
     frame #4: 0x00000001015673dc dyld`ImageLoader::processInitializers(ImageLoader::LinkContext const&, unsigned int, ImageLoader::InitializerTimingList&, ImageLoader::UninitedUpwards&) + 136
     frame #5: 0x0000000101567498 dyld`ImageLoader::runInitializers(ImageLoader::LinkContext const&, ImageLoader::InitializerTimingList&) + 84
     frame #6: 0x00000001015566d8 dyld`dyld::initializeMainExecutable() + 220
     frame #7: 0x000000010155b2a0 dyld`dyld::_main(macho_header const*, unsigned long, int, char const**, char const**, char const**, unsigned long*) + 4304
     frame #8: 0x0000000101555044 dyld`_dyld_start + 68
 */
