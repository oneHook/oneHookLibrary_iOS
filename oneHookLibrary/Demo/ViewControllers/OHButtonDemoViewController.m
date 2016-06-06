//
//  OHButtonDemoViewController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-05-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHButtonDemoViewController.h"
//#import "OHButton.h"

@interface OHButtonDemoViewController ()

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) NSMutableArray *buttons;

@end

@implementation OHButtonDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];

    self.buttons = [[NSMutableArray alloc] init];

//    OHButton *button = [[OHButton alloc] init];
//    button.buttonStyle = kButtonStyleDefault;
//    [button setTitle:@"Default" forState:UIControlStateNormal];
//    [self.buttons addObject:button];
//    [self.scrollView addSubview:button];
//
//    button = [[OHButton alloc] init];
//    button.primaryColor = [UIColor blackColor];
//    button.buttonBackgroundColor = [UIColor grayColor];
//    button.secondaryColor = [UIColor blackColor];
//    button.buttonStyle = kButtonStyleSolid;
//    [button setTitle:@"Solid" forState:UIControlStateNormal];
//    button.layer.cornerRadius = 15;
//    [self.buttons addObject:button];
//    [self.scrollView addSubview:button];
//
//    button = [[OHButton alloc] init];
//    button.primaryColor = [UIColor blackColor];
//    button.secondaryColor = [UIColor blackColor];
//    button.layer.cornerRadius = 15;
//    button.buttonStyle = kButtonStyleStroke;
//    [button setTitle:@"Stroke" forState:UIControlStateNormal];
//    [self.buttons addObject:button];
//    [self.scrollView addSubview:button];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;

    CGFloat currentY = 50;
    CGFloat totalContentY = 0;
//    for (OHButton *button in self.buttons) {
//        button.frame = CGRectMake((self.view.bounds.size.width - 96) / 2, currentY, 96, 48);
//        currentY += 48 + 12;
//        totalContentY = currentY;
//    }

    self.scrollView.contentSize = CGSizeMake(0, totalContentY);
}

@end
