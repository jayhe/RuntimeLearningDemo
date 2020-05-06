//
//  KeychainUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/5/6.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "KeychainUsage.h"
#import <Security/Security.h>
#import <fishhook/fishhook.h>

OSStatus (*System_SecItemCopyMatching)(CFDictionaryRef query, CFTypeRef * __nullable CF_RETURNS_RETAINED result);

@interface KeychainUsage ()

@property (nonatomic, copy) NSString *service;
@property (nonatomic, nullable, copy) NSString *accessGroup;

@end

@implementation KeychainUsage

- (instancetype)initWithService:(NSString *)service {
    return [self initWithService:service accessGroup:nil];
}

- (instancetype)initWithService:(NSString *)service accessGroup:(NSString *)accessGroup {
    self = [super init];
    if (self) {
        _service = service;
        _accessGroup = accessGroup;
    }
    
    return self;
}

- (BOOL)insertItem:(NSString *)value forKey:(NSString *)key {
    id result = [self queryItemByKey:key];
    if (result == nil) {
        return [self _insertItem:value forKey:key];
    } else {
        return [self updateItem:value forKey:key];
    }
}

- (nullable id)queryItemByKey:(NSString *)key {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query addEntriesFromDictionary:[self commonParams]];
    query[(__bridge id)kSecMatchLimit] = (__bridge id)kSecMatchLimitAll;
    query[(__bridge id)kSecReturnAttributes] = @YES;
    query[(__bridge id)kSecReturnData] = @YES;
    query[(__bridge id)kSecAttrAccount] = key;
    query[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleAlways;
    
    CFTypeRef result = NULL;
    OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)query, &result);
    // -50 errSecParam
    // -25300 errSecItemNotFound
    // -34018 errSecMissingEntitlement 设置了accessGroup则需要
    if (status != errSecSuccess) {
        return nil;
    } else {
        NSDictionary *resultDict;
        if (CFGetTypeID(result) == CFDictionaryGetTypeID()) {
            resultDict = (__bridge NSDictionary *)result;
        } else if (CFGetTypeID(result) == CFArrayGetTypeID()) {
            NSArray *tmpArray = (__bridge NSArray *)result;
            resultDict = [tmpArray.firstObject isKindOfClass:[NSDictionary class]] ? tmpArray.firstObject : nil;
        } else {
            resultDict = nil;
        }
        NSString *pwd = [[NSString alloc] initWithData:resultDict[(__bridge id)kSecValueData] encoding:NSUTF8StringEncoding];
        
        return pwd;
    }
}

- (BOOL)updateItem:(NSString *)value forKey:(NSString *)key {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query addEntriesFromDictionary:[self commonParams]];
    query[(__bridge id)kSecAttrAccount] = key;
    NSMutableDictionary *updateDict = [NSMutableDictionary dictionary];
    //updateDict[(__bridge id)kSecAttrService] = self.service;
    updateDict[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
    OSStatus status = SecItemUpdate((__bridge CFDictionaryRef)query, (__bridge CFDictionaryRef)updateDict);
    // -25303 errSecNoSuchAttr
    if (status != errSecSuccess) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)deleteItemByKey:(NSString *)key {
    NSMutableDictionary *query = [NSMutableDictionary dictionary];
    [query addEntriesFromDictionary:[self commonParams]];
    query[(__bridge id)kSecAttrAccount] = key;
    OSStatus status = SecItemDelete((__bridge CFDictionaryRef)query);
    if (status != errSecSuccess) {
        return NO;
    } else {
        return YES;
    }
}

- (BOOL)_insertItem:(NSString *)value forKey:(NSString *)key {
    BOOL isSuccess;
    NSMutableDictionary *query = [[NSMutableDictionary alloc] init];
    [query addEntriesFromDictionary:[self commonParams]];
    query[(__bridge id)kSecAttrAccessible] = (__bridge id)kSecAttrAccessibleAlways;
    query[(__bridge id)kSecAttrAccount] = key;
    query[(__bridge id)kSecValueData] = [value dataUsingEncoding:NSUTF8StringEncoding];
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)query, NULL);
    // -25299 errSecDuplicateItem
    if (status != errSecSuccess) {
        isSuccess = NO;
    } else {
        isSuccess = YES;
    }
    
    return isSuccess;
}

- (NSDictionary *)commonParams {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    if (self.service.length) {
        dict[(__bridge id)kSecAttrService] = self.service;
    }
    if (self.accessGroup.length) {
        dict[(__bridge id)kSecAttrAccessGroup] = self.accessGroup;
    }
    dict[(__bridge id)kSecClass] = (__bridge id)kSecClassGenericPassword;
    
    return dict.copy;
}

- (void)testKeychainUsage {
    NSString *account = @"jayhe";
    BOOL insertStatus = [self insertItem:@"111111" forKey:account];
    if (insertStatus) {
        NSString *pwd = [self queryItemByKey:account];
        NSLog(@"pwd = %@", pwd);
    }
    BOOL updateStatus = [self updateItem:@"222222" forKey:account];
    if (updateStatus) {
        NSString *pwdAfterUpdated = [self queryItemByKey:account];
        NSLog(@"pwdAfterUpdated = %@", pwdAfterUpdated);
    }
    BOOL deleteStatus = [self deleteItemByKey:account];
    if (deleteStatus) {
        NSString *pwdAfterDeleted = [self queryItemByKey:account];
        NSLog(@"pwdAfterDeleted = %@", pwdAfterDeleted);
    }
}

- (void)hookSystemQuery {
    struct rebinding aRebinding = {};
    aRebinding.name = "SecItemCopyMatching";
    aRebinding.replacement = (void *)Mine_SecItemCopyMatching;
    aRebinding.replaced = (void **)&System_SecItemCopyMatching;
    struct rebinding rebindings[] = {aRebinding};
    rebind_symbols(rebindings, 1);
}

static OSStatus Mine_SecItemCopyMatching(CFDictionaryRef query, CFTypeRef * __nullable CF_RETURNS_RETAINED result) {
    NSDictionary *queryDict = (__bridge NSDictionary *)query;
    NSLog(@"queryDict = %@", queryDict);
    return System_SecItemCopyMatching(query, result);
}

@end
