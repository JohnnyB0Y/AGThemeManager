//
//  UIImage+AGGenerate.m
//  
//
//  Created by JohnnyB0Y on 15/10/26.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//  图片生成

#import "UIImage+AGGenerate.h"

@implementation UIImage (AGGenerate)

- (NSData *)ag_dataByCompressionMaxLimitKByte:(NSInteger)length
{
    return [self ag_dataByCompressionMaxLimitKByte:length quality:1.0];
}

/** JPEG压缩图片，最大不超过length ( kb ) ，压缩比例 compressionQuality */
- (NSData *) ag_dataByCompressionMaxLimitKByte:(NSInteger)length quality:(CGFloat)quality
{
    NSData *data = UIImageJPEGRepresentation(self, quality);
    CGFloat currentQuality = quality - 0.1;
    
    if ( ( data.length / 1024 < length ) || ( currentQuality <= 0 ) ) {
        
        return data;
    }
    
    return [self ag_dataByCompressionMaxLimitKByte:length quality:currentQuality];
}

- (NSString *) ag_base64EncodedStringByCompressionMaxLimitKByte:(NSInteger)length
{
    NSData *data = [self ag_dataByCompressionMaxLimitKByte:length];
    return [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark 图片渲染模式
+ (UIImage *) ag_imageRenderingModeAlwaysOriginal:(NSString *)name
{
    return [self ag_imageName:name renderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (UIImage *) ag_imageName:(NSString *)name renderingMode:(UIImageRenderingMode)mode
{
    return [[self imageNamed:name] imageWithRenderingMode:mode];
}

- (UIImage *) ag_imageRenderingModeAlwaysOriginal
{
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (UIImage *) ag_imageByClipCorner:(CGFloat)radius
{
    return [self ag_imageByClipCorner:UIRectCornerAllCorners radius:radius];
}

- (UIImage *) ag_imageByClipCorner:(UIRectCorner)corner radius:(CGFloat)radius
{
    // 开启上下文
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置裁剪区域
    CGSize radii = CGSizeMake(radius, radius);
    CGRect roundedRect = CGRectMake(0, 0, imageW, imageH);
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:roundedRect
                                                byRoundingCorners:corner
                                                      cornerRadii:radii];
    // 裁剪圆角
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    
    // 将照片画到上下文
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, roundedRect);
    // 翻转图片
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeTranslation(0.0, imageH);
    transform = CGAffineTransformScale(transform, 1.0, -1.0);
    CGContextConcatCTM(ctx, transform);
    // 绘制
    CGContextDrawImage(ctx, roundedRect, imageRef);
    
    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文并释放资源
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    
    return newImage;
}

/** 切圆 */
- (UIImage *) ag_imageByClipCircle {
    // 开启上下文
    CGFloat imageW = self.size.width;
    CGFloat imageH = self.size.height;
    CGFloat minSide = MIN(imageW, imageH);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(minSide, minSide), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 圈一个圆
    CGRect circleR = CGRectMake(0, 0, minSide, minSide);
    CGContextAddEllipseInRect(ctx, circleR);
    CGContextClip(ctx);
    
    // 将裁剪后的照片画到图形上下文
    CGRect imageR = CGRectMake((imageW - minSide) * 0.5, (imageH - minSide) * 0.5, minSide, minSide);
    CGImageRef imageRef = CGImageCreateWithImageInRect(self.CGImage, imageR);
    // 翻转图片
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformMakeTranslation(0.0, minSide);
    transform = CGAffineTransformScale(transform, 1.0, -1.0);
    CGContextConcatCTM(ctx, transform);
    // 绘制
    CGContextDrawImage(ctx, circleR, imageRef);

    // 从上下文上获取剪裁后的照片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 关闭上下文并释放资源
    UIGraphicsEndImageContext();
    CGImageRelease(imageRef);
    
    return newImage;
}

/**
 *  生成二维码
 */
+ (UIImage *) ag_imageWithQRCode:(NSString *)qrStr side:(CGFloat)side
{
    // 创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 给过滤器添加数据，注意！这里的value必须是NSData类型
    NSData *data = [qrStr dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    
    // 生成二维码
    CGSize size = CGSizeMake(side, side);
    return [self ag_imageWithCIImage:filter.outputImage quality:kCGInterpolationNone size:size];
}

/**
 根据CIImage生成指定质量大小的UIImage

 @param ciimage CIImage对象
 @param quality 生成图片的质量
 @param size 生成图片的尺寸
 @return UIImage对象
 */
+ (UIImage *) ag_imageWithCIImage:(CIImage *)ciimage quality:(CGInterpolationQuality)quality size:(CGSize)size
{
    // 创建bitmap
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef ctx = CGBitmapContextCreate(nil, size.width, size.height,
                                             8, 0, colorSpaceRef,
                                             kCGImageAlphaPremultipliedLast);
    
    // ciimage 生成 cgimage
    CGRect extent = CGRectIntegral(ciimage.extent);
    CGImageRef imageRef = [[CIContext contextWithOptions:nil] createCGImage:ciimage fromRect:extent];
    
    // 质量
    CGContextSetInterpolationQuality(ctx, quality);
    
    // 绘制
    CGFloat minSide = MIN(size.width, size.height);
    CGFloat x = (size.width - minSide) * 0.5;
    CGFloat y = (size.height - minSide) * 0.5;
    CGRect imageR = CGRectMake(x, y, minSide, minSide);
    CGContextDrawImage(ctx, imageR, imageRef);
    
    // 获取图片
    CGImageRef newImageRef = CGBitmapContextCreateImage(ctx);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    
    // 释放资源
    CGColorSpaceRelease(colorSpaceRef);
    CGContextRelease(ctx);
    CGImageRelease(imageRef);
    CGImageRelease(newImageRef);
    
    return image;
}

/**
 根据颜色生成指定大小的图片
 
 @param color 颜色
 @param size 生成图片的大小
 @return 图片
 */
+ (UIImage *)ag_imageWithColor:(UIColor *)color size:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(1.0, 1.0);
    }
    
    CGRect imageR = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(imageR.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, color.CGColor);
    CGContextFillRect(ctx, imageR);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *) ag_imageWithView:(UIView *)view
{
    CGSize size = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0); // 0.0 默认设备scale
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/** 高斯模糊 */
- (UIImage *) ag_imageByGaussianBlur:(CGFloat)radius
{
    return ag_newUIImageByGaussianBlurCGImage(self.CGImage, radius);
}

@end

#pragma mark 高斯模糊函数
CIImage * ag_newCIImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius)
{
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:ciimage forKey:kCIInputImageKey];
    [filter setValue:@(radius) forKey:kCIInputRadiusKey];
    CIImage *newCiimage = [filter outputImage];
    return newCiimage;
}

CIImage * ag_newCIImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius)
{
    return ag_newCIImageByGaussianBlurCIImage([CIImage imageWithCGImage:imageRef], radius);
}

// ...
CGImageRef ag_newCGImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius)
{
    CGRect extent = CGRectIntegral(ciimage.extent);
    CIImage *newImage = ag_newCIImageByGaussianBlurCIImage(ciimage, radius);
    return [[CIContext contextWithOptions:nil] createCGImage:newImage fromRect:extent];
}

CGImageRef ag_newCGImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius)
{
    return ag_newCGImageByGaussianBlurCIImage([CIImage imageWithCGImage:imageRef], radius);
}

// ...
UIImage * ag_newUIImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius)
{
    CGImageRef imageRef = ag_newCGImageByGaussianBlurCIImage(ciimage, radius);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

UIImage * ag_newUIImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius)
{
    return ag_newUIImageByGaussianBlurCIImage([CIImage imageWithCGImage:imageRef], radius);
}
