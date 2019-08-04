//
//  UITableViewCell+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2018/2/9.
//  Copyright © 2018年 JohnnyB0Y. All rights reserved.
//

#import "UITableViewCell+AGViewModel.h"
#import "UIScreen+AGViewModel.h"

@implementation UITableViewCell (AGViewModel)

#pragma mark - ---------- AGTableCellReusable ----------
+ (NSString *) ag_reuseIdentifier
{
	return NSStringFromClass([self class]);
}

+ (void) ag_registerCellBy:(UITableView *)tableView
{
    // 有特殊需求，请在子类重写。
    if ( [self ag_canAwakeNibInBundle:[self ag_resourceBundle]] ) {
        UINib *nib = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:[self ag_resourceBundle]];
		[tableView registerNib:nib forCellReuseIdentifier:[self ag_reuseIdentifier]];
	}
	else {
		[tableView registerClass:[self class] forCellReuseIdentifier:[self ag_reuseIdentifier]];
	}
}

+ (instancetype) ag_dequeueCellBy:(UITableView *)tableView for:(NSIndexPath *)indexPath
{
    // 如果在此处奔溃，请优先检查视图是否已注册到 tableView。
    if ( indexPath ) {
        return [tableView dequeueReusableCellWithIdentifier:[self ag_reuseIdentifier] forIndexPath:indexPath];
    }
    return [tableView dequeueReusableCellWithIdentifier:[self ag_reuseIdentifier]];
}

#pragma mark - ----------- AGVMResponsive -----------
- (CGSize) ag_viewModel:(AGViewModel *)vm sizeForLayout:(UIScreen *)screen
{
    // 有特殊需求，请在子类重写。
    CGFloat height = [vm[kAGVMViewH] floatValue];
    CGSize bvS = CGSizeMake(screen.width, height);
    if ( height <= 0 ) {
        bvS.height = 44.;
    }
    return bvS;
}

@end
