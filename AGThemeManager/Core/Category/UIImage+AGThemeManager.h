//
//  UIImage+AGThemeManager.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AGThemeManager)


/// 获取当前主题图片
/// @param key 键
+ (nullable UIImage *)ag_themeForKey:(NSString *)key;


/// 获取当前主题图片名
/// @param key 键
+ (nullable NSString *)ag_themeImageNameForKey:(NSString *)key;


/// 获取当前主题图片
/// @param key 键
+ (nullable UIImage *)ag_themeImageWithFilePathForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
