//
//  UICollectionView+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/3/3.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UICollectionView+AGViewModel.h"
#import "AGVMProtocol.h"

@implementation UICollectionView (AGViewModel)

#pragma mark collection view cell
- (void)ag_registerCellForClass:(Class<AGViewReusable>)cls
{
    [self registerClass:cls forCellWithReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (void)ag_registerNibCellForClass:(Class<AGViewReusable>)cls
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[cls ag_resourceBundle]];
    [self registerNib:nib forCellWithReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (__kindof UICollectionViewCell *)ag_dequeueCellWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
    return [self dequeueReusableCellWithReuseIdentifier:[cls ag_reuseIdentifier] forIndexPath:indexPath];
}

#pragma mark collection view header footer view
- (void)ag_registerFooterViewForClass:(Class<AGViewReusable>)cls
{
    [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (void)ag_registerNibFooterViewForClass:(Class<AGViewReusable>)cls
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[cls ag_resourceBundle]];
    [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (__kindof UICollectionReusableView *)ag_dequeueFooterViewWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                    withReuseIdentifier:[cls ag_reuseIdentifier]
                                           forIndexPath:indexPath];
}

#pragma mark - AGCollectionHeaderViewReusable
- (void)ag_registerHeaderViewForClass:(Class<AGViewReusable>)cls
{
    [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (void)ag_registerNibHeaderViewForClass:(Class<AGViewReusable>)cls
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[cls ag_resourceBundle]];
    [self registerNib:nib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (__kindof UICollectionReusableView *)ag_dequeueHeaderViewWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
    return [self dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                    withReuseIdentifier:[cls ag_reuseIdentifier]
                                           forIndexPath:indexPath];
}

@end
