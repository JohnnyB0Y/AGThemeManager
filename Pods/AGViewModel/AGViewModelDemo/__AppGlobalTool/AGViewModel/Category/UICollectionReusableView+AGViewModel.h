//
//  UICollectionReusableView+AGViewModel.h
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2018/2/10.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+AGViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionReusableView (AGViewModel)
<AGCollectionFooterViewReusable, AGCollectionHeaderViewReusable>

@end

NS_ASSUME_NONNULL_END
