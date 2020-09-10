//
//  HCTestProtocolImp.h
//  RuntimeLearning
//
//  Created by 贺超 on 2020/9/9.
//  Copyright © 2020 hechao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HCTestProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface HCTestProtocolImp : NSObject <HCTestProtocol>

@end

@interface HCTestSubAProtocolImp : HCTestProtocolImp <HCModuleATestProtocol>

@end

@interface HCTestSubBProtocolImp : HCTestProtocolImp <HCModuleBTestProtocol>

@end

NS_ASSUME_NONNULL_END
