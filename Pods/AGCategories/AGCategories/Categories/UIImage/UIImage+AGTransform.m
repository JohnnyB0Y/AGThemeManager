//
//  UIImage+AGTransform.m
//  
//
//  Created by JohnnyB0Y on 15/9/24.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//

#import "UIImage+AGTransform.h"

@implementation UIImage (AGTransform)

#pragma mark 图片缩放
+ (UIImage *) ag_imageByScaleCGImage:(CGImageRef)imageRef scale:(CGFloat)scale
{
    return ag_newUIImageByScaleCGImage(imageRef, scale);
}
- (UIImage *) ag_imageScale:(CGFloat)scale
{
    return ag_newUIImageByScaleCGImage(self.CGImage, scale);
}
- (UIImage *) ag_imageScaleToPixel:(CGSize)pixelSize
{
    return ag_newUIImageByScaleCGImageToPixel(self.CGImage, pixelSize);
}
- (UIImage *) ag_imageScaleToSize:(CGSize)size
{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize pixelSize = CGSizeMake(size.width * scale, size.height * scale);
    return ag_newUIImageByScaleCGImageToPixel(self.CGImage, pixelSize);
}

#pragma mark 图片旋转
+ (UIImage *) ag_imageByRotateCGImage:(CGImageRef)imageRef rotate:(UIImageOrientation)orientation
{
    return ag_newUIImageByRotateCGImage(imageRef, orientation);
}
- (UIImage *) ag_imageRotate:(UIImageOrientation)orientation
{
    return ag_newUIImageByRotateCGImage(self.CGImage, orientation);
}

#pragma mark 图片垂直翻转
+ (UIImage *) ag_imageByFlipVerticalCGImage:(CGImageRef)imageRef
{
    return ag_newUIImageByFlipVerticalCGImage(imageRef);
}
- (UIImage *) ag_imageFlipVertical
{
    return ag_newUIImageByFlipVerticalCGImage(self.CGImage);
}

#pragma mark 图片水平翻转
+ (UIImage *) ag_imageByFlipHorizontalCGImage:(CGImageRef)imageRef
{
    return ag_newUIImageByFlipHorizontalCGImage(imageRef);
}
- (UIImage *) ag_imageFlipHorizontal
{
    return ag_newUIImageByFlipHorizontalCGImage(self.CGImage);
}

#pragma mark 图片拉伸
- (UIImage *) ag_imageByStretchCorner:(CGFloat)radius
{
    return [self ag_imageByStretchEdge:UIEdgeInsetsMake(radius, radius, radius, radius)];
}

