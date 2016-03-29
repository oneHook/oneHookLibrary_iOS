//
//  OHSolidButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-03-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHSolidButton.h"

@interface OHSolidButton()

@property (strong, nonatomic) UIColor* normalBackgroundColor;
@property (strong, nonatomic) UIColor* activeBackgroundColor;
@property (strong, nonatomic) UIColor* disabledBackgroundColor;

@end

@implementation OHSolidButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    if(highlighted) {
        self.backgroundColor = self.activeBackgroundColor;
    } else {
        self.backgroundColor = self.normalBackgroundColor;
    }
}

- (void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if(enabled) {
        self.backgroundColor = self.normalBackgroundColor;
    } else {
        self.backgroundColor = self.disabledBackgroundColor;
    }
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state
{
    if(state == UIControlStateNormal) {
        self.normalBackgroundColor = color;
        if(self.isEnabled && !self.isHighlighted) {
            self.layer.borderColor = color.CGColor;
        }
    } else if(state == UIControlStateHighlighted) {
        self.activeBackgroundColor = color;
        if(self.isEnabled && self.isHighlighted) {
            self.layer.borderColor = color.CGColor;
        }
    } else if(state == UIControlStateDisabled) {
        self.disabledBackgroundColor = color;
        if(!self.isEnabled) {
            self.layer.borderColor = color.CGColor;
        }
    }
}

@end
