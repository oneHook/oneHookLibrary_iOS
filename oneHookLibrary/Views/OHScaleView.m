//
//  OHScaleView.m
//  oneHookLibrary
//
//  Created by EagleDIao@Optimity on 2017-08-06.
//  Copyright © 2017 oneHook inc. All rights reserved.
//

#import "OHScaleView.h"

@interface OHScaleView() {
    CGFloat _lastXTranslation;
    CGFloat _rawXTranslation;
}

@end


@implementation OHScaleView

- (id)init
{
    self = [super init];
    if(self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.backgroundColor = [UIColor whiteColor];
    self.scaleColor = [UIColor blackColor];
    self.thickLineThickness = 8;
    self.thinLineThickness = 4;
    self.paddingTop = 0;
    self.paddingBottom = 0;
    self.scaleInterval = 14;
    self.scaleIntervalCount = 10;
    _rawXTranslation = 0;
    
    /* add in pan gesture rec */
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)]];
    
    _minScale = 0;
    _maxScale = 200;
    _currentScale = 100;
    _rawXTranslation = _currentScale * _scaleInterval;
}

- (void)handlePanGesture:(UIPanGestureRecognizer*)rec
{
    CGPoint translation = [rec translationInView:self];
    switch(rec.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStatePossible:
            _lastXTranslation = translation.x;
            break;
        case UIGestureRecognizerStateChanged:
            if(_lastXTranslation != translation.x) {
                CGFloat diff = _lastXTranslation - translation.x;
                _rawXTranslation += diff;
                
                [self enforceLimit];
                _lastXTranslation = translation.x;
                [self dispatchEvent];
                [self setNeedsDisplay];
            }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateFailed:
        case UIGestureRecognizerStateCancelled:
            [self snapToClosestScale];
            [self dispatchEvent];
            break;
    }
}

- (void)enforceLimit
{
    if(_rawXTranslation <= _minScale * _scaleInterval) {
        _rawXTranslation = _minScale * _scaleInterval;
    } else if(_rawXTranslation >= _maxScale * _scaleInterval) {
        _rawXTranslation = _maxScale * _scaleInterval;
    }
}

- (void)dispatchEvent
{
    [self.delegate onScaleMoved:(int)(_rawXTranslation / _scaleInterval)];
}

- (void)snapToClosestScale
{
    CGFloat count = round(_rawXTranslation / _scaleInterval);
    _rawXTranslation = count * _scaleInterval;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGFloat top = CGRectGetMinY(rect) + _paddingTop;
    CGFloat bottom = CGRectGetMaxY(rect) - _paddingBottom;
    CGFloat width = CGRectGetWidth(rect);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, self.bounds);
    
    int centerX = width / 2 - (int) _rawXTranslation % (_scaleInterval * _scaleIntervalCount);
    /* center thick line */

    
    int lineCount = ceil(width / _scaleInterval);
    for(int i = 0; i < lineCount; i++) {
        CGFloat thickness = ((i % _scaleIntervalCount) == 0) ? _thickLineThickness : _thinLineThickness;
        CGFloat lineTop = ((i % _scaleIntervalCount) == 0) ? top : (top + (bottom - top) * 0.8);
        drawLine(context,
                 CGPointMake(centerX - i * _scaleInterval, bottom),
                 CGPointMake(centerX - i * _scaleInterval, lineTop),
                 _scaleColor.CGColor,
                 thickness);
        drawLine(context,
                 CGPointMake(centerX + i * _scaleInterval, bottom),
                 CGPointMake(centerX + i * _scaleInterval, lineTop),
                 _scaleColor.CGColor,
                 thickness);

    }
    
    drawLine(context, CGPointMake(width / 2, bottom - 5), CGPointMake(width / 2, bottom), [UIColor redColor].CGColor, _thickLineThickness / 2);
}

void drawLine(CGContextRef context,
              CGPoint startPoint,
              CGPoint endPoint,
              CGColorRef color,
              CGFloat thickness)
{
    CGContextSaveGState(context);
    CGContextSetLineCap(context, kCGLineCapSquare);
    CGContextSetStrokeColorWithColor(context, color);
    CGContextSetLineWidth(context, thickness);
    CGContextMoveToPoint(context, startPoint.x, startPoint.y);
    CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
    CGContextStrokePath(context);
    CGContextRestoreGState(context);
}

#pragma marks - accesssor 

- (void)setCurrentScale:(int)currentScale
{
    _rawXTranslation = currentScale * _scaleInterval;
    [self enforceLimit];
    [self dispatchEvent];
    [self setNeedsDisplay];
}

@end
