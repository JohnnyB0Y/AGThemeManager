//
//  AGThemeManager.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGThemePackBox.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^AGThemeConfigBlock)(NSString *theme, AGThemePack *pack);

@interface AGThemeManager : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) AGThemePackBox *themePackBox;

- (void)ag_addSetupThemeBlock:(AGThemeConfigBlock)block forKey:(id)key;

- (void)ag_removeSetupThemeBlockForKey:(id)key;

- (void)ag_executeSetupThemeBlockForKey:(id)key;

/** 更改主题 */
- (void)ag_changeTheme:(NSString *)theme;

#pragma mark 调试
@property (nonatomic, assign) BOOL openLog; ///< 打印执行日志


- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
