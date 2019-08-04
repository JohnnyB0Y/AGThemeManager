//
//  AGMainMessageCell.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGMainMessageCell.h"
#import "AGThemeKit.h"
#import "AGCustomThemeConstKeys.h"

@interface AGMainMessageCell ()

@end

@implementation AGMainMessageCell

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
    self.textLabel.numberOfLines = 0;
    
    self.textLabel.text = @"MIT License \n\nA short and simple permissive license with conditions only requiring preservation of copyright and license notices. Licensed works, modifications, and larger works may be distributed under different terms and without source code.";
    
    __weak typeof(self) weakSelf = self;
    [self ag_setupThemeUsingBlock:^(NSString * _Nonnull theme, AGThemePack * _Nonnull pack) {
        __strong typeof(weakSelf) self = weakSelf;
        if ( nil == self ) return;
        // ...
        self.textLabel.font = pack[kAGThemePackHomeCellContentTextFont];
        self.textLabel.textColor = pack[kAGThemePackHomeCellContentTextColor];
    }];
    
    [self ag_executeSetupThemeBlock];
}

- (void)dealloc
{
    if ( [AGThemeManager sharedInstance].openLog ) {
        NSLog(@"AGMainMessageCell dealloc!");
    }
}

@end
