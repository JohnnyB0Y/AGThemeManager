//
//  AGThemeManager.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemeManager.h"

@interface AGThemeManager ()

/** mt */
@property (nonatomic, strong) NSMapTable *weakStrongMT;

@end

@implementation AGThemeManager
#pragma mark - ----------- Life Cycle -----------
+ (instancetype)sharedInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

#pragma mark - ---------- Public Methods ----------
- (void)ag_addSetupThemeBlock:(AGThemeConfigBlock)block forKey:(nonnull id)key
{
    if ( block ) {
        [self.weakStrongMT setObject:block forKey:key];
    }
}

- (void)ag_removeSetupThemeBlockForKey:(id)key
{
    [self.weakStrongMT removeObjectForKey:key];
}

- (void)ag_executeSetupThemeBlockForKey:(id)key
{
    if ( key ) {
        AGThemeConfigBlock block = [self.weakStrongMT objectForKey:key];
        if ( block ) {
            block(self.themePackBox.currentTheme, self.themePackBox.themePack);
        }
    }
}

- (void)ag_changeTheme:(NSString *)theme
{
    if ( _openLog ) {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        
        [self _changeTheme:theme];
        
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        
        NSEnumerator *objEnumerator = [self.weakStrongMT objectEnumerator];
        NSInteger i = 0;
        AGThemeConfigBlock block = objEnumerator.nextObject;
        while ( block ) {
            block = objEnumerator.nextObject;
            i++;
        }
        
        NSLog(@"Execute %ld theme block in %f ms.", i, linkTime * 1000.0);
        
    }
    else {
        [self _changeTheme:theme];
    }
}

- (void)_changeTheme:(NSString *)theme
{
    if ( theme.length <= 0 ) return;
    
    NSEnumerator *objEnumerator = [self.weakStrongMT objectEnumerator];
    AGThemeConfigBlock block = objEnumerator.nextObject;
    BOOL neededChange = [self.themePackBox ag_changeThemeIfNeeds:theme];
    NSString *currentTheme = self.themePackBox.currentTheme;
    AGThemePack *themePack = self.themePackBox.themePack;
    while ( block && neededChange ) {
        block(currentTheme, themePack);
        block = objEnumerator.nextObject;
    }
}

#pragma mark - ----------- Getter Methods -----------
- (NSMapTable *)weakStrongMT
{
    if ( nil == _weakStrongMT ) {
        _weakStrongMT = [NSMapTable mapTableWithKeyOptions:NSPointerFunctionsWeakMemory
                                              valueOptions:NSPointerFunctionsStrongMemory];
    }
    return _weakStrongMT;
}

@end
