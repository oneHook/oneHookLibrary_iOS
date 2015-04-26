//
//  OHHamburgerButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-25.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHHamburgerButton : UIButton

typedef enum {
    kHamburgerButtonTransitionToBack,
    kHamburgerButtonTransitionToDismiss,
    kHamburgerButtonTransitionToForward
} OHHamburgerButtonTransitionTo;

typedef enum {
    kHamburgerButtonStyleCircle,
    kHamburgerButtonStyleClear
} OHHamburgerButtonStyle;

@property (assign, nonatomic) OHHamburgerButtonTransitionTo hamburgerButtonTransitionTo;
@property (assign, nonatomic) OHHamburgerButtonStyle hamburgerButtonStyle;
@property (assign, nonatomic) UIColor *hamburgerButtonColor;
@property (assign, nonatomic) double hamburgerButtonStrokeWidthConstant;
@property (assign, nonatomic) BOOL showMenu;

@end
