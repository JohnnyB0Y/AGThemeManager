//
//  UITableView+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/3/3.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "UITableView+AGViewModel.h"
#import "AGVMProtocol.h"

@implementation UITableView (AGViewModel)

#pragma mark - table view cell
- (void) ag_registerCellForClass:(Class<AGViewReusable>)cls
{
    [self registerClass:cls forCellReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (void) ag_registerNibCellForClass:(Class<AGViewReusable>)cls
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[cls ag_resourceBundle]];
    [self registerNib:nib forCellReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (__kindof UITableViewCell *) ag_dequeueCellWithClass:(Class<AGViewReusable>)cls for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 tableView。
    if ( indexPath ) {
        return [self dequeueReusableCellWithIdentifier:[cls ag_reuseIdentifier] forIndexPath:indexPath];
    }
    return [self dequeueReusableCellWithIdentifier:[cls ag_reuseIdentifier]];
}

#pragma mark - table view header footer view
- (void) ag_registerHeaderFooterViewForClass:(Class<AGViewReusable>)cls
{
    [self registerClass:cls forHeaderFooterViewReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (void) ag_registerNibHeaderFooterViewForClass:(Class<AGViewReusable>)cls
{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(cls) bundle:[cls ag_resourceBundle]];
    [self registerNib:nib forHeaderFooterViewReuseIdentifier:[cls ag_reuseIdentifier]];
}

- (__kindof UITableViewHeaderFooterView *) ag_dequeueHeaderFooterViewWithClass:(Class<AGViewReusable>)cls
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 tableView。
    return [self dequeueReusableHeaderFooterViewWithIdentifier:[cls ag_reuseIdentifier]];
}

@end
