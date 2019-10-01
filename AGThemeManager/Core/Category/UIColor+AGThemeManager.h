//
//  UIColor+AGThemeManager.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AGThemeManager)


/// 取出当前主题的颜色
/// @param key 键
+ (nullable UIColor *)ag_themeForKey:(NSString *)key;


/// 取出当前主题的颜色
/// @param key 键
+ (nullable UIColor *)ag_themeWithColorNameForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
