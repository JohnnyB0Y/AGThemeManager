//
//  AGThemePackBox.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemePackBox.h"
#import "AGThemePack.h"

@interface AGThemePackBox ()

@property (nonatomic, strong) NSMutableDictionary *dictM;

@end

@implementation AGThemePackBox

#pragma mark - ----------- Life Cycle -----------
+ (instancetype)newWithCurrentTheme:(NSString *)theme
{
    AGThemePackBox *packManager = [[self alloc] initWithCurrentTheme:theme];
    return packManager;
}

- (instancetype)initWithCurrentTheme:(NSString *)theme
{
    self = [super init];
    
    if ( self ) {
        NSParameterAssert(theme);
        _currentTheme = [theme copy];
    }
    
    return self;
}

#pragma mark - ---------- Public Methods ----------
- (void)ag_registerThemePack:(AGThemePack *)pack
{
    if ( [pack isKindOfClass:[AGThemePack class]] ) {
        [self.dictM setObject:pack forKey:pack.name];
    }
}

- (void)ag_removeThemePack:(AGThemePack *)pack
{
    if ( [pack isKindOfClass:[AGThemePack class]] ) {
        [_dictM removeObjectForKey:pack.name];
    }
}

- (BOOL)ag_changeThemeIfNeeds:(NSString *)theme
{
    if ( [theme isEqualToString:_currentTheme] ) {
        return NO;
    }
    
    for (NSString *key in self.dictM.allKeys) {
        
        if ( [key isEqualToString:theme] ) {
            _currentTheme = [theme copy];
            return YES;
        }
    }
    
    return NO;
}

#pragma mark - ----------- Getter Methods -----------
- (NSMutableDictionary *)dictM
{
    if ( nil == _dictM ) {
        _dictM = [NSMutableDictionary dictionary];
    }
    return _dictM;
}

- (AGThemePack *)themePack
{
    return [self.dictM objectForKey:self.currentTheme];
}

@end


