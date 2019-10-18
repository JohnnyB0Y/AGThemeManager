//
//  UIColor+AGThemeManager.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIColor+AGThemeManager.h"
#import "AGThemeKit.h"

@implementation UIColor (AGThemeManager)

+ (UIColor *)ag_themeForKey:(NSString *)key
{
    UIColor *color = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [color isKindOfClass:[UIColor class]] ) {
        return color;
    }
    
    return nil;
}

/// 取出当前主题的颜色
/// @param key 键
+ (nullable UIColor *)ag_themeColorNamedForKey:(NSString *)key
{
    NSString *colorName = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    
    if ( [colorName isKindOfClass:[NSString class]] ) {
        if (@available(iOS 11.0, *)) {
            return [UIColor colorNamed:colorName];
        }
    }
    if ( [colorName isKindOfClass:[UIColor class]] ) {
        return (id)colorName;
    }
    
    return nil;
}

@end
