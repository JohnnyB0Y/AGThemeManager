//
//  AGVMNotifier.h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/9/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  

#import <Foundation/Foundation.h>
#import "AGVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGVMNotifier : NSObject
<AGVMObserverRegistration>

- (instancetype) initWithViewModel:(AGViewModel *)vm NS_DESIGNATED_INITIALIZER;
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
