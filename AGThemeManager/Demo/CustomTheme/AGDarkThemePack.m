//
//  AGDarkThemePack.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/10/1.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//  黑暗模式

#import "AGDarkThemePack.h"

@implementation AGDarkThemePack

+ (instancetype)newWithPackName:(NSString *)name
{
    return [[self alloc] initWithPackName:name];
}

- (instancetype)initWithPackName:(NSString *)name
{
    self = [super initWithPackName:name];
    
    if ( self ) {
        // 添加元素
        [self setColor:[UIColor whiteColor] forKey:kAGThemePackHomeCellContentTextColor];
        [self setFont:[UIFont boldSystemFontOfSize:17] forKey:kAGThemePackHomeCellContentTextFont];
        [self setImageName:@"ic_share_timeline" forKey:kAGThemePackHomeCellIconImageName];
        
    }
    
    return self;
}

@end
