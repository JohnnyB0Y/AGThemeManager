//
//  AGBlueThemePack.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGBlueThemePack.h"
#import <UIKit/UIKit.h>

@implementation AGBlueThemePack

+ (instancetype)newWithPackName:(NSString *)name
{
    return [[self alloc] initWithPackName:name];
}

- (instancetype)initWithPackName:(NSString *)name
{
    self = [super initWithPackName:name];
    
    if ( self ) {
        
        // 添加元素
        self[kAGThemePackHomeCellContentTextColor] = [UIColor blueColor];
        self[kAGThemePackHomeCellContentTextFont] = [UIFont systemFontOfSize:20];
        self[kAGThemePackHomeCellIconImageName] = @"ic_share_qq";
    }
    
    return self;
}

@end
