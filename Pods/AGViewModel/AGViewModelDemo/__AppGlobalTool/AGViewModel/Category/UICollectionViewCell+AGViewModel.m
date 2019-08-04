//
//  UICollectionViewCell+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2018/2/9.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import "UICollectionViewCell+AGViewModel.h"
#import "UIScreen+AGViewModel.h"

@implementation UICollectionViewCell (AGViewModel)

#pragma mark - ---------- AGCollectionCellProtocol ----------
+ (NSString *) ag_reuseIdentifier
{
	return NSStringFromClass([self class]);
}

+ (void) ag_registerCellBy:(UICollectionView *)collectionView
{
    // 有特殊需求，请在子类重写。
    if ( [self ag_canAwakeNibInBundle:[self ag_resourceBundle]] ) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[self ag_resourceBundle]];
		[collectionView registerNib:nib forCellWithReuseIdentifier:[self ag_reuseIdentifier]];
	}
	else {
		[collectionView registerClass:[self class] forCellWithReuseIdentifier:[self ag_reuseIdentifier]];
	}
}

+ (instancetype) ag_dequeueCellBy:(UICollectionView *)collectionView for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 collectionView。
	return [collectionView dequeueReusableCellWithReuseIdentifier:[self ag_reuseIdentifier] forIndexPath:indexPath];
}

#pragma mark - ----------- AGVMResponsive -----------
- (CGSize) ag_viewModel:(AGViewModel *)vm sizeForLayout:(UIScreen *)screen
{
    // 有特殊需求，请在子类重写。
    CGFloat height = [vm[kAGVMViewH] floatValue];
    CGFloat width = [vm[kAGVMViewW] floatValue];
    CGSize bvS = CGSizeMake(width, height);
    if ( height <= 0 ) {
        bvS.height = 54.;
    }
    if ( width <= 0 ) {
        bvS.width = 54.;
    }
    return bvS;
}

@end
