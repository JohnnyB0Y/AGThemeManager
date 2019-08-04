//
//  AGPurpleThemePack.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGPurpleThemePack.h"
#import <UIKit/UIKit.h>

@implementation AGPurpleThemePack

+ (instancetype)newWithPackName:(NSString *)name
{
    return [[self alloc] initWithPackName:name];
}

- (instancetype)initWithPackName:(NSString *)name
{
    self = [super initWithPackName:name];
    
    if ( self ) {
        
        // 添加元素
        self[kAGThemePackHomeCellContentTextColor] = [UIColor purpleColor];
        self[kAGThemePackHomeCellContentTextFont] = [UIFont systemFontOfSize:30];
        self[kAGThemePackHomeCellIconImageName] = @"purple";
        
    }
    
    return self;
}

@end
