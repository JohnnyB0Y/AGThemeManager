//
//  UIColor+AGExtensions.h
//
//
//  Created by JohnnyB0Y on 15/12/2.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//  颜色拓展

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (AGExtensions)

+ (UIColor *) ag_randomColor;

+ (UIColor *) ag_colorWithHex:(NSString *)hex;

+ (UIColor *) ag_colorWithHex:(NSString *)hex alpha:(CGFloat)alpha;

- (UIImage *) ag_colorImage;

@end

FOUNDATION_EXTERN UIColor * ag_newRGBColor(CGFloat r, CGFloat g, CGFloat b);
FOUNDATION_EXTERN UIColor * ag_newRGBAColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
FOUNDATION_EXTERN UIColor * ag_newHexColor(NSString *hexString);
FOUNDATION_EXTERN UIColor * ag_newHexColorWithAlpha(NSString *hexString, CGFloat alpha);
FOUNDATION_EXTERN UIColor * ag_newRandomColor(void);

NS_ASSUME_NONNULL_END
