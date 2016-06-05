//
//  OHViewControllerWithToolbar.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHViewControllerWithToolbar.h"

@implementation OHViewControllerWithToolbar

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupToolbar];
}

- (void)setupToolbar
{
    self.toolbar = [[OHToolbar alloc] init];
    [self.view addSubview:self.toolbar];
}

- (void)viewWillLayoutSubviews
{
    
}

@end
