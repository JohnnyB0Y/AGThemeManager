//
//  NSObject+AGThemeManager.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSObject+AGThemeManager.h"

@implementation NSObject (AGThemeManager)
- (void)ag_setupThemeUsingBlock:(AGThemeConfigBlock)block
{
    [[AGThemeManager sharedInstance] ag_addSetupThemeBlock:block forKey:self];
}

- (void)ag_setupAndExecuteThemeUsingBlock:(AGThemeConfigBlock)block
{
    [self ag_setupThemeUsingBlock:block];
    [self ag_executeSetupThemeBlock];
}

- (void)ag_executeSetupThemeBlock
{
    [[AGThemeManager sharedInstance] ag_executeSetupThemeBlockForKey:self];
}

- (void)ag_removeSetupThemeBlock
{
    [[AGThemeManager sharedInstance] ag_removeSetupThemeBlockForKey:self];
}

@end
