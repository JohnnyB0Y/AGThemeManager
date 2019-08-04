//
//  UIScreen+AGViewModel.h
//  
//
//  Created by JohnnyB0Y on 2019/1/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScreen (AGViewModel)

@property(nonatomic, assign, readonly) UIInterfaceOrientation statusBarOrientation;
@property(nonatomic, assign, readonly) UIDeviceOrientation deviceOrientation;
@property(nonatomic, assign, readonly) CGFloat width;
@property(nonatomic, assign, readonly) CGFloat height;

@end

NS_ASSUME_NONNULL_END
