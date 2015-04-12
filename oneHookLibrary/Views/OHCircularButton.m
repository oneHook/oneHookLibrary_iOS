//
//  OHCircularButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImage+Color.h"
#import "OHCircularButton.h"
#import "OneHookFoundation.h"

@interface OHCircularButton () {
    CGFloat _buttonScale;
}
@end

@implementation OHCircularButton

#define SHADOW_OPACITY 0.3f

- (id)init {
    self = [super init];
    if (self) {
        [self doInit];
    }
    return self;
}

- (void)doInit {

    self.button = [[UIButton alloc] init];
    [self addSubview:self.button];
    self.backgroundColor = [UIColor clearColor];
    self.button.clipsToBounds = YES;

    self.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 5);
    self.layer.shadowOpacity = SHADOW_OPACITY;
    self.layer.shadowRadius = 2.0;

    [self.button addTarget:self action:@selector(onPressed) forControlEvents:UIControlEventTouchDown];
    [self.button addTarget:self action:@selector(onRelease) forControlEvents:UIControlEventTouchCancel];
}

- (void)onPressed {
    self.layer.shadowOffset = CGSizeMake(0, 10);
}

- (void)onRelease {
    self.layer.shadowOffset = CGSizeMake(0, 5);
}

- (void)setButtonBackgroundWithNormalState:(UIColor *)normalColor pressedState:(UIColor *)pressedColor disabledState:(UIColor *)disabledColor {
    [self.button setBackgroundImage:[UIImage imageWithColor:normalColor] forState:UIControlStateNormal];
    [self.button setBackgroundImage:[UIImage imageWithColor:pressedColor] forState:UIControlStateHighlighted];
    [self.button setBackgroundImage:[UIImage imageWithColor:disabledColor] forState:UIControlStateDisabled];
}

- (void)setButtonTextColorWithNormalState:(UIColor *)normalColor pressedState:(UIColor *)pressedColor disabledState:(UIColor *)disabledColor {
    [self.button setTitleColor:normalColor forState:UIControlStateNormal];
    [self.button setTitleColor:pressedColor forState:UIControlStateHighlighted];
    [self.button setTitleColor:disabledColor forState:UIControlStateDisabled];
}

- (void)setButtonTextWithNormalState:(NSString *)normalText pressedState:(NSString *)pressedText disabledState:(NSString *)disabledText {
    [self.button setTitle:normalText forState:UIControlStateNormal];
    [self.button setTitle:pressedText forState:UIControlStateHighlighted];
    [self.button setTitle:disabledText forState:UIControlStateDisabled];
}

- (void)setButtonAttributedTextWithNormalState:(NSAttributedString *)normalText pressedState:(NSAttributedString *)pressedText disabledState:(NSAttributedString *)disabledText {
    [self.button setAttributedTitle:normalText forState:UIControlStateNormal];
    [self.button setAttributedTitle:pressedText forState:UIControlStateHighlighted];
    [self.button setAttributedTitle:disabledText forState:UIControlStateDisabled];
}

- (void)setButtonTextWithAllState:text {
    [self.button setTitle:text forState:UIControlStateNormal];
}

- (void)addGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer {
    [self.button addGestureRecognizer:gestureRecognizer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.button.frame = self.bounds;
    [self.button.layer setCornerRadius:ViewWidth(self.button) / 2];
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:100.0].CGPath;
}

@end
