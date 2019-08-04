//
//  AGOrangeThemePack.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGOrangeThemePack.h"
#import <UIKit/UIKit.h>

@implementation AGOrangeThemePack

+ (instancetype)newWithPackName:(NSString *)name
{
    return [[self alloc] initWithPackName:name];
}

- (instancetype)initWithPackName:(NSString *)name
{
    self = [super initWithPackName:name];
    
    if ( self ) {
        
        // 添加元素
        self[kAGThemePackHomeCellContentTextColor] = [UIColor orangeColor];
        self[kAGThemePackHomeCellContentTextFont] = [UIFont systemFontOfSize:10];
        self[kAGThemePackHomeCellIconImageName] = @"ic_share_weibo";
        
    }
    
    return self;
}

@end
