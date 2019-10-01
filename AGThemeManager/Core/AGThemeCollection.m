//
//  AGThemeCollection.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemeCollection.h"
#import "AGThemePack.h"

@interface AGThemeCollection ()

@property (nonatomic, strong) NSMutableDictionary *dictM;

@end

@implementation AGThemeCollection
@synthesize defaultPack = _defaultPack;

#pragma mark - ----------- Life Cycle -----------
+ (instancetype)newWithDefaultTheme:(NSString *)theme
{
    AGThemeCollection *packManager = [[self alloc] initWithDefaultTheme:theme];
    return packManager;
}

- (instancetype)initWithDefaultTheme:(NSString *)theme
{
    self = [super init];
    
    if ( self ) {
        NSParameterAssert(theme);
        _defaultTheme = [theme copy];
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
            _prevTheme = [_currentTheme copy];
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

- (AGThemePack *)currentPack
{
    return [self.dictM objectForKey:self.currentTheme];
}

- (AGThemePack *)defaultPack
{
    if ( nil == _defaultPack ) {
        _defaultPack = [self.dictM objectForKey:_defaultTheme];
    }
    return _defaultPack;
}

- (AGThemePack *)prevPack
{
    return [self.dictM objectForKey:self.prevTheme];
}

@end
