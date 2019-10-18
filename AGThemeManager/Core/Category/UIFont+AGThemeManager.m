//
//  UIFont+AGThemeManager.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIFont+AGThemeManager.h"
#import "AGThemeKit.h"

@implementation UIFont (AGThemeManager)

+ (UIFont *)ag_themeForKey:(NSString *)key
{
    UIFont *font = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [font isKindOfClass:[UIFont class]] ) {
        return font;
    }
    
    return nil;
}

/// 获取当前主题系统动态字体(根据系统字体大小变化)
/// @param key 键
+ (UIFont *)ag_themeFontPreferredForKey:(NSString *)key
{
    UIFontTextStyle fontTextStyle = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    if ( [fontTextStyle isKindOfClass:[NSString class]] ) {
        return [UIFont preferredFontForTextStyle:fontTextStyle];
    }
    
    return nil;
}

/// 获取当前主题 UIFontTextStyle
/// @param key 键
+ (nullable UIFontTextStyle)ag_themeFontTextStyleForKey:(NSString *)key
{
    UIFontTextStyle fontTextStyle = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    if ( [fontTextStyle isKindOfClass:[NSString class]] ) {
        return fontTextStyle;
    }
    return nil;
}

+ (UIFont *)ag_themeFontDynamicForKey:(NSString *)key
{
    UIFont *font = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [font isKindOfClass:[UIFont class]] ) {
        if ( AGThemeManager.sharedInstance.openContentSizeChangeNotification ) {
            // 变化偏移
            NSInteger fontScaleSize = AGThemeManager.sharedInstance.fontScaleSize;
            NSInteger currentFontSize = font.pointSize + fontScaleSize;
            if ( currentFontSize != font.pointSize ) {
                return [UIFont fontWithDescriptor:font.fontDescriptor size:currentFontSize];
            }
        }
        return font;
    }
    
    return nil;
}

@end
