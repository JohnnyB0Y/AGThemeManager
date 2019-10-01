//
//  UIImage+AGThemeManager.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIImage+AGThemeManager.h"
#import "AGThemeKit.h"

@implementation UIImage (AGThemeManager)

/// 获取当前主题图片
/// @param key 键
+ (UIImage *)ag_themeForKey:(NSString *)key
{
    NSString *image = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [image isKindOfClass:[UIImage class]] ) {
        return (id)image;
    }
    else if ( [image isKindOfClass:[NSString class]] ) {
        return [UIImage imageNamed:image];
    }
    
    return nil;
}


/// 获取当前主题图片名
/// @param key 键
+ (NSString *)ag_themeImageNameForKey:(NSString *)key
{
    NSString *image = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [image isKindOfClass:[NSString class]] ) {
        return image;
    }
    
    return nil;
}


/// 获取当前主题图片
/// @param key 键
+ (UIImage *)ag_themeImageWithFilePathForKey:(NSString *)key
{
    NSString *path = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [path isKindOfClass:[NSString class]] ) {
        return [UIImage imageWithContentsOfFile:path];
    }
    else if ( [path isKindOfClass:[UIImage class]] ) {
        return (id)path;
    }
    
    return nil;
}


@end
