//
//  Created by JohnnyB0Y on 15/10/26.
//  Copyright © 2015年 JohnnyB0Y. All rights reserved.
//  图片生成

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (AGGenerate)

#pragma mark 获取图片压缩后的Data数据
/**
 获取图片压缩后的Data数据

 @param length 期望压缩后的KB数
 @return 图片Data数据
 */
- (NSData *) ag_dataByCompressionMaxLimitKByte:(NSInteger)length;

#pragma mark 压缩图片 并转化为 base64字符串
/**
 压缩图片 并转化为 base64字符串
 
 @param length 期望压缩后的KB数
 @return 图片的 base64字符串
 */
- (NSString *) ag_base64EncodedStringByCompressionMaxLimitKByte:(NSInteger)length;

#pragma mark 通过UIView 生成图片
/**
 通过UIView 生成图片

 @param view 视图
 @return 图片
 */
+ (UIImage *) ag_imageWithView:(UIView *)view;

#pragma mark 生成二维码图片
/**
 生成二维码图片

 @param qrStr 编码的字符串
 @side 图片边长
 @return 二维码图片
 */
+ (UIImage *) ag_imageWithQRCode:(NSString *)qrStr side:(CGFloat)side;


/**
 根据CIImage生成指定质量、大小的UIImage
 
 @param ciimage CIImage对象
 @param quality 生成图片的质量
 @param size 生成图片的尺寸
 @return 图片
 */
+ (UIImage *) ag_imageWithCIImage:(CIImage *)ciimage
                          quality:(CGInterpolationQuality)quality
                             size:(CGSize)size;

#pragma mark 根据颜色生成指定大小的图片
/**
 根据颜色生成指定大小的图片

 @param color 颜色
 @param size 生成图片的大小
 @return 图片
 */
+ (UIImage *)ag_imageWithColor:(UIColor *)color size:(CGSize)size;

#pragma mark 高斯模糊
/**
 高斯模糊

 @param radius 模糊半径（越大越模糊）
 @return 图片
 */
- (UIImage *) ag_imageByGaussianBlur:(CGFloat)radius;

#pragma mark 图片渲染模式
+ (UIImage *) ag_imageName:(NSString *)name renderingMode:(UIImageRenderingMode)mode;
+ (UIImage *) ag_imageRenderingModeAlwaysOriginal:(NSString *)name; // 原图
- (UIImage *) ag_imageRenderingModeAlwaysOriginal; // 原图

#pragma mark 圆角图片
/**
 单独裁剪圆角

 @param corner 需要裁剪的圆角（四个角）
 @param radius 裁剪半径(像素点)
 @return 图片
 */
- (UIImage *) ag_imageByClipCorner:(UIRectCorner)corner radius:(CGFloat)radius;

/**
 四个圆角统一裁剪

 @param radius 裁剪半径
 @return 图片
 */
- (UIImage *) ag_imageByClipCorner:(CGFloat)radius;

/** 圆形图片 */
- (UIImage *) ag_imageByClipCircle;

@end

#pragma mark 高斯模糊函数
CIImage * ag_newCIImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius);
CIImage * ag_newCIImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius);
// ...
CGImageRef ag_newCGImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius);
CGImageRef ag_newCGImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius);
// ...
UIImage * ag_newUIImageByGaussianBlurCIImage(CIImage *ciimage, CGFloat radius);
UIImage * ag_newUIImageByGaussianBlurCGImage(CGImageRef imageRef, CGFloat radius);

NS_ASSUME_NONNULL_END
