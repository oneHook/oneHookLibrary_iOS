//
//  OHHambugerButtonDemo.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-25.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHHambugerButtonDemo.h"
#import "OHHamburgerToBackButton.h"
#import "OHHamburgerToDismissButton.h"
#import "OHHamburgerButton.h"

@interface OHHambugerButtonDemo ()

@property (strong, nonatomic) NSMutableArray *hamburgerToDismissButtons;
@property (strong, nonatomic) NSMutableArray *hamburgerToBackButtons;
@property (strong, nonatomic) NSMutableArray *hamburgerButtons;

@end

@implementation OHHambugerButtonDemo

- (void)viewDidLoad {
    [super viewDidLoad];

    self.hamburgerToBackButtons = [[NSMutableArray alloc] init];
    self.hamburgerToDismissButtons = [[NSMutableArray alloc] init];
    self.hamburgerButtons = [[NSMutableArray alloc] init];

    for (int i = 1; i < 5; i++) {
        OHHamburgerToBackButton *b = (OHHamburgerToBackButton *)[self.view viewWithTag:(100 + i)];
        [self.hamburgerToBackButtons addObject:b];
        [b addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
    }

    for (int i = 1; i < 5; i++) {
        OHHamburgerToDismissButton *b = (OHHamburgerToDismissButton *)[self.view viewWithTag:(200 + i)];
        [self.hamburgerToDismissButtons addObject:b];
        [b addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
    }

    for (int i = 1; i < 5; i++) {
        OHHamburgerButton *b = (OHHamburgerButton *)[self.view viewWithTag:(300 + i)];
        [self.hamburgerButtons addObject:b];
        [b addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clicked:)]];
    }
}

- (void)clicked:(UITapGestureRecognizer *)rec {
    for (OHHamburgerToBackButton *b in self.hamburgerToBackButtons) {
        b.showMenu = !b.showMenu;
    }
    for (OHHamburgerToDismissButton *b in self.hamburgerToDismissButtons) {
        b.showMenu = !b.showMenu;
    }
    for (OHHamburgerButton *b in self.hamburgerButtons) {
        b.showMenu = !b.showMenu;
    }
}

@end
