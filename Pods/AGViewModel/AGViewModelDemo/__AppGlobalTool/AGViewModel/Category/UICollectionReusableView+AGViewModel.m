//
//  UICollectionReusableView+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2018/2/10.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import "UICollectionReusableView+AGViewModel.h"
#import "UIScreen+AGViewModel.h"

@implementation UICollectionReusableView (AGViewModel)

#pragma mark - AGCollectionFooterViewReusable
+ (NSString *)ag_reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void)ag_registerFooterViewBy:(UICollectionView *)collectionView
{
    // 有特殊需求，请在子类重写。
    if ( [self ag_canAwakeNibInBundle:[self ag_resourceBundle]] ) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[self ag_resourceBundle]];
        [collectionView registerNib:nib
         forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                withReuseIdentifier:[self ag_reuseIdentifier]];
    }
    else {
        [collectionView registerClass:[self class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                  withReuseIdentifier:[self ag_reuseIdentifier]];
    }
}

+ (instancetype)ag_dequeueFooterViewBy:(UICollectionView *)collectionView for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                              withReuseIdentifier:[self ag_reuseIdentifier]
                                                     forIndexPath:indexPath];
}

#pragma mark - AGCollectionHeaderViewReusable
+ (void)ag_registerHeaderViewBy:(UICollectionView *)collectionView
{
    // 有特殊需求，请在子类重写。
    if ( [self ag_canAwakeNibInBundle:[self ag_resourceBundle]] ) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[self ag_resourceBundle]];
        [collectionView registerNib:nib
         forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                withReuseIdentifier:[self ag_reuseIdentifier]];
    }
    else {
        [collectionView registerClass:[self class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:[self ag_reuseIdentifier]];
    }
}

+ (instancetype)ag_dequeueHeaderViewBy:(UICollectionView *)collectionView for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
    return [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                              withReuseIdentifier:[self ag_reuseIdentifier]
                                                     forIndexPath:indexPath];
}

#pragma mark - ----------- AGVMResponsive -----------
- (CGSize) ag_viewModel:(AGViewModel *)vm sizeForLayout:(UIScreen *)screen
{
    // 有特殊需求，请在子类重写。
    CGFloat height = [vm[kAGVMViewH] floatValue];
    CGSize bvS = CGSizeMake(screen.width, height);
    if ( height <= 0 ) {
        bvS.height = 34.;
    }
    return bvS;
}

@end
