//
//  OHButtonDemoViewController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHButtonDemoViewController.h"

@interface OHButtonDemoViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation OHButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
}

@end
