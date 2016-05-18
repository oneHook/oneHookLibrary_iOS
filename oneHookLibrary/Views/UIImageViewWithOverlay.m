//
//  UIImageViewWithOverlay.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImageViewWithOverlay.h"

@interface UIImageViewWithOverlay() {
    
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

- (void)commonInit
{
    self.clipsToBounds = YES;
}

- (void)dealloc
{
    if(_solidOverlayLayer) {
        [_solidOverlayLayer removeFromSuperlayer];
    }
    if(_gradientOverlayLayer) {
        [_gradientOverlayLayer removeFromSuperlayer];
    }
}

- (CALayer*)solidOverlayLayer
{
    if(!_solidOverlayLayer) {
        _solidOverlayLayer = [[CALayer alloc] init];
        _solidOverlayLayer.backgroundColor = [UIColor colorWithWhite:0 alpha:0.25].CGColor;
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"onOrderIn",
                                           [NSNull null], @"onOrderOut",
                                           [NSNull null], @"sublayers",
                                           [NSNull null], @"contents",
                                           [NSNull null], @"bounds",
                                           nil];
        _solidOverlayLayer.actions = newActions;
        [self.layer addSublayer:_solidOverlayLayer];
    }
    return _solidOverlayLayer;
}

- (CAGradientLayer*)gradientOverlayLayer
{
    if(!_gradientOverlayLayer) {
        _gradientOverlayLayer = [[CAGradientLayer alloc] init];
        _gradientOverlayLayer.colors = [NSArray arrayWithObjects:(id)([UIColor clearColor].CGColor),
                                        (id)([UIColor colorWithWhite:0 alpha:0.8].CGColor), nil];
        NSMutableDictionary *newActions = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[NSNull null], @"onOrderIn",
                                           [NSNull null], @"onOrderOut",
                                           [NSNull null], @"sublayers",
                                           [NSNull null], @"contents",
                                           [NSNull null], @"bounds",
                                           nil];
        _gradientOverlayLayer.actions = newActions;
        [self.layer addSublayer:_gradientOverlayLayer];
    }
    return _gradientOverlayLayer;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_solidOverlayLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions: YES];
        _solidOverlayLayer.frame = self.bounds;
        [CATransaction commit];
    }
    
    if(_gradientOverlayLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions: YES];
        _gradientOverlayLayer.frame = self.bounds;
        [CATransaction commit];
    }
}

@end
