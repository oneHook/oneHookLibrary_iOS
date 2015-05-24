//
//  OHButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-26.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHButton.h"

@implementation OHButton

- (id)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.primaryColor = [UIColor blackColor];
    self.secondaryColor = [UIColor grayColor];
    self.backgroundColor = [UIColor grayColor];
    self.buttonStyle = kButtonStyleDefault;
}

- (void)setButtonStyle:(int)buttonStyle {
    _buttonStyle = buttonStyle;

    switch (_buttonStyle) {
        case kButtonStyleSolid:
            [self setTitleColor:self.primaryColor forState:UIControlStateNormal];
            [self setTitleColor:self.primaryColor forState:UIControlStateHighlighted];
            [self setTitleColor:self.primaryColor forState:UIControlStateDisabled];
            self.backgroundColor = self.buttonBackgroundColor;
            self.layer.borderWidth = 2;
            self.layer.borderColor = self.secondaryColor.CGColor;
            break;
        case kButtonStyleStroke:
            [self setTitleColor:self.primaryColor forState:UIControlStateNormal];
            [self setTitleColor:self.primaryColor forState:UIControlStateHighlighted];
            [self setTitleColor:self.primaryColor forState:UIControlStateDisabled];
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderWidth = 2;
            self.layer.borderColor = self.secondaryColor.CGColor;
            break;
        default:
        case kButtonStyleDefault:
            [self setTitleColor:self.primaryColor forState:UIControlStateNormal];
            [self setTitleColor:self.primaryColor forState:UIControlStateHighlighted];
            [self setTitleColor:self.primaryColor forState:UIControlStateDisabled];
            self.backgroundColor = [UIColor clearColor];
            self.layer.borderWidth = 0;
            break;
    }
}

- (void)setPrimaryColor:(UIColor *)primaryColor {
    _primaryColor = primaryColor;
    [self setButtonStyle:_buttonStyle];
}

- (void)setSecondaryColor:(UIColor *)secondaryColor {
    _secondaryColor = secondaryColor;
    [self setButtonStyle:_buttonStyle];
}

- (void)setButtonBackgroundColor:(UIColor *)buttonBackgroundColor {
    _buttonBackgroundColor = buttonBackgroundColor;
    [self setButtonStyle:_buttonStyle];
}
@end
