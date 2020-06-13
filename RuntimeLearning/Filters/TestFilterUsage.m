//
//  TestFilterUsage.m
//  RuntimeLearning
//
//  Created by 贺超 on 2020/6/12.
//  Copyright © 2020 hechao. All rights reserved.
//

#import "TestFilterUsage.h"
#import <CoreImage/CIFilter.h>

@implementation TestFilterUsage

- (void)logAllFilterNames {
    [[self filterCategories] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *filterNames = [CIFilter filterNamesInCategory:obj];
        NSLog(@"\n\n\n\n");
        NSLog(@"%@", filterNames);
        NSLog(@"\n\n\n\n");
    }];
}

- (NSArray<NSString *> *)filterCategories {
    return @[
        kCICategoryDistortionEffect,
        kCICategoryDistortionEffect,
        kCICategoryGeometryAdjustment,
        kCICategoryCompositeOperation,
        kCICategoryHalftoneEffect,
        kCICategoryColorAdjustment,
        kCICategoryColorEffect,
        kCICategoryTransition,
        kCICategoryTileEffect,
        kCICategoryGenerator,
        kCICategoryReduction,
        kCICategoryGradient,
        kCICategoryStylize,
        kCICategorySharpen,
        kCICategoryBlur,
        kCICategoryVideo,
        kCICategoryStillImage,
        kCICategoryInterlaced,
        kCICategoryNonSquarePixels,
        kCICategoryHighDynamicRange,
        kCICategoryBuiltIn,
        kCICategoryFilterGenerator
    ];
}

@end
