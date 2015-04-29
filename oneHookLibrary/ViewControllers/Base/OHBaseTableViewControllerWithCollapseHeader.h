//
//  OHBaseTableViewControllerWithCollapseHeaderViewController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-28.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHBaseTableViewControllerWithCollapseHeader : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView *headerView;

- (UIView *)onCreateHeaderView;
- (CGFloat)headerViewHight;

@end
