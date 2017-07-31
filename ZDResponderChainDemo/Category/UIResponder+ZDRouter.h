//
//  UIResponder+ZDRouter.h
//  ZDResponderTestDemo
//
//  Created by Zero.D.Saber on 2017/7/27.
//  Copyright © 2017年 Zero.D.Saber. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIResponder (ZDRouter)

- (void)deliverEventWithName:(NSString *)eventName
                  parameters:(NSDictionary *_Nullable)paramsDict;

@end

NS_ASSUME_NONNULL_END
