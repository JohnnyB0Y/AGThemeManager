//
//  UIViewController+AGViewModel.m
//
//
//  Created by JohnnyB0Y on 2019/1/3.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UIViewController+AGViewModel.h"
#import <objc/runtime.h>

static void *kAGContextProperty = &kAGContextProperty;

@implementation UIViewController (AGViewModel)


#pragma mark - ----------- Life Cycle ----------
+ (instancetype)newWithContext:(AGViewModel *)context
{
    return [[self alloc] initWithContext:context];
}

/** 从Storyboard文件创建控制器 和 传递contextVM */
+ (instancetype) newFromStoryboardWithContext:(nullable AGViewModel *)context
{
    NSBundle *bundle = [self ag_resourceBundle];
    NSString *clsName = NSStringFromClass(self);
    UIViewController *vc = [self _instanceCreateFromStoryboardWithName:clsName bundle:bundle];
    [vc setContext:context];
    return vc;
}

/** 从Nib文件创建控制器 和 传递contextVM */
+ (instancetype) newFromNibWithContext:(nullable AGViewModel *)context
{
    NSBundle *bundle = [self ag_resourceBundle];
    NSString *clsName = NSStringFromClass(self);
    UIViewController *vc = [self _instanceCreateFromNibWithName:clsName bundle:bundle];
    [vc setContext:context];
    return vc;
}

- (instancetype) initWithContext:(AGViewModel *)context
{
    UIViewController *vc = [self init];
    [vc setContext:context];
    return vc;
}

#pragma mark - ---------- Private Methods ----------
+ (instancetype) _instanceCreateFromStoryboardWithName:(NSString *)clsName bundle:(NSBundle *)bundle
{
    // 从 storyboard 创建
    NSString *sbPath = [bundle pathForResource:clsName ofType:@"storyboard"];
    if ( sbPath ) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:clsName bundle:bundle];
        return [sb instantiateInitialViewController];
    }
    return nil;
}

+ (instancetype) _instanceCreateFromNibWithName:(NSString *)clsName bundle:(NSBundle *)bundle
{
    // 从 nib 创建
    NSString *nibPath = [bundle pathForResource:clsName ofType:@"nib"];
    if ( nibPath ) {
        return [[self alloc] initWithNibName:clsName bundle:bundle];
    }
    return nil;
}

#pragma mark Override Methods
+ (NSBundle *)ag_resourceBundle
{
    return [NSBundle mainBundle];
}

- (void) ag_addSubviews {}
- (void) ag_layoutSubviews {}
- (void) ag_setupUI {}
- (void) ag_addActions {}

#pragma mark - ----------- Getter Methods ----------
- (AGViewModel *)context
{
    return objc_getAssociatedObject(self, kAGContextProperty);
}

#pragma mark - ----------- Setter Methods ----------
- (void)setContext:(AGViewModel *)context
{
    objc_setAssociatedObject(self, kAGContextProperty, context, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
