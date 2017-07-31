//
//  NSObject+ZDTools.h
//  ZDResponderChainDemo
//
//  Created by Zero.D.Saber on 2017/7/29.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (ZDTools)

// refer YYKit
- (id)zd_getReturnFromInvocation:(NSInvocation *)invocation
                    withSigature:(NSMethodSignature *)sig;

@end

NS_ASSUME_NONNULL_END
