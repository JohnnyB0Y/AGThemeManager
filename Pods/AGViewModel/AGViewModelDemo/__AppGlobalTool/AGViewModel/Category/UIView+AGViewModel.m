//
//  UIView+AGViewModel.m
//  
//
//  Created by JohnnyB0Y on 2018/2/12.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import "UIView+AGViewModel.h"
#import <objc/runtime.h>

static void *kAGViewModelProperty = &kAGViewModelProperty;

@implementation UIView (AGViewModel)

#pragma mark - ---------- Public Methods ----------
+ (NSString *)ag_reuseIdentifier
{
    return NSStringFromClass(self);
}

+ (BOOL)ag_canAwakeNibInBundle:(NSBundle *)bundle
{
    if ( nil == bundle ) {
        bundle = [self ag_resourceBundle];
    }
    NSString *className = NSStringFromClass([self class]);
    NSString *nibPath = [bundle pathForResource:className ofType:@"nib"];
    if ( nil == nibPath ) {
        nibPath = [bundle pathForResource:className ofType:@"xib"];
    }
    return nibPath != nil;
}

+ (instancetype)ag_newFromNibInBundle:(NSBundle *)bundle
{
    if ( nil == bundle ) {
        bundle = [self ag_resourceBundle];
    }
    UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:bundle];
    return [[nib instantiateWithOwner:self options:nil] firstObject];
}

+ (NSBundle *)ag_resourceBundle
{
    return [NSBundle mainBundle];
}


#pragma mark - ----------- Getter Setter Methods ----------
- (void)setViewModel:(AGViewModel *)viewModel
{
    objc_setAssociatedObject(self, kAGViewModelProperty, viewModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AGViewModel *)viewModel
{
    return objc_getAssociatedObject(self, kAGViewModelProperty);
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    [self setCenter:CGPointMake(centerX, self.centerY)];
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    [self setCenter:CGPointMake(self.centerX, centerY)];
}

#pragma mark Override Methods
- (void) ag_addSubviews {}
- (void) ag_layoutSubviews {}
- (void) ag_setupUI {}
- (void) ag_addActions {}

@end
