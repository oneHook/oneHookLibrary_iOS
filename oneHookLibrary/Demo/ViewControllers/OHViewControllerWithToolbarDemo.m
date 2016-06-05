//
//  OHViewControllerWithToolbarDemo.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHViewControllerWithToolbarDemo.h"

@interface OHViewControllerWithToolbarDemo() <UITableViewDelegate, UITableViewDataSource> {
    
}

@property (strong, nonatomic) UITableView* tableView;

@end

@implementation OHViewControllerWithToolbarDemo

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[OHViewControllerWithToolbarDemoCell class] forCellReuseIdentifier:@"Cell"];
    
    self.contentScrollableView = self.tableView;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OHViewControllerWithToolbarDemoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    } else {
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

@end

@implementation OHViewControllerWithToolbarDemoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        
    }
    return self;
}


@end