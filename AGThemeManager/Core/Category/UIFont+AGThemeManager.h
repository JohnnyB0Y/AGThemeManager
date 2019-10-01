//
//  UIFont+AGThemeManager.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIFont (AGThemeManager)


/// 获取当前主题字体
/// @param key 键
+ (nullable UIFont *)ag_themeForKey:(NSString *)key;


/// 获取当前主题系统动态字体(根据系统字体大小变化)
/// @param key 键
+ (nullable UIFont *)ag_themeWithFontTextStyleForKey:(NSString *)key;


/// 获取当前主题 UIFontTextStyle
/// @param key 键
+ (nullable UIFontTextStyle)ag_themeFontTextStyleForKey:(NSString *)key;


/// 获取当前主题动态字体(根据系统字体大小变化)
/// @param key 键
+ (nullable UIFont *)ag_themeWithDynamicFontForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
