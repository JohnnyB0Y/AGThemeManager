//
//  AGThemeManager.h
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AGThemeCollection.h"
#import "AGThemeProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGThemeManager : NSObject

@property (class, readonly) AGThemeManager *sharedInstance;


/// 主题包集合
@property (nonatomic, strong, nullable) AGThemeCollection *themeCollection;


- (void)ag_addThemeResponder:(id<UITraitEnvironment>)responder;
- (void)ag_removeThemeResponder:(id<UITraitEnvironment>)responder;
- (void)ag_executeThemeForResponder:(id<UITraitEnvironment>)responder;


/// 更改主题包
/// @param theme 主题包名
- (void)ag_changeTheme:(NSString *)theme;

#pragma mark 字体
///< 打开内容伸缩通知, default is YES
@property (nonatomic, assign) BOOL openContentSizeChangeNotification;

/// 指定默认的伸缩值作为 scale=0 参考值，default is UIContentSizeCategoryMedium
@property (nonatomic, copy) UIContentSizeCategory defaultContentSizeCategory;

///< 字体伸缩 size
@property (nonatomic, assign, readonly) NSInteger fontScaleSize;

#pragma mark 黑暗模式

/// 指定黑暗模式的主题包名
@property (nonatomic, copy, nullable) NSString *systemDarkThemeName;

#pragma mark 调试
@property (nonatomic, assign) BOOL openLog; ///< 打印执行日志


- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
