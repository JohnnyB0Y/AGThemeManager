//
//  AGMainImageCell.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGMainImageCell.h"
#import "AGThemeKit.h"
#import "AGCustomThemeConstKeys.h"

@interface AGMainImageCell ()

@end

@implementation AGMainImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    // 根据主题，配置好
    __weak typeof(self) weakSelf = self;
    [self ag_setupThemeUsingBlock:^(NSString * _Nonnull theme, AGThemePack * _Nonnull pack) {
        __strong typeof(weakSelf) self = weakSelf;
        if ( nil == self ) return;
        // ...
        NSString *imageName = pack[kAGThemePackHomeCellIconImageName];
        self.imageView.image = [UIImage imageNamed:imageName];
    }];
    
    // 根据主题，直接执行
    [self ag_executeSetupThemeBlock];
}

- (void)dealloc
{
    if ( [AGThemeManager sharedInstance].openLog ) {
        NSLog(@"AGMainImageCell dealloc!");
    }
}

@end
