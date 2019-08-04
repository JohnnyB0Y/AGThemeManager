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

- (UIImage *) ag_colorImage;

@end

UIColor * ag_newRGBColor(CGFloat r, CGFloat g, CGFloat b);
UIColor * ag_newRGBAColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a);
UIColor * ag_newHexColor(NSString *hexString);
UIColor * ag_newRandomColor(void);

NS_ASSUME_NONNULL_END
