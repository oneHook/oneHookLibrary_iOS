//
//  OHButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-26.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHButton : UIButton

/* use primary color for text, ignore secondary color and background color */
#define kButtonStyleDefault 0

/* use primary color for text, secondary color for border, background color for background */
#define kButtonStyleSolid 1

/* use primary color for text, secondary color for border, ignore background color */
#define kButtonStyleStroke 2

@property (assign, nonatomic) int buttonStyle;
@property (strong, nonatomic) UIColor *primaryColor;
@property (strong, nonatomic) UIColor *secondaryColor;
@property (strong, nonatomic) UIColor *backgroundColor;

@end
