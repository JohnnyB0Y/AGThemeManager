//
//  UITableViewHeaderFooterView+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2018/2/10.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import "UITableViewHeaderFooterView+AGViewModel.h"
#import "UIScreen+AGViewModel.h"

@implementation UITableViewHeaderFooterView (AGViewModel)

#pragma mark - AGTableHeaderFooterViewReusable
+ (NSString *) ag_reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (void) ag_registerHeaderFooterViewBy:(UITableView *)tableView
{
    // 有特殊需求，请在子类重写。
    if ( [self ag_canAwakeNibInBundle:[self ag_resourceBundle]] ) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[self ag_resourceBundle]];
        [tableView registerNib:nib forHeaderFooterViewReuseIdentifier:[self ag_reuseIdentifier]];
    }
    else {
        [tableView registerClass:[self class] forHeaderFooterViewReuseIdentifier:[self ag_reuseIdentifier]];
    }
}

+ (instancetype) ag_dequeueHeaderFooterViewBy:(UITableView *)tableView
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 tableView。
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:[self ag_reuseIdentifier]];
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
