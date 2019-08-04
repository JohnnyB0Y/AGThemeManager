//
//  AGThemePack.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//  主题包

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AGThemePack : NSObject

/** 主题包名称 */
@property (nonatomic, copy) NSString *name;


- (nullable id) objectForKeyedSubscript:(NSString *)key;
- (void) setObject:(nullable id)obj forKeyedSubscript:(NSString *)key;


- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;


// 派生 - 子类 - 实现；
+ (instancetype)newWithPackName:(NSString *)name; ///< 子类重写并赋值，创建主题包对象（对应自定义主题类）
- (instancetype)initWithPackName:(NSString *)name; ///< 子类重写并赋值，创建主题包对象（对应自定义主题类）

+ (instancetype)newWithContentOfFile:(NSString *)fileURL; ///< 从本地文件解析，创建主题包对象（对应本地主题文件）
- (instancetype)initWithContentOfFile:(NSString *)fileURL; ///< 从本地文件解析，创建主题包对象（对应本地主题文件）

+ (instancetype)newWithThemePackData:(id)data; ///< 从网络数据解析，创建主题包对象（对应网络返回主题）
- (instancetype)initWithThemePackData:(id)data; ///< 从网络数据解析，创建主题包对象（对应网络返回主题）

@end

NS_ASSUME_NONNULL_END
