//
//  OHBaseTableViewControllerWithCollapseHeaderViewController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-28.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHBaseTableViewControllerWithCollapseHeader.h"
#import "OneHookFoundation.h"

@interface OHBaseTableViewControllerWithCollapseHeader () {
    CGFloat _headerHeight;
}

@end

@implementation OHBaseTableViewControllerWithCollapseHeader

- (void)viewDidLoad {
    [super viewDidLoad];

    /* setup table view */
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    /* setup header view */
    self.headerView = [self onCreateHeaderView];
    _headerHeight = [self headerViewHight];

    if (self.headerView) {
        [self.view addSubview:self.headerView];
        self.tableView.contentInset = UIEdgeInsetsMake(_headerHeight, 0, 0, 0);
        self.tableView.contentOffset = CGPointMake(0, -_headerHeight);
    }
    [self.view addSubview:self.tableView];
    [self.view bringSubviewToFront:self.headerView];

    self.navigationBarBackground = [[UIView alloc] init];
    self.navigationBarBackground.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navigationBarBackground];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    [self invalidateHeaderViewPosition:self.tableView.contentOffset.y];
    self.navigationBarBackground.frame = CGRectMake(0, 0, self.view.bounds.size.width, NAVIGATION_BAR_HEIGHT + STATUS_BAR_HEIGHT);
}

- (UIView *)onCreateHeaderView {
    return nil;
}

- (CGFloat)headerViewHight {
    return 0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self invalidateHeaderViewPosition:scrollView.contentOffset.y];
}

- (void)invalidateHeaderViewPosition:(CGFloat)tableViewContentOffset {
    CGFloat yOffset = tableViewContentOffset + _headerHeight;
    self.headerView.frame = CGRectMake(0, MIN(0, -yOffset), self.view.bounds.size.width, MAX(_headerHeight - yOffset, _headerHeight));

    CGFloat navigationBarAlpha = yOffset / _headerHeight;
    self.navigationBarBackground.alpha = navigationBarAlpha;
}

#pragma marks - UITableViewDatasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
