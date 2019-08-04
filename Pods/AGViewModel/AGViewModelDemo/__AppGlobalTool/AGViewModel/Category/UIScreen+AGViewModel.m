//
//  UIScreen+AGViewModel.m
//  
//
//  Created by JohnnyB0Y on 2019/1/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIScreen+AGViewModel.h"

@implementation UIScreen (AGViewModel)

#pragma mark - ----------- Getter Methods ----------
- (CGFloat)width
{
    return CGRectGetWidth(self.bounds);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.bounds);
}

- (UIDeviceOrientation)deviceOrientation
{
    return [UIDevice currentDevice].orientation;
}

- (UIInterfaceOrientation)statusBarOrientation
{
    return [UIApplication sharedApplication].statusBarOrientation;
}

@end
