//
//  OHGradientView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-22.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHGradientView.h"

@implementation OHGradientView

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

@end
