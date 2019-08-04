//
//  AGThemePackCollectionViewCell.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemePackCollectionViewCell.h"
#import "AGThemeKit.h"

@interface AGThemePackCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *packNameLabel;

@end

@implementation AGThemePackCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.packNameLabel];
    
    self.packNameLabel.textAlignment = NSTextAlignmentCenter;
}

- (void)setViewModel:(AGViewModel *)viewModel
{
    [super setViewModel:viewModel];
    
    self.packNameLabel.text = viewModel[kAGVMTitleText];
    self.packNameLabel.textColor = viewModel[kAGVMTitleColor];
    self.iconImageView.image = viewModel[kAGVMImage];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat margin = 15;
    
    CGFloat iconW = width - 2 * margin;
    CGFloat iconH = iconW;
    self.iconImageView.frame = CGRectMake(margin, margin, iconW, iconH);
    
    
    CGFloat nameW = width;
    CGFloat nameH = 20;
    CGFloat nameY = CGRectGetMaxY(self.iconImageView.frame) + 5;
    self.packNameLabel.frame = CGRectMake(0, nameY, nameW, nameH);
    
}

#pragma mark - ----------- Getter Methods ----------
- (UIImageView *)iconImageView
{
    if ( nil == _iconImageView ) {
        _iconImageView = [[UIImageView alloc] init];
    }
    return _iconImageView;
}

- (UILabel *)packNameLabel
{
    if ( nil == _packNameLabel ) {
        _packNameLabel = [[UILabel alloc] init];
    }
    return _packNameLabel;
}

@end
