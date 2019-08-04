//
//  AGThemePackBox.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//  主题包集合

#import <Foundation/Foundation.h>
@class AGThemePack;

NS_ASSUME_NONNULL_BEGIN

@interface AGThemePackBox : NSObject

@property (nonatomic, copy, readonly) NSString *currentTheme;
@property (nonatomic, strong, readonly) AGThemePack *themePack;

- (void)ag_registerThemePack:(AGThemePack *)pack;
- (void)ag_removeThemePack:(AGThemePack *)pack;

/**
 设置更换主题

 @param theme 要更换的主题
 @return 是否需要更换
 */
- (BOOL)ag_changeThemeIfNeeds:(NSString *)theme;

+ (instancetype)newWithCurrentTheme:(NSString *)theme;
- (instancetype)initWithCurrentTheme:(NSString *)theme;

- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
