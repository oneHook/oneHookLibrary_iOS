//
//  OHScaleView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-09-01.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHScaleView.h"
#import <CoreText/CoreText.h>

@interface OHScaleView() <UIScrollViewDelegate> {
    BOOL _isVertical;
    
    CGFloat _screenStartValue;
    CGFloat _screenCenterValue;
    CGFloat _screenEndValue;
    CGFloat _drawOffset;
}

@property (strong, nonatomic) UIScrollView* scrollView;

@end

@implementation OHScaleView

- (id)initWithVertical
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _isVertical = YES;
        [self commonInit];
    }
    return self;
}

- (id)initWithHorizontal
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        _isVertical = NO;
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    /* default parameters */
    self.minValue = 100;
    self.maxValue = 240;
    self.startingValue = 180;
    self.numberOfIntervals = 10;
    self.intervalSpace = 20;
    
    /* setup */
    _screenCenterValue = self.startingValue;
    
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.delegate = self;
    [self addSubview:self.scrollView];
    
    
    
    self.backgroundColor = [UIColor whiteColor];
}

- (CGFloat)scaleLength
{
    return (self.maxValue - self.minValue) * self.numberOfIntervals * self.intervalSpace;
}


- (void)layoutSubviews
{
    self.scrollView.frame = self.bounds;
    
    CGFloat scaleLength = self.scaleLength;
    CGFloat centerPoint = (_screenCenterValue - self.minValue) * self.numberOfIntervals * self.intervalSpace;
    self.scrollView.contentSize = CGSizeMake(_isVertical? 0 : scaleLength, _isVertical? scaleLength : 0);
    self.scrollView.contentOffset = CGPointMake(_isVertical? 0 : centerPoint, _isVertical? centerPoint : 0);
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
//        CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1, 0, 0, 1.0);
    CGContextSetRGBFillColor(context, 1, 0, 0, 1.0);
    CGContextSetLineWidth(context, 2.0);
    
    if(_isVertical) {
        [self drawRectVertical:rect];
    } else {
        [self drawRectHorizontal:rect];
    }
}

- (void)drawText:(NSString*)text atPoint:(CGPoint)point
{
    NSMutableParagraphStyle* textStyle = NSMutableParagraphStyle.defaultParagraphStyle.mutableCopy;
    textStyle.alignment = NSTextAlignmentRight;
    NSDictionary* textFontAttributes = @{NSFontAttributeName: [UIFont fontWithName: @"Helvetica" size: 30],
                                         NSForegroundColorAttributeName:UIColor.redColor,
                                         NSParagraphStyleAttributeName:textStyle};
    
    CGSize textSize = [text sizeWithAttributes:textFontAttributes];
    [text drawInRect:CGRectMake(point.x - textSize.width, point.y - textSize.height / 2, textSize.width, textSize.height)
      withAttributes:textFontAttributes];
    
}

- (void)drawRectVertical:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat width = CGRectGetWidth(rect);
    CGFloat height = CGRectGetHeight(rect);
    
    CGFloat startY = _drawOffset;
    CGFloat startValue = _screenStartValue;
    while(startY <= height) {
        
        CGFloat tickWidth = width / 4 * 3;
        if(startValue - floor(startValue) < (1.0f / self.numberOfIntervals)) {
            tickWidth = width / 2;
            
            NSString* textToDraw = [NSString stringWithFormat:@"%d", (int) startValue];
            [self drawText:textToDraw atPoint:CGPointMake(tickWidth, startY)];
        }
        CGContextMoveToPoint(context, width, startY);
        CGContextAddLineToPoint(context, tickWidth, startY);
        
        startY += self.intervalSpace;
        startValue += (1.0f / self.numberOfIntervals);
    }
//    NSLog(@"end");
    CGContextStrokePath(context);
    
}

- (void)drawRectHorizontal:(CGRect)rect
{
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrolled %f %f", scrollView.contentOffset.x, scrollView.contentOffset.y);
    CGFloat offset = 0;
    CGFloat screenLength = 0;
    if(_isVertical) {
        offset = scrollView.contentOffset.y;
        screenLength = CGRectGetHeight(self.frame);
    } else {
        offset = scrollView.contentOffset.x;
        screenLength = CGRectGetWidth(self.frame);
    }
//    CGFloat centerOffset = offset + screenLength / 2;
//    int centerTickLocation = centerOffset / self.intervalSpace;
    
    _screenStartValue = floor(offset / self.intervalSpace) / self.numberOfIntervals + self.minValue;
    _screenCenterValue = floor((offset + screenLength / 2) / self.intervalSpace) / self.numberOfIntervals + self.minValue;
    _screenEndValue = floor((offset + screenLength) / self.intervalSpace) / self.numberOfIntervals + self.minValue;
    _drawOffset = floor(offset / self.intervalSpace) * self.intervalSpace - (offset + screenLength / 2);
//    NSLog(@"center point offset %f center tick location %d center value %f draw offset %f", centerOffset, centerTickLocation, _screenCenterValue, _drawOffset);
    
    [self setNeedsDisplay];
}

@end
