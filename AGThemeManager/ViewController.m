//
//  ViewController.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "ViewController.h"
#import "AGMainTableViewController.h"
#import "AGMainImageCell.h"
#import "AGMainMessageCell.h"
#import "AGThemeKit.h"
#import "AGCustomThemeConstKeys.h"
#import "AGThemePackCollectionViewController.h"

@interface ViewController ()
<UITableViewDataSource, UITableViewDelegate>

/** table view */
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:AGMainImageCell.class forCellReuseIdentifier:NSStringFromClass(AGMainImageCell.class)];
    [self.tableView registerClass:AGMainMessageCell.class forCellReuseIdentifier:NSStringFromClass(AGMainMessageCell.class)];
    
    
    [self setup];
    
}

- (void)setup
{
    self.title = @"首页";
    
    [self.view addSubview:self.tableView];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"更换主题" style:UIBarButtonItemStyleDone target:self action:@selector(rightItemClick:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self ag_themeAddSupport];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection
{
    [super traitCollectionDidChange:previousTraitCollection];
    
    [self.tableView reloadData];
}

#pragma mark - ----------- Event Methods -----------
- (void)rightItemClick:(UIBarButtonItem *)item
{
    AGThemePackCollectionViewController *vc = [AGThemePackCollectionViewController themePackCollectionViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 24;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AGMainImageCell *cell;
    if ( indexPath.row % 2 == 0 ) {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AGMainImageCell.class)];
    }
    else {
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(AGMainMessageCell.class)];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    AGMainTableViewController *vc = [[AGMainTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ----------- Getter Methods -----------
- (UITableView *)tableView
{
    if ( nil == _tableView ) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
