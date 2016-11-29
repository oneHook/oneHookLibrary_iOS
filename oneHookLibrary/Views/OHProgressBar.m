//
//  OHProgressBar.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-11.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHProgressBar.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

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
        self.backgroundColor = [UIColor clearColor];
        _mainProgressLayer = [[CAShapeLayer alloc] init];
        _subProgressLayer = [[CAShapeLayer alloc] init];
        
        _mainProgressLayer.anchorPoint = CGPointMake(0, 0.5);
        _subProgressLayer.anchorPoint = CGPointMake(0, 0.5);
        
        [self.layer addSublayer:_subProgressLayer];
        [self.layer addSublayer:_mainProgressLayer];
        
        self.mainProgressColor = [UIColor yellowColor];
        self.subProgressColor = [UIColor greenColor];
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
//    [CATransaction begin];
//    [CATransaction setAnimationDuration:0];
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds);
    NSLog(@"progress %f %f %f %f", _mainProgress, _subProgress, width, height);
    if(layer == self.layer) {

        CGFloat mainProgressHeight = height * 0.85;
        _mainProgressLayer.bounds = CGRectMake(0, 0, (width - height + mainProgressHeight) * _mainProgress, mainProgressHeight);
        _mainProgressLayer.position = CGPointMake((height - mainProgressHeight) / 2, height / 2);
        _mainProgressLayer.cornerRadius = mainProgressHeight / 2;
        
        _subProgressLayer.bounds = CGRectMake(0, 0, width * _subProgress, height);
        _subProgressLayer.position = CGPointMake(0, height / 2);
        _subProgressLayer.cornerRadius = height / 2;
    }
//    [CATransaction commit];
}

- (void)setMainProgress:(CGFloat)mainProgress subProgress:(CGFloat)subProgress animated:(BOOL)animated
{
    [self layoutSublayersOfLayer:self.layer];
}

@end
