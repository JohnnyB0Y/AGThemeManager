//
//  AGThemeKit.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#ifndef AGThemeKit_h
#define AGThemeKit_h

/**
 主题包管理，动态更新全局主题元素
 
 
 1，通过派生子类生成主题包，有3中方式生成主题包
 - 工程中
 派生 AGThemePack 的子类，重写初始化方法 -initWithPackName: 并配置主题元素；
 每个子类就是不同的主题包
 
 - 本地文件
 派生 AGThemePack 的子类，重写初始化方法 -initWithContentOfFile: 并配置主题元素；
 
 - 网络
 派生 AGThemePack 的子类，重写初始化方法 -initWithThemePackData: 并配置主题元素；

 
 
 2，在UI类中使用主题包
  ###### 在UI类中添加对主题的支持 #######
  /// 添加主题支持
 - (void)ag_themeAddSupport;

 /// 添加主题支持并执行修改
 - (void)ag_themeAddSupportAndExecute;

 /// 移除主题支持
 - (void)ag_themeRemoveSupport;

 /// 执行主题修改
 - (void)ag_themeExecute;


  ###### 重写系统特征变化方法，设置变化后的数据 #######
 - (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
 {
     [super traitCollectionDidChange:previousTraitCollection];
     
     self.textLabel.font = [UIFont ag_themeFontDynamicForKey:kAGThemePackHomeCellContentTextFont];
     self.textLabel.textColor = [UIColor ag_themeForKey:kAGThemePackHomeCellContentTextColor];
     self.imageView.image = [UIImage ag_themeForKey:kAGThemePackHomeCellIconImageName];
 }

 
 
 3，初始化配置
 - 在 AppDelegate 中，初始化视图界面之前配置好要使用的主题；
 // 配置主题
 AGThemeCollection *themeCollection = [AGThemeCollection newWithDefaultTheme:kAGOrangeThemePack];
 [themeCollection ag_registerThemePack:[AGOrangeThemePack newWithPackName:kAGOrangeThemePack]];
 [themeCollection ag_registerThemePack:[AGPurpleThemePack newWithPackName:kAGPurpleThemePack]];
 [themeCollection ag_registerThemePack:[AGBlueThemePack newWithPackName:kAGBlueThemePack]];
 [themeCollection ag_registerThemePack:[AGDarkThemePack newWithPackName:kAGDarkThemePack]]; // 黑暗模式
 [AGThemeManager sharedInstance].themeCollection = themeCollection;
 // 打开调试日志
 [AGThemeManager sharedInstance].openLog = YES;
 
 // 指定黑暗模式的主题包名
 [AGThemeManager sharedInstance].systemDarkThemeName = kAGDarkThemePack;

 
 
 */


#import "AGThemeManager.h"
#import "AGThemeCollection.h"
#import "AGThemePack.h"

#import "UIView+AGThemeManager.h"
#import "UIViewController+AGThemeManager.h"
#import "UIColor+AGThemeManager.h"
#import "UIFont+AGThemeManager.h"
#import "UIImage+AGThemeManager.h"
#import "NSURL+AGThemeManager.h"

#endif /* AGThemeKit_h */
