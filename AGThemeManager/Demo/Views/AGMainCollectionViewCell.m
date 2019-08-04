//
//  AGMainCollectionViewCell.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGMainCollectionViewCell.h"
#import "AGThemeKit.h"
#import "AGCustomThemeConstKeys.h"

@interface AGMainCollectionViewCell ()

/** img view */
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation AGMainCollectionViewCell

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if ( self ) {
        [self setup];
    }
    
    return self;
}

- (void) setup
{
    [self.contentView addSubview:self.imageView];
    
    self.imageView.bounds = CGRectMake(0, 0, 30, 30);
    self.imageView.center = self.contentView.center;
    
    __weak typeof(self) weakSelf = self;
    [self ag_setupThemeUsingBlock:^(NSString * _Nonnull theme, AGThemePack * _Nonnull pack) {
        __strong typeof(weakSelf) self = weakSelf;
        if ( nil == self ) return;
        // ...
        self.backgroundColor = pack[kAGThemePackHomeCellContentTextColor];
        
        self.imageView.image = [UIImage imageNamed:pack[kAGThemePackHomeCellIconImageName]];
    }];
    
    [self ag_executeSetupThemeBlock];
}

#pragma mark - ----------- Getter Methods -----------
- (UIImageView *)imageView
{
    if ( nil == _imageView ) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (void)dealloc
{
    if ( [AGThemeManager sharedInstance].openLog ) {
        NSLog(@"AGMainCollectionViewCell dealloc!");
    }
}

@end
