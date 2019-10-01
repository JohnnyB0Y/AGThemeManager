//
//  AGThemeManager.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemeManager.h"
#import <UIKit/UIKit.h>

@interface AGThemeManager ()


@property (nonatomic, strong) NSHashTable *weakHashTable;


@property (nonatomic, copy) UIContentSizeCategory prevContentSizeCategory;
@property (nonatomic, copy) UIContentSizeCategory currentContentSizeCategory;
@property (nonatomic, assign) NSInteger fontScaleSize;
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSNumber *> *fontSizeOffsetDictM;


/// 上一个特征变化集合
@property (nonatomic, strong) UITraitCollection *prevTraitCollection;
/// 当前特征变化集合
@property (nonatomic, strong) UITraitCollection *currentTraitCollection;


@end

@implementation AGThemeManager
#pragma mark - ----------- Life Cycle -----------
+ (instancetype)sharedInstance
{
    static AGThemeManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
        
        instance.prevContentSizeCategory = @"";
        instance.openContentSizeChangeNotification = YES;
        
        instance->_prevTraitCollection = [UIScreen mainScreen].traitCollection;
    });
    return instance;
}

#pragma mark - ---------- Public Methods ----------
- (void)ag_addThemeResponder:(id<UITraitEnvironment>)responder
{
    if ( [responder respondsToSelector:@selector(traitCollectionDidChange:)] ) {
        [self.weakHashTable addObject:responder];
    }
}

- (void)ag_removeThemeResponder:(id<UITraitEnvironment>)responder
{
    [self.weakHashTable removeObject:responder];
}

- (void)ag_executeThemeForResponder:(id<UITraitEnvironment>)responder
{
    [responder traitCollectionDidChange:_prevTraitCollection];
}

- (void)ag_changeTheme:(NSString *)theme
{
    if ( _openLog ) {
        CFAbsoluteTime startTime = CFAbsoluteTimeGetCurrent();
        
        [self _changeTheme:theme];
        
        CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
        
        NSInteger i = 0;
        for (; i<self.weakHashTable.allObjects.count; i++){}
        
        NSLog(@"Execute %ld theme in %f ms.", i, linkTime * 1000.0);
        
    }
    else {
        [self _changeTheme:theme];
    }
}

#pragma mark - ---------- Private Methods ----------
- (void)_changeTheme:(NSString *)theme
{
    if ( theme.length <= 0 ) return;
    
    BOOL neededChange = [self.themeCollection ag_changeThemeIfNeeds:theme];
    if ( neededChange ) {
        [self.weakHashTable.allObjects enumerateObjectsUsingBlock:^(id<UITraitEnvironment> obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [obj traitCollectionDidChange:self.prevTraitCollection];
            
        }];
    }
}

- (void)_prepareForTheme
{
    // dark mode
    if ( self.systemDarkThemeName && _currentTraitCollection != [UIScreen mainScreen].traitCollection ) {
        _prevTraitCollection = _currentTraitCollection;
        _currentTraitCollection =  [UIScreen mainScreen].traitCollection;
        
        if (@available(iOS 12.0, *)) {
            if ( _prevTraitCollection.userInterfaceStyle != _currentTraitCollection.userInterfaceStyle ) {
                if ( _currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleDark ) {
                    [self.themeCollection ag_changeThemeIfNeeds:self.systemDarkThemeName];
                }
                else if ( _currentTraitCollection.userInterfaceStyle == UIUserInterfaceStyleLight ) {
                    [self.themeCollection ag_changeThemeIfNeeds:self.themeCollection.prevTheme];
                }
            }
        }
    }
    
}

#pragma mark - ----------- Getter Methods -----------
- (NSHashTable *)weakHashTable
{
    if ( nil == _weakHashTable ) {
        _weakHashTable = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:240];
    }
    return _weakHashTable;
}

- (AGThemeCollection *)themeCollection
{
    [self _prepareForTheme];
    return _themeCollection;
}

- (UIContentSizeCategory)defaultContentSizeCategory
{
    if ( nil == _defaultContentSizeCategory ) {
        _defaultContentSizeCategory = UIContentSizeCategoryMedium;
    }
    return _defaultContentSizeCategory;
}

- (NSInteger)fontScaleSize
{
    UIContentSizeCategory contentSizeCategory = [UIApplication sharedApplication].preferredContentSizeCategory;
    if ( ! [_currentContentSizeCategory isEqualToString:contentSizeCategory] ) {
        _prevContentSizeCategory = _currentContentSizeCategory;
        _currentContentSizeCategory = contentSizeCategory;
        
        if ( _openContentSizeChangeNotification ) {
            NSInteger defaultSizeOffset = self.fontSizeOffsetDictM[self.defaultContentSizeCategory].integerValue;
            NSInteger currentSizeOffset = self.fontSizeOffsetDictM[_currentContentSizeCategory].integerValue;
            _fontScaleSize = currentSizeOffset - defaultSizeOffset;
        }
    }
    return _fontScaleSize;
}

- (NSMutableDictionary *)fontSizeOffsetDictM
{
    if ( nil == _fontSizeOffsetDictM ) {
        _fontSizeOffsetDictM = [NSMutableDictionary dictionaryWithCapacity:15];
        if (@available(iOS 10.0, *)) {
            _fontSizeOffsetDictM[UIContentSizeCategoryUnspecified] = @(2); // 未定义，就默认吧！
        }
        _fontSizeOffsetDictM[UIContentSizeCategoryExtraSmall] = @(0); // XS (0), offset 0
        _fontSizeOffsetDictM[UIContentSizeCategorySmall] = @(1); // S (1), offset 1
        _fontSizeOffsetDictM[UIContentSizeCategoryMedium] = @(2);// M (1), offset 2, default
        _fontSizeOffsetDictM[UIContentSizeCategoryLarge] = @(3); // L (1), offset 3
        _fontSizeOffsetDictM[UIContentSizeCategoryExtraLarge] = @(5); // XL (2), offset 5
        _fontSizeOffsetDictM[UIContentSizeCategoryExtraExtraLarge] = @(7); // XXL (2), offset 7
        _fontSizeOffsetDictM[UIContentSizeCategoryExtraExtraExtraLarge] = @(9); // XXXL (2), offset 9
        
        _fontSizeOffsetDictM[UIContentSizeCategoryAccessibilityMedium] = @(14); // AM (5), offset 14
        _fontSizeOffsetDictM[UIContentSizeCategoryAccessibilityLarge] = @(19); // AL (5), offset 19
        _fontSizeOffsetDictM[UIContentSizeCategoryAccessibilityExtraLarge] = @(26); // AXL (7), offset 26
        _fontSizeOffsetDictM[UIContentSizeCategoryAccessibilityExtraExtraLarge] = @(33); // AXXL (7), offset 33
        _fontSizeOffsetDictM[UIContentSizeCategoryAccessibilityExtraExtraExtraLarge] = @(39); // AXXXL (6), offset 39
        
    }
    return _fontSizeOffsetDictM;
}

#pragma mark - ----------- Setter Methods ----------
- (void)setSystemDarkThemeName:(NSString *)systemDarkThemeName
{
    if (@available(iOS 13.0, *)) {
        _systemDarkThemeName = [systemDarkThemeName copy];
    }
}

@end
