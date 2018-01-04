//
//  OHGradientView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-22.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHGradientView.h"

@implementation OHGradientView


- (id)initWithHorizontalGradient
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        CAGradientLayer* layer = (CAGradientLayer*) self.layer;
        layer.startPoint = CGPointMake(0.0, 0.5);
        layer.endPoint = CGPointMake(1.0, 0.5);
    }
    return self;
}

- (id)initWithVerticalGradient
{
    self = [super initWithFrame:CGRectZero];
    if(self) {
        CAGradientLayer* layer = (CAGradientLayer*) self.layer;
        layer.startPoint = CGPointMake(0.5, 0);
        layer.endPoint = CGPointMake(0.5, 1.0);
    }
    return self;
}

+ (Class)layerClass
{
    return [CAGradientLayer class];
}

- (void)layoutSublayersOfLayer:(CALayer *)layer
{
    [super layoutSublayersOfLayer:layer];
}

- (void)setGradientColorFrom:(UIColor *)fromColor to:(UIColor *)toColor
{
    CAGradientLayer* layer = (CAGradientLayer*) self.layer;
    layer.colors = @[(id)fromColor.CGColor, (id)toColor.CGColor];
}

- (void)setGradientColors:(NSArray*) colors forPoints:(NSArray<NSNumber *>*) points {
    CAGradientLayer* layer = (CAGradientLayer*) self.layer;
    layer.locations = points;
    layer.colors = colors;
}

@end
