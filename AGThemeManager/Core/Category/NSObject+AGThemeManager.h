//
//  NSObject+AGThemeManager.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGThemeManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (AGThemeManager)

/** 配置 */
- (void)ag_setupThemeUsingBlock:(AGThemeConfigBlock)block;

/** 配置并执行 */
- (void)ag_setupAndExecuteThemeUsingBlock:(AGThemeConfigBlock)block;

/** 执行 */
- (void)ag_executeSetupThemeBlock;

/** 移除 */
- (void)ag_removeSetupThemeBlock;

@end

NS_ASSUME_NONNULL_END
