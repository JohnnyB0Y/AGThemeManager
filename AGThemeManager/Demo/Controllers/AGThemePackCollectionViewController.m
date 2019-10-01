//
//  AGThemePackCollectionViewController.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemePackCollectionViewController.h"
#import "AGThemePackCollectionViewCell.h"
#import <AGViewModel/AGVMKit.h>
#import "AGThemeKit.h"
#import "AGCustomThemeConstKeys.h"

@interface AGThemePackCollectionViewController ()

/** 主题包s */
@property (nonatomic, copy) AGVMSection *themePackVMS;

@end

@implementation AGThemePackCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

static NSString * const kAGThemeName = @"kAGThemeName";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[AGThemePackCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self setup];
}

- (void)setup
{
    self.title = @"主题包";
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

+ (instancetype)themePackCollectionViewController
{
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc] init];
    
    fl.itemSize = CGSizeMake(120, 140);
    
    AGThemePackCollectionViewController *vc = [[AGThemePackCollectionViewController alloc] initWithCollectionViewLayout:fl];
    
    return vc;
}

#pragma mark - ----------- Event Methods -----------
- (void)rightItemClick:(UIBarButtonItem *)item
{
    
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.themePackVMS.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    AGThemePackCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    AGViewModel *vm = self.themePackVMS[indexPath.item];
    
    vm.setIndexPath(indexPath).setBindingView(cell);
    
    cell.viewModel = vm;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AGViewModel *vm = self.themePackVMS[indexPath.item];
    [[AGThemeManager sharedInstance] ag_changeTheme:vm[kAGThemeName]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (AGVMSection *)themePackVMS
{
    if ( nil == _themePackVMS ) {
        _themePackVMS = [AGVMSection newWithItemCapacity:12];
        
        [_themePackVMS ag_packageItemData:^(AGViewModel * _Nonnull package) {
            package[kAGVMTitleText] = @"橙色主题";
            package[kAGVMTitleColor] = [UIColor orangeColor];
            package[kAGVMImage] = [UIImage imageNamed:@"ic_share_weibo"];
            package[kAGThemeName] = kAGOrangeThemePack;
        }];
        
        [_themePackVMS ag_packageItemData:^(AGViewModel * _Nonnull package) {
            package[kAGVMTitleText] = @"蓝色主题";
            package[kAGVMTitleColor] = [UIColor blueColor];
            package[kAGVMImage] = [UIImage imageNamed:@"ic_share_qq"];
            package[kAGThemeName] = kAGBlueThemePack;
        }];
        
        [_themePackVMS ag_packageItemData:^(AGViewModel * _Nonnull package) {
            package[kAGVMTitleText] = @"紫色主题";
            package[kAGVMTitleColor] = [UIColor purpleColor];
            package[kAGVMImage] = [UIImage imageNamed:@"purple"];
            package[kAGThemeName] = kAGPurpleThemePack;
        }];
    }
    return _themePackVMS;
}

@end
