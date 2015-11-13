//
//  OHAnimatedProgressRing.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-11-12.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHAnimatedProgressRing.h"

#define STROKE_LEGNTH (CGRectGetWidth(self.frame) / 8)

@interface OHAnimatedProgressRing() {
    CGFloat _lastWidth;
}

@property (weak, nonatomic) CAShapeLayer* shapeLayer;

@end

@implementation OHAnimatedProgressRing

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

- (CGMutablePathRef)createPath {
    CGFloat length = CGRectGetWidth(self.frame);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake(STROKE_LEGNTH / 2,
                                                 STROKE_LEGNTH / 2,
                                                 length - STROKE_LEGNTH,
                                                 length - STROKE_LEGNTH));
    return path;
}

- (void)commonInit {
    _lastWidth = -1;
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    self.progressColor = [UIColor yellowColor];
    self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
}

- (void)layoutSubviews
{
    CGFloat width = CGRectGetWidth(self.frame);
    if(_lastWidth != width) {
        if(self.shapeLayer.path != nil) {
            CGPathRelease(self.shapeLayer.path);
            self.shapeLayer.path = nil;
        }
        self.shapeLayer.path = [self createPath];
        self.shapeLayer.fillColor = nil;
        self.shapeLayer.strokeColor = self.progressColor.CGColor;
        self.shapeLayer.lineWidth = width / 8;
        self.shapeLayer.lineCap = kCALineCapRound;
        self.shapeLayer.masksToBounds = YES;
        self.shapeLayer.frame = self.bounds;
        self.shapeLayer.actions = @{ @"strokeStart" : [NSNull null],
                                     @"strokeEnd" : [NSNull null],
                                     @"strokeColor" : [NSNull null],
                                     @"transform" : [NSNull null] };
        self.shapeLayer.strokeStart = self.progress;
    }
}

- (void)setProgress:(CGFloat)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    _progress = progress;
    if(animated) {
        
    } else {
        self.shapeLayer.strokeStart = progress;
    }
}

- (void)hideProgressRing
{
    [self hideProgressRingWithDuration:0.4];
}

- (void)hideProgressRingWithDuration:(double)duration
{
    CABasicAnimation *an = [[CABasicAnimation alloc] init];
    an.keyPath = @"strokeStart";
    an.duration = duration;
    an.fromValue = [NSNumber numberWithFloat:_progress];
    an.toValue = [NSNumber numberWithFloat:1.0];
    an.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:-0.8:0.5:1.85];
    self.shapeLayer.strokeStart = 1.0f;
    [self.shapeLayer addAnimation:an forKey:@"strokeStart"];
    _progress = 1.0;
}

- (void)revealProgressRing
{
    [self revealProgressRingWithDuration:0.4];
}

- (void)revealProgressRingWithDuration:(double)duration
{
    CABasicAnimation *an = [[CABasicAnimation alloc] init];
    an.keyPath = @"strokeStart";
    an.duration = duration;
    an.fromValue = [NSNumber numberWithFloat:_progress];
    an.toValue = [NSNumber numberWithFloat:0.0];
    an.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:-0.8:0.5:1.85];
    self.shapeLayer.strokeStart = 0.0f;
    [self.shapeLayer addAnimation:an forKey:@"strokeStart"];
    _progress = 0.0;
}

- (void)setProgressColor:(UIColor *)progressColor
{
    _progressColor = progressColor;
    self.shapeLayer.strokeColor = progressColor.CGColor;
}

@end
