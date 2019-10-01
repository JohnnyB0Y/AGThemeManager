//
//  AGThemeProtocol.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/10/1.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#ifndef AGThemeProtocol_h
#define AGThemeProtocol_h

#import <UIKit/UIKit.h>
@class AGThemeManager;

@protocol AGThemeConfigurable <NSObject>


/// 添加主题支持
- (void)ag_themeSupport;

/// 添加主题支持并执行修改
- (void)ag_themeSupportAndExecute;

/// 移除主题支持
- (void)ag_themeRemoveSupport;

/// 执行主题修改
- (void)ag_themeExecute;


@end

#endif /* AGThemeProtocol_h */
