//
//  AGFileThemePack.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGFileThemePack.h"

@implementation AGFileThemePack

+ (instancetype)newWithContentOfFile:(NSString *)fileURL
{
    return [[self alloc] initWithContentOfFile:fileURL];
}

- (instancetype)initWithContentOfFile:(NSString *)fileURL
{
    self = [super initWithContentOfFile:fileURL];
    
    if ( self ) {
        self.name = [fileURL lastPathComponent];
        
        // 添加元素
        
    }
    
    return self;
}

@end
