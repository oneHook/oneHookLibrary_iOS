//
//  OHProgressBar.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-11.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHProgressBar.h"

//#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

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
        _padding = 0;
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
    CGFloat width = CGRectGetWidth(self.bounds) - _padding * 2;
    CGFloat height = CGRectGetHeight(self.bounds) - _padding * 2;
    if(layer == self.layer) {

        CGFloat mainProgressHeight = height * 0.85;
        _mainProgressLayer.bounds = CGRectMake(0,
                                               0,
                                               (width - (height - mainProgressHeight)) * _mainProgress,
                                               mainProgressHeight);
        _mainProgressLayer.position = CGPointMake((height - mainProgressHeight) / 2 + _padding,
                                                  height / 2 + _padding);
        _mainProgressLayer.cornerRadius = mainProgressHeight / 2;
        
        _subProgressLayer.bounds = CGRectMake(0,
                                              0,
                                              width * _subProgress,
                                              height);
        _subProgressLayer.position = CGPointMake(_padding, height / 2 + _padding);
        _subProgressLayer.cornerRadius = height / 2;
    }
}

- (void)setMainProgress:(CGFloat)mainProgress subProgress:(CGFloat)subProgress animated:(BOOL)animated
{
    if(mainProgress > 0) {
        mainProgress = 1;
    } else if(mainProgress < 0) {
        mainProgress = 0;
    }
    
    if(subProgress > 0) {
        subProgress = 1;
    } else if(subProgress < 0) {
        subProgress = 0;
    }
    _mainProgress = mainProgress;
    _subProgress = subProgress;
    [self layoutSublayersOfLayer:self.layer];
}

- (void)setPadding:(CGFloat)padding
{
    _padding = padding;
    [self layoutSublayersOfLayer:self.layer];
}

@end
