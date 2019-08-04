//
//  NSString+AGViewModel.h
//
//
//  Created by JohnnyB0Y on 2017/7/31.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  字符串计算分类

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AGViewModel)

/** 字符串不为 @""、nil时，为 YES */
@property (nonatomic, assign, readonly, getter=isNotEmpty) BOOL notEmpty;

/** 计算文字 size */
- (CGSize) ag_sizeOfFont:(UIFont *)font maxSize:(CGSize)maxS;
- (CGSize) ag_sizeOfFontSize:(CGFloat)fontSize maxSize:(CGSize)maxS;

@end

NS_ASSUME_NONNULL_END
