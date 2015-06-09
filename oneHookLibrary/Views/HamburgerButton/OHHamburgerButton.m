//
//  OHHamburgerButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-25.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "OHHamburgerButton.h"

#define LENGTH self.bounds.size.width
#define STROKE_PADDING (0.20f * LENGTH)
#define STROKE_LENGTH (LENGTH - 2 * STROKE_PADDING)
#define STROKE_WIDTH (self.hamburgerButtonStrokeWidthConstant * LENGTH / 8)

#define HAMBURGER_STROKE_START 0.0f
#define HAMBURGER_STROKE_END 0.125f
#define CIRCLE_STROKE_START 0.325f
#define CIRCLE_STROKE_END 1.0f

@interface OHHamburgerButton () {
}

@property (strong, nonatomic) CAShapeLayer *topLayer;
@property (strong, nonatomic) CAShapeLayer *middleLayer;
@property (strong, nonatomic) CAShapeLayer *bottomLayer;
@property NSArray *layers;

@end

@implementation OHHamburgerButton

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

- (void)setHamburgerButtonColor:(UIColor *)hamburgerButtonColor
{
    _hamburgerButtonColor = hamburgerButtonColor;
    self.topLayer.strokeColor = hamburgerButtonColor.CGColor;
    self.middleLayer.strokeColor = hamburgerButtonColor.CGColor;
    self.bottomLayer.strokeColor = hamburgerButtonColor.CGColor;
}

- (void)commonInit {
    /* apply default hamburger button style */
    _hamburgerButtonColor = [UIColor blackColor];
    self.hamburgerButtonStrokeWidthConstant = 0.6f;
    self.hamburgerButtonStyle = kHamburgerButtonStyleCircle;
    self.hamburgerButtonTransitionTo = kHamburgerButtonTransitionToBack;
    
    /* Creating all layers */
    self.topLayer = [[CAShapeLayer alloc] init];
    self.middleLayer = [[CAShapeLayer alloc] init];
    self.bottomLayer = [[CAShapeLayer alloc] init];
    self.layers = @[ self.topLayer, self.middleLayer, self.bottomLayer ];
    
    CGPathRef path1 = [self createShortPath];
    CGPathRef path3 = [self createShortPath];
    CGPathRef path2 = [self createOutline];
    self.topLayer.path = path1;
    self.middleLayer.path = path2;
    self.bottomLayer.path = path3;
    CGPathRelease(path1);
    CGPathRelease(path2);
    CGPathRelease(path3);
    
    for (CAShapeLayer *layer in self.layers) {
        layer.fillColor = nil;
        layer.strokeColor = self.hamburgerButtonColor.CGColor;
        [self.layer addSublayer:layer];
        layer.lineWidth = STROKE_WIDTH;
        layer.miterLimit = LENGTH / 8;
        layer.lineCap = kCALineCapRound;
        layer.masksToBounds = YES;
        CGPathRef strokingPath = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapRound, kCGLineJoinMiter, layer.miterLimit);
        layer.bounds = CGPathGetPathBoundingBox(strokingPath);
        layer.actions = @{ @"strokeStart" : [NSNull null],
                           @"strokeEnd" : [NSNull null],
                           @"strokeColor" : [NSNull null],
                           @"transform" : [NSNull null] };
    }
    
    self.topLayer.anchorPoint = CGPointMake(0.87, 0.5);
    self.topLayer.position = CGPointMake(LENGTH - STROKE_PADDING + STROKE_WIDTH / 2 - 0.085 * LENGTH, LENGTH / 3);
    
    self.middleLayer.position = CGPointMake(LENGTH / 2, LENGTH / 2);
    self.middleLayer.strokeStart = HAMBURGER_STROKE_START;
    self.middleLayer.strokeEnd = HAMBURGER_STROKE_END;
    
    self.bottomLayer.anchorPoint = CGPointMake(0.87, 0.5);
    self.bottomLayer.position = CGPointMake(LENGTH - STROKE_PADDING + STROKE_WIDTH / 2 - 0.085 * LENGTH, LENGTH * 2 / 3);
}

- (CGMutablePathRef)createShortPath {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, STROKE_LENGTH, 0);
    return path;
}

- (CGMutablePathRef)createOutline {
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, STROKE_PADDING, LENGTH / 2);
    CGPathAddCurveToPoint(path, nil, STROKE_PADDING, LENGTH / 2, LENGTH * 0.5, LENGTH / 2, LENGTH - STROKE_PADDING, LENGTH / 2);
    CGPathAddCurveToPoint(path, nil, LENGTH * 1.02, LENGTH / 2, LENGTH * 0.95, 0, LENGTH / 2, STROKE_WIDTH / 2);
    CGPathAddArc(path, nil, LENGTH / 2, LENGTH / 2, LENGTH / 2 - STROKE_WIDTH / 2, 3 * M_PI / 2, 3 * M_PI / 2 - 2 * M_PI - 1, YES);
    return path;
}

- (void)layoutSubviews {
}

- (void)setShowMenu:(BOOL)showMenu {
    _showMenu = showMenu;
    CABasicAnimation *strokeStart = [[CABasicAnimation alloc] init];
    strokeStart.keyPath = @"strokeStart";
    CABasicAnimation *strokeEnd = [[CABasicAnimation alloc] init];
    strokeEnd.keyPath = @"strokeEnd";
    CABasicAnimation *strokeColor = [[CABasicAnimation alloc] init];
    strokeColor.keyPath = @"strokeColor";
    if (_showMenu) {
        strokeStart.toValue = [NSNumber numberWithDouble:CIRCLE_STROKE_START];
        strokeStart.duration = 0.5f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];
        
        strokeEnd.toValue = [NSNumber numberWithDouble:CIRCLE_STROKE_END];
        strokeEnd.duration = 0.6f;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];
        
        strokeColor.toValue = (id)[UIColor clearColor].CGColor;
        strokeColor.duration = 0.6f;
        strokeColor.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];
        
    } else {
        strokeStart.toValue = [NSNumber numberWithDouble:HAMBURGER_STROKE_START];
        strokeStart.duration = 0.5f;
        strokeStart.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:0:0.5:1.2];
        strokeStart.beginTime = CACurrentMediaTime() + 0.1;
        strokeStart.fillMode = kCAFillModeBackwards;
        
        strokeEnd.toValue = [NSNumber numberWithDouble:HAMBURGER_STROKE_END];
        strokeEnd.duration = 0.6f;
        strokeEnd.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:0.3:0.5:0.9];
        
        strokeColor.toValue = (id)self.hamburgerButtonColor.CGColor;
        strokeColor.duration = 0.6f;
        strokeColor.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.25:-0.4:0.5:1];
    }
    
    [self applyAnimationWithLayer:self.middleLayer animation:strokeStart];
    [self applyAnimationWithLayer:self.middleLayer animation:strokeEnd];
    if (self.hamburgerButtonStyle == kHamburgerButtonStyleClear) {
        [self applyAnimationWithLayer:self.middleLayer animation:strokeColor];
    }
    
    CABasicAnimation *topTransform = [[CABasicAnimation alloc] init];
    topTransform.keyPath = @"transform";
    topTransform.duration = 0.4;
    topTransform.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.5:-0.8:0.5:1.85];
    topTransform.fillMode = kCAFillModeBackwards;
    
    CABasicAnimation *bottomTransform = [topTransform copy];
    
    if (self.showMenu) {
        CATransform3D translation = CATransform3DMakeTranslation(-STROKE_WIDTH, 0, 0);
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
