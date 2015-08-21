//
//  UIImageViewWithOverlay.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImageViewWithOverlay.h"

@interface UIImageViewWithOverlay() {

    CALayer* _overlayLayer;
}

@end

@implementation UIImageViewWithOverlay

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc
{
    [_overlayLayer removeFromSuperlayer];
    _overlayLayer = nil;
}

- (void)commonInit {
    self.clipsToBounds = YES;
    _overlayLayer = [[CALayer alloc] init];
    _overlayLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5].CGColor;
    [self.layer addSublayer:_overlayLayer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _overlayLayer.frame = self.bounds;
}

@end
