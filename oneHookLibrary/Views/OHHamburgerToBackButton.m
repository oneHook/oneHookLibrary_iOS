//
//  OHHamburgerToBackButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHHamburgerToBackButton.h"

@interface OHHamburgerToBackButton () {
}

@property (strong, nonatomic) CAShapeLayer *topLayer;
@property (strong, nonatomic) CAShapeLayer *middleLayer;
@property (strong, nonatomic) CAShapeLayer *bottomLayer;
@property NSArray *layers;

@end

#define NORMALIZE(v) (v / 54.0) * self.frame.size.width
#define LINE_WIDTH 4
#define STROKE_WIDTH self.frame.size.width * 0.6
#define degreesToRadians(degrees) ((degrees) / 180.0 * M_PI)

@implementation OHHamburgerToBackButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
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

- (CGMutablePathRef)shortPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, NORMALIZE(2), NORMALIZE(2));
    CGPathAddLineToPoint(path, nil, NORMALIZE(28), NORMALIZE(2));
    return path;
}

- (CGMutablePathRef)outline {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, NORMALIZE(10), NORMALIZE(27));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(12.00), NORMALIZE(27.00), NORMALIZE(28.02), NORMALIZE(27.00), NORMALIZE(40), NORMALIZE(27));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(55.92), NORMALIZE(27.00), NORMALIZE(50.47), NORMALIZE(2.00), NORMALIZE(27), NORMALIZE(2));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(13.16), NORMALIZE(2.00), NORMALIZE(2.00), NORMALIZE(13.16), NORMALIZE(2), NORMALIZE(27));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(2.00), NORMALIZE(40.84), NORMALIZE(13.16), NORMALIZE(52.00), NORMALIZE(27), NORMALIZE(52));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(40.84), NORMALIZE(52.00), NORMALIZE(52.00), NORMALIZE(40.84), NORMALIZE(52), NORMALIZE(27));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(52.00), NORMALIZE(13.16), NORMALIZE(42.39), NORMALIZE(2.00), NORMALIZE(27), NORMALIZE(2));
    CGPathAddCurveToPoint(path, nil, NORMALIZE(13.16), NORMALIZE(2.00), NORMALIZE(2.00), NORMALIZE(13.16), NORMALIZE(2), NORMALIZE(27));
    return path;
}

- (void)commonInit {
    self.topLayer = [[CAShapeLayer alloc] init];
    self.middleLayer = [[CAShapeLayer alloc] init];
    self.bottomLayer = [[CAShapeLayer alloc] init];
    self.layers = @[ self.topLayer, self.middleLayer, self.bottomLayer ];

    self.topLayer.path = [self shortPath];
    self.middleLayer.path = [self outline];
    self.bottomLayer.path = [self shortPath];

    for (CAShapeLayer *layer in self.layers) {
        layer.fillColor = nil;
        layer.strokeColor = [UIColor blackColor].CGColor;
        [self.layer addSublayer:layer];
        layer.lineWidth = NORMALIZE(4);
        layer.masksToBounds = YES;

        layer.miterLimit = NORMALIZE(4);
        layer.lineCap = kCALineCapRound;
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, NORMALIZE(4), kCGLineCapRound, kCGLineJoinMiter, NORMALIZE(4));
        layer.bounds = CGPathGetPathBoundingBox(strokingPath);

        //        let strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, 4, kCGLineCapRound, kCGLineJoinMiter, 4)

        layer.actions = @{ @"strokeStart" : [NSNull null],
                           @"strokeEnd" : [NSNull null],
                           @"transform" : [NSNull null] };
    }

    CGFloat hamburgerStrokeStart = 0.028;
    CGFloat hamburgerStrokeEnd = 0.111;

    self.topLayer.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
    self.topLayer.position = CGPointMake(NORMALIZE(40), NORMALIZE(18));

    self.middleLayer.position = CGPointMake(NORMALIZE(27), NORMALIZE(27));
    self.middleLayer.strokeStart = hamburgerStrokeStart;
    self.middleLayer.strokeEnd = hamburgerStrokeEnd;

    self.bottomLayer.anchorPoint = CGPointMake(28.0 / 30.0, 0.5);
    self.bottomLayer.position = CGPointMake(NORMALIZE(40), NORMALIZE(36));
}

- (void)layoutSubviews {
}

- (void)setShowMenu:(BOOL)showMenu {
    _showMenu = showMenu;

    CGFloat menuStrokeStart = 0.325;
    CGFloat menuStrokeEnd = 0.9;
    CGFloat hamburgerStrokeStart = 0.028;
    CGFloat hamburgerStrokeEnd = 0.111;

    CABasicAnimation *strokeStart = [[CABasicAnimation alloc] init];
    strokeStart.keyPath = @"strokeStart";
    CABasicAnimation *strokeEnd = [[CABasicAnimation alloc] init];
    strokeEnd.keyPath = @"strokeEnd";
    if (_showMenu) {
        strokeStart.toValue = [NSNumber numberWithDouble:menuStrokeStart];
        strokeStart.duration = 0.5f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];

        strokeEnd.toValue = [NSNumber numberWithDouble:menuStrokeEnd];
        strokeStart.duration = 0.6f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];

    } else {
        strokeStart.toValue = [NSNumber numberWithDouble:hamburgerStrokeStart];
        strokeStart.duration = 0.5f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:0:0.5:1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;

        strokeEnd.toValue = [NSNumber numberWithDouble:hamburgerStrokeEnd];
        strokeStart.duration = 0.6f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:0.3:0.5:0.9];
    }

    [self applyAnimationWithLayer:self.middleLayer animation:strokeStart];
    [self applyAnimationWithLayer:self.middleLayer animation:strokeEnd];

    CABasicAnimation *topTransform = [[CABasicAnimation alloc] init];
    topTransform.keyPath = @"transform";
    topTransform.duration = 0.4;
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:-0.8:0.5:1.85];
    topTransform.fillMode = kCAFillModeBackwards;

    CABasicAnimation *bottomTransform = [topTransform copy];

    if (self.showMenu) {
        CATransform3D translation = CATransform3DMakeTranslation(NORMALIZE(-4), 0, 0);
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, -0.7853975, 0, 0, 1)];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;

        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(translation, 0.7853975, 0, 0, 1)];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;

    } else {
        topTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        topTransform.beginTime = CACurrentMediaTime() + 0.25;

        bottomTransform.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
        bottomTransform.beginTime = CACurrentMediaTime() + 0.25;
    }

    [self applyAnimationWithLayer:self.topLayer animation:topTransform];
    [self applyAnimationWithLayer:self.bottomLayer animation:bottomTransform];
}

- (void)applyAnimationWithLayer:(CAShapeLayer *)layer animation:(CABasicAnimation *)animation {
    CABasicAnimation *c = [animation copy];
    if (c.fromValue == nil) {
        c.fromValue = [layer.presentationLayer valueForKeyPath:c.keyPath];
    }

    [layer addAnimation:c forKey:c.keyPath];
    [layer setValue:c.toValue forKey:c.keyPath];
}

@end
