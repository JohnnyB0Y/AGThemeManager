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
    [self ag_themeSupport];
    
    // 根据主题，直接执行
    [self ag_themeExecute];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    
    self.imageView.image = [UIImage ag_themeForKey:kAGThemePackHomeCellIconImageName];
}

@end
