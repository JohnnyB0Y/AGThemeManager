//
//  UIImage+AGTransform.h
//  
//
//  Created by JohnnyB0Y on 15/9/24.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//  图片形变

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AGTransform)

#pragma mark 图片缩放
+ (UIImage *) ag_imageByScaleCGImage:(CGImageRef)imageRef scale:(CGFloat)scale;
- (UIImage *) ag_imageScale:(CGFloat)scale;

- (UIImage *) ag_imageScaleToPixel:(CGSize)pixelSize;
- (UIImage *) ag_imageScaleToSize:(CGSize)size;

#pragma mark 图片旋转
+ (UIImage *) ag_imageByRotateCGImage:(CGImageRef)imageRef rotate:(UIImageOrientation)orientation;
- (UIImage *) ag_imageRotate:(UIImageOrientation)orientation;

#pragma mark 图片垂直翻转
+ (UIImage *) ag_imageByFlipVerticalCGImage:(CGImageRef)imageRef;
- (UIImage *) ag_imageFlipVertical;

#pragma mark 图片水平翻转
+ (UIImage *) ag_imageByFlipHorizontalCGImage:(CGImageRef)imageRef;
- (UIImage *) ag_imageFlipHorizontal;

#pragma mark 图片拉伸
- (UIImage *) ag_imageByStretchCorner:(CGFloat)radius; // 统一指定内边角，然后拉伸
- (UIImage *) ag_imageByStretchEdge:(UIEdgeInsets)insets; // 单独指定内边角，然后拉伸

@end

/** 图片缩放 */
#pragma mark - 图片缩放函数
CGImageRef ag_newCGImageByScaleCGImageToPixel(CGImageRef imageRef, CGSize pixelSize);
UIImage *  ag_newUIImageByScaleCGImageToPixel(CGImageRef imageRef, CGSize pixelSize);

CGImageRef ag_newCGImageByScaleCGImage(CGImageRef imageRef, CGFloat scale);
UIImage *  ag_newUIImageByScaleCGImage(CGImageRef imageRef, CGFloat scale);

/** 图片旋转 */
#pragma mark - 图片旋转函数
CGImageRef ag_newCGImageByRotateCGImage(CGImageRef imageRef, UIImageOrientation orientation);
UIImage *  ag_newUIImageByRotateCGImage(CGImageRef imageRef, UIImageOrientation orientation);

/** 图片垂直翻转 */
#pragma mark 图片垂直翻转函数
CGImageRef ag_newCGImageByFlipVerticalCGImage(CGImageRef imageRef);
UIImage *  ag_newUIImageByFlipVerticalCGImage(CGImageRef imageRef);

/** 图片水平翻转 */
#pragma mark 图片水平翻转函数
CGImageRef ag_newCGImageByFlipHorizontalCGImage(CGImageRef imageRef);
UIImage *  ag_newUIImageByFlipHorizontalCGImage(CGImageRef imageRef);

NS_ASSUME_NONNULL_END
