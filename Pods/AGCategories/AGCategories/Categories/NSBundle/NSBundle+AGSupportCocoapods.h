//
//  NSBundle+AGSupportCocoapods.h
//  
//
//  Created by JohnnyB0Y on 2018/12/6.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (AGSupportCocoapods)

/**
 获取 cocoapods 的资源包
 默认是获取 ResourceFramework.bundle 或 MyLibrary.bundle 或 aClass当前Bundle。

 @param aClass 当前资源所属工程的类
 @return 资源包
 */
+ (NSBundle *) ag_cocoapodsBundleForClass:(Class)aClass;


/**
 获取当前类的资源包
 默认后缀 .bundle
 @param aClass 当前资源所属工程的类
 @param name 资源包名称
 @return 资源包
 */
+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name;


/**
 获取当前类的资源包

 @param aClass 当前资源所属工程的类
 @param name 资源包名称
 @param ext 资源包后缀
 @return 资源包
 */
+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name
                   withExtension:(NSString *)ext;


/**
 获取当前类的资源包

 @param aClass 当前资源所属工程的类
 @param name 资源包名称
 @param ext 资源包后缀
 @param error 错误信息
 @return 资源包
 */
+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name
                   withExtension:(NSString *)ext
                           error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
