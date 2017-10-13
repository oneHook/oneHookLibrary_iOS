//
//  OHRoundButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-03-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHRoundButton.h"

@implementation OHRoundButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat length = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    
    CAAnimation *anim = [self.layer animationForKey:@"bounds.size"];
    
    [CATransaction begin];
    if(anim) {
        [CATransaction begin];
        // animating, apply same duration and timing function.
        [CATransaction setAnimationDuration:anim.duration];
        [CATransaction setAnimationTimingFunction:anim.timingFunction];
        
        CABasicAnimation *radiusAnimation = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
        [self.layer addAnimation:radiusAnimation forKey:@"cornerRadius"];
        self.layer.cornerRadius = length / 2;
        [CATransaction commit];
    } else {
        self.layer.cornerRadius = length / 2;
    }
    
    //NSLog(@"%@ %f %f", self.titleLabel.text, self.bounds.size.height, length);
}

@end
