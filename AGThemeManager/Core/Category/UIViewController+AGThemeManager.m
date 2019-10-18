//
//  UIViewController+AGThemeManager.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/10/1.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIViewController+AGThemeManager.h"

@implementation UIViewController (AGThemeManager)

- (void)ag_themeAddSupport
{
    [AGThemeManager.sharedInstance ag_addThemeResponder:self];
}

- (void)ag_themeAddSupportAndExecute
{
    [self ag_themeAddSupport];
    [self ag_themeExecute];
}

- (void)ag_themeRemoveSupport
{
    [AGThemeManager.sharedInstance ag_removeThemeResponder:self];
}

- (void)ag_themeExecute
{
    [AGThemeManager.sharedInstance ag_executeThemeForResponder:self];
}

@end
