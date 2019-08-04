//
//  NSString+AGViewModel.m
//
//
//  Created by JohnnyB0Y on 2017/7/31.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  字符串计算分类

#import "NSString+AGViewModel.h"

@implementation NSString (AGViewModel)

- (CGSize) ag_sizeOfFont:(UIFont *)font maxSize:(CGSize)maxS
{
    if ( self.length <= 0 ) return CGSizeZero;
    
    CGSize textS = [self boundingRectWithSize:maxS
                                      options:(NSStringDrawingUsesLineFragmentOrigin |
                                               NSStringDrawingUsesFontLeading)
                                   attributes:@{NSFontAttributeName : font}
                                      context:nil].size;
    textS.width = ceilf(textS.width);
    textS.height = ceilf(textS.height);
    return textS;
}

- (CGSize) ag_sizeOfFontSize:(CGFloat)fontSize maxSize:(CGSize)maxS
{
    if ( self.length <= 0 ) return CGSizeZero;
    
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    return [self ag_sizeOfFont:font maxSize:maxS];
}

- (BOOL)isNotEmpty
{
    return self.length > 0;
}

@end

