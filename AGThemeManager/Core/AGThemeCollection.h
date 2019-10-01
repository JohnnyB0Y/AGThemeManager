//
//  AGThemeCollection.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//  主题包集合

#import <Foundation/Foundation.h>
@class AGThemePack;

NS_ASSUME_NONNULL_BEGIN

@interface AGThemeCollection : NSObject


/// 默认主题名称
@property (nonatomic, copy, readonly) NSString *defaultTheme;
/// 默认主题包
@property (nonatomic, strong, readonly) AGThemePack *defaultPack;

/// 上一次使用的主题名称
@property (nonatomic, copy, readonly) NSString *prevTheme;
/// 上一次使用的主题包
@property (nonatomic, strong, readonly) AGThemePack *prevPack;

/// 当前主题名称
@property (nonatomic, copy, readonly) NSString *currentTheme;
/// 当前主题包
@property (nonatomic, strong, readonly) AGThemePack *currentPack;


/// 注册主题包到集合
/// @param pack 主题包
- (void)ag_registerThemePack:(AGThemePack *)pack;


/// 从集合移除主题包
/// @param pack 主题包
- (void)ag_removeThemePack:(AGThemePack *)pack;


/**
 设置更换主题

 @param theme 要更换的主题
 @return 是否需要更换
 */
- (BOOL)ag_changeThemeIfNeeds:(NSString *)theme;


+ (instancetype)newWithDefaultTheme:(NSString *)theme;
- (instancetype)initWithDefaultTheme:(NSString *)theme;

- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
