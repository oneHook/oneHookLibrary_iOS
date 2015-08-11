//
//  OHProgressBar.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-11.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHProgressBar.h"

@interface OHProgressBar() {
    CALayer* _mainProgressLayer;
    CALayer* _subProgressLayer;
}

@end

@implementation OHProgressBar

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self) {
        _mainProgressLayer = [[CALayer alloc] init];
        _subProgressLayer = [[CALayer alloc] init];
        
        [self.layer addSublayer:_subProgressLayer];
        [self.layer addSublayer:_mainProgressLayer];
        
        self.mainProgressColor = [UIColor redColor];
        self.subProgressColor = [UIColor redColor];
        self.mainProgress = 0.75;
        self.subProgress = 0.5;
        
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)dealloc
{
    [_mainProgressLayer removeFromSuperlayer];
    _mainProgressLayer = nil;
    [_subProgressLayer removeFromSuperlayer];
    _subProgressLayer = nil;
}

- (void)setMainProgressColor:(UIColor *)mainProgressColor
{
    _mainProgressColor = mainProgressColor;
    _mainProgressLayer.backgroundColor = mainProgressColor.CGColor;
}

- (void)setSubProgressColor:(UIColor *)subProgressColor
{
    _subProgressColor = subProgressColor;
    _subProgressLayer.backgroundColor = subProgressColor.CGColor;
}

- (void)setMainProgress:(CGFloat)mainProgress
{
    _mainProgress = mainProgress;
    [self layoutSublayersOfLayer:_mainProgressLayer];
}

- (void)setSubProgress:(CGFloat)subProgress
{
    _subProgress = subProgress;
    [self layoutSublayersOfLayer:_subProgressLayer];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [CATransaction begin];
    [CATransaction setAnimationDuration:0];
    CGFloat width = CGRectGetWidth(self.bounds);
    if(layer == _mainProgressLayer) {
        _mainProgressLayer.frame = CGRectMake(0, 0, width * _mainProgress, CGRectGetHeight(self.bounds));
    } else if(layer == _subProgressLayer) {
        _subProgressLayer.frame = CGRectMake(0, 0, width * _subProgress, CGRectGetHeight(self.bounds));
    }
    [CATransaction commit];
}

- (void)setMainProgress:(CGFloat)mainProgress subProgress:(CGFloat)subProgress animated:(BOOL)animated
{
    
}

@end
