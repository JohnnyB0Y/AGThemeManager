//
//  UIColor+AGExtensions.m
// 
//
//  Created by JohnnyB0Y on 15/12/2.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//

#import "UIColor+AGExtensions.h"
#import "UIImage+AGGenerate.h"

@implementation UIColor (AGExtensions)

+ (UIColor *) ag_randomColor
{
    return ag_newRandomColor();
}

+ (UIColor *) ag_colorWithHex:(NSString *)hex
{
    return ag_newHexColor(hex);
}

- (UIImage *)ag_colorImage
{
    return [UIImage ag_imageWithColor:self size:CGSizeZero];
}

@end


UIColor * ag_newRGBColor(CGFloat r, CGFloat g, CGFloat b)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f];
}

UIColor * ag_newRGBAColor(CGFloat r, CGFloat g, CGFloat b, CGFloat a)
{
    return [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)];
}

UIColor * ag_newRandomColor(void)
{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

UIColor * ag_newHexColor(NSString *hexString)
{
    NSString *colorStr = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([colorStr length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([colorStr hasPrefix:@"0X"])
        colorStr = [colorStr substringFromIndex:2];
    if ([colorStr hasPrefix:@"#"])
        colorStr = [colorStr substringFromIndex:1];
    if ([colorStr length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rStr = [colorStr substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gStr = [colorStr substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bStr = [colorStr substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rStr] scanHexInt:&r];
    [[NSScanner scannerWithString:gStr] scanHexInt:&g];
    [[NSScanner scannerWithString:bStr] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}
