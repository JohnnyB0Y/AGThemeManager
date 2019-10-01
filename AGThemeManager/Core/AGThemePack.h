//
//  AGThemePack.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//  主题包

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AGThemePack : NSObject

/// 主题包名称
@property (nonatomic, copy) NSString *name;


- (nullable id) objectForKeyedSubscript:(NSString *)key;
- (void) setObject:(nullable id)obj forKeyedSubscript:(NSString *)key;


#pragma mark 字体
- (void)setFontTextStyle:(UIFontTextStyle)style forKey:(NSString *)key;
- (void)setFont:(UIFont *)font forKey:(NSString *)key;


#pragma mark 图片
- (void)setImage:(UIImage *)image forKey:(NSString *)key;
- (void)setImageName:(NSString *)imageName forKey:(NSString *)key;
- (void)setImageFilePath:(NSString *)path forKey:(NSString *)key;


#pragma mark 颜色
- (void)setColor:(UIColor *)color forKey:(NSString *)key;
- (void)setColorName:(NSString *)colorName forKey:(NSString *)key;


#pragma mark 链接
- (void)setURL:(NSURL *)url forKey:(NSString *)key;
- (void)setURLStr:(NSString *)urlStr forKey:(NSString *)key;


- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;


#pragma mark - 派生 - 子类 - 实现；
///< 子类重写并赋值，创建主题包对象（对应自定义主题类）
+ (instancetype)newWithPackName:(NSString *)name;
///< 子类重写并赋值，创建主题包对象（对应自定义主题类）
- (instancetype)initWithPackName:(NSString *)name;

///< 从本地文件解析，创建主题包对象（对应本地主题文件）
+ (instancetype)newWithContentOfFile:(NSString *)fileURL;
///< 从本地文件解析，创建主题包对象（对应本地主题文件）
- (instancetype)initWithContentOfFile:(NSString *)fileURL;

///< 从网络数据解析，创建主题包对象（对应网络返回主题）
+ (instancetype)newWithThemePackData:(id)data;
///< 从网络数据解析，创建主题包对象（对应网络返回主题）
- (instancetype)initWithThemePackData:(id)data;

@end

NS_ASSUME_NONNULL_END
