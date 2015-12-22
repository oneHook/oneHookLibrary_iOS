//
//  OHAnimatedProgressRing.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-11-12.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHAnimatedProgressRing.h"

#define STROKE_LEGNTH _strokeLength

@interface OHAnimatedProgressRing() {
    CGFloat _lastWidth;
    CGFloat _strokeLength;
}

@property (weak, nonatomic) CAShapeLayer* shapeLayer;

@end

@implementation OHAnimatedProgressRing

- (id)init {
    self = [super init];
    if (self) {
        [self commonInitWithStrokeLength:24];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInitWithStrokeLength:24];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithStrokeLength:24];
    }
    return self;
}

- (id)initWithStrokeLength:(CGFloat)strokeLength {
    self = [super initWithFrame:CGRectZero];
    if(self) {
        [self commonInitWithStrokeLength:strokeLength];
    }
    return self;
}

- (CGMutablePathRef)createPath CF_RETURNS_RETAINED {
    CGFloat length = CGRectGetWidth(self.frame);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, nil, CGRectMake(STROKE_LEGNTH / 2,
                                                 STROKE_LEGNTH / 2,
                                                 length - STROKE_LEGNTH,
                                                 length - STROKE_LEGNTH));
    return path;
}

- (void)commonInitWithStrokeLength:(CGFloat)strokeLen {
    _lastWidth = -1;
    _strokeLength = strokeLen;
    
    CAShapeLayer* shapeLayer = [[CAShapeLayer alloc] init];
    self.shapeLayer = shapeLayer;
    [self.layer addSublayer:shapeLayer];
    self.progressColor = [UIColor yellowColor];
    self.transform = CGAffineTransformMakeRotation(-M_PI / 2);
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    CGFloat width = CGRectGetWidth(self.frame);
    if(_lastWidth != width) {
        _lastWidth = width;
//        if(self.shapeLayer.path) {
//            CGPathRef ref = self.shapeLayer.path;
//            self.shapeLayer.path = nil;
//            CGPathRelease(ref);
//        }
        self.shapeLayer.path = [self createPath];
        self.shapeLayer.fillColor = nil;
        self.shapeLayer.strokeColor = self.progressColor.CGColor;
        self.shapeLayer.lineWidth = _strokeLength;
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
    if(animated) {
        [self setProgress:progress animationDuration:0.8];
    } else {
        _progress = progress;
        self.shapeLayer.strokeStart = progress;
    }
}

- (void)setProgress:(CGFloat)progress animationDuration:(double)duration
{
    CABasicAnimation *an = [[CABasicAnimation alloc] init];
    an.keyPath = @"strokeStart";
    an.duration = duration;
    an.fromValue = [NSNumber numberWithFloat:_progress];
    an.toValue = [NSNumber numberWithFloat:progress];
    an.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:-0.8:0.5:1.85];
    self.shapeLayer.strokeStart = progress;
    [self.shapeLayer addAnimation:an forKey:@"strokeStart"];
    _progress = progress;
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