- (UIImage *) ag_imageByStretchEdge:(UIEdgeInsets)insets
{
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

@end

/** 图片缩放 */
#pragma mark - 图片缩放函数
CGImageRef ag_newCGImageByScaleCGImageToPixel(CGImageRef imageRef, CGSize pixelSize)
{
    CGFloat imageW = pixelSize.width;
    CGFloat imageH = pixelSize.height;
    CGContextRef ctx = CGBitmapContextCreate(NULL, imageW, imageH,
                                             CGImageGetBitsPerComponent(imageRef), 0,
                                             CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    
    CGContextDrawImage(ctx, CGRectMake(0, 0, imageW, imageH), imageRef);
    CGImageRef newImageRef = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    
    return newImageRef;
}

UIImage * ag_newUIImageByScaleCGImageToPixel(CGImageRef imageRef, CGSize pixelSize)
{
    CGImageRef newImageRef = ag_newCGImageByScaleCGImageToPixel(imageRef, pixelSize);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return image;
}

CGImageRef ag_newCGImageByScaleCGImage(CGImageRef imageRef, CGFloat scale)
{
    CGFloat imageW = CGImageGetWidth(imageRef);
    CGFloat imageH = CGImageGetHeight(imageRef);
    if ( scale <= 0 || scale == 1 ) {
        return CGImageCreateCopy(imageRef);
    }
    
    if ( scale < 1 && (imageW <= 8 || imageH <= 8) ) {
        return CGImageCreateCopy(imageRef);
    }
    
    imageW *= scale;
    imageH *= scale;
    
    return ag_newCGImageByScaleCGImageToPixel(imageRef, CGSizeMake(imageW, imageH));
}

UIImage * ag_newUIImageByScaleCGImage(CGImageRef imageRef, CGFloat scale)
{
    CGImageRef newImageRef = ag_newCGImageByScaleCGImage(imageRef, scale);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return image;
}

/** 图片旋转 */
#pragma mark - 图片旋转函数
CGImageRef ag_newCGImageByRotateCGImage(CGImageRef imageRef, UIImageOrientation orientation)
{
    CGFloat imageW = CGImageGetWidth(imageRef);
    CGFloat imageH = CGImageGetHeight(imageRef);
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    CGFloat newImageW = imageW;
    CGFloat newImageH = imageH;
    switch ( orientation ) {
        case UIImageOrientationUpMirrored:
            // x move imageW; y move 0.0
            transform = CGAffineTransformMakeTranslation(imageW, 0.0);
            // x 倒影 y 不变
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown:
            transform = CGAffineTransformMakeTranslation(imageW, imageH);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformMakeTranslation(0.0, imageH);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeft:
            transform = CGAffineTransformMakeTranslation(imageH, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            newImageW = imageH;
            newImageH = imageW;
            break;
            
        case UIImageOrientationLeftMirrored:
            // x 移动 imageH；y移动 imageW；
            transform = CGAffineTransformMakeTranslation(imageH, imageW);
            // 坐标系逆时针旋转 3 * M_PI_2 弧度
            transform = CGAffineTransformRotate(transform, M_PI_2);
            // x 倒影；y不变；
            transform = CGAffineTransformScale(transform, -1.0, 1.0); // ok
            
            newImageW = imageH;
            newImageH = imageW;
            break;
            
        case UIImageOrientationRight:
            transform = CGAffineTransformMakeTranslation(0.0, imageW);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            
            newImageW = imageH;
            newImageH = imageW;
            break;
            
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            
            newImageW = imageH;
            newImageH = imageW;
            break;
            
        default:
            return CGImageCreateCopy(imageRef);
    }
    
    CGContextRef ctx = CGBitmapContextCreate(NULL, newImageW, newImageH,
                                             CGImageGetBitsPerComponent(imageRef), 0,
                                             CGImageGetColorSpace(imageRef),
                                             CGImageGetBitmapInfo(imageRef));
    CGContextConcatCTM(ctx, transform);
    CGContextDrawImage(ctx, CGRectMake(0, 0, imageW, imageH), imageRef);
    
    CGImageRef newImageRef = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
    
    return newImageRef;
}

UIImage * ag_newUIImageByRotateCGImage(CGImageRef imageRef, UIImageOrientation orientation)
{
    CGImageRef newImageRef = ag_newCGImageByRotateCGImage(imageRef, orientation);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    return newImage;
}

/** 垂直翻转 */
#pragma mark 图片垂直翻转函数
CGImageRef ag_newCGImageByFlipVerticalCGImage(CGImageRef imageRef)
{
    return ag_newCGImageByRotateCGImage(imageRef, UIImageOrientationDownMirrored);
}

UIImage * ag_newUIImageByFlipVerticalCGImage(CGImageRef imageRef)
{
    CGImageRef newImageRef = ag_newCGImageByFlipVerticalCGImage(imageRef);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return image;
}

/** 水平翻转 */
#pragma mark 图片水平翻转函数
CGImageRef ag_newCGImageByFlipHorizontalCGImage(CGImageRef imageRef)
{
    return ag_newCGImageByRotateCGImage(imageRef, UIImageOrientationUpMirrored);
}

UIImage *  ag_newUIImageByFlipHorizontalCGImage(CGImageRef imageRef)
{
    CGImageRef newImageRef = ag_newCGImageByFlipHorizontalCGImage(imageRef);
    UIImage *image = [UIImage imageWithCGImage:newImageRef];
    CGImageRelease(newImageRef);
    return image;
}
