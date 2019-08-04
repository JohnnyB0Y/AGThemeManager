//
//  AGDataThemePack.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGDataThemePack.h"

@implementation AGDataThemePack

+ (instancetype)newWithThemePackData:(id)data
{
    return [[self alloc] initWithThemePackData:data];
}

- (instancetype)initWithThemePackData:(id)data
{
    self = [super initWithThemePackData:data];
    
    if ( self ) {
        // 主题包名称
        self.name = @"";
        
        // 添加元素
        
    }
    
    return self;
}

@end
