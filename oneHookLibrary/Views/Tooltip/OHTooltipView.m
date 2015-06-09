//
//  TooltipView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-06-08.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHTooltipView.h"

@interface OHTooltipView() {
    CALayer* _containerLayer;
    CALayer* _blackLayer;
    CAShapeLayer* _maskLayer;
}

@end

@implementation OHTooltipView

- (id)init {
    if((self = [super init])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if((self = [super initWithCoder:aDecoder])) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTooltipViewClicked:)]];
    
    /* Create a containing layer and set it contents with an image */
    _containerLayer = [CALayer layer];
   
    /* Create your translucent black layer and set its opacity */
    _blackLayer = [CALayer layer];
    _blackLayer.backgroundColor = [UIColor blackColor].CGColor;
    _blackLayer.opacity = 0.8f;
    
    [_containerLayer addSublayer:_blackLayer];
    
    /* Create a mask layer with a shape layer that has a circle path */
    _maskLayer = [CAShapeLayer layer];
    _maskLayer.borderColor = [UIColor blackColor].CGColor;
    _maskLayer.borderWidth = 5.0f;
    _maskLayer.fillRule = kCAFillRuleEvenOdd;
//    
//    
//    // Center the mask layer in the translucent black layer
//    [maskLayer setPosition:
//     CGPointMake([translucentBlackLayer bounds].size.width/2.0f,
//                 [translucentBlackLayer bounds].size.height/2.0f)];
    
    [_blackLayer setMask:_maskLayer];
    [self.layer addSublayer:_containerLayer];
    
    _containerLayer.opacity = 0.0f;
}

- (void)layoutSubviews
{
    _containerLayer.bounds = self.bounds;
    _containerLayer.position = self.center;
    
    _blackLayer.bounds = self.bounds;
    _blackLayer.position = self.center;
    
    _maskLayer.bounds = _containerLayer.bounds;
    _maskLayer.position = self.center;
    
}

- (void)setFocusArea:(CGRect)focusArea
{
//    // When you create a path, remember that origin is in upper left hand
//    // corner, so you have to treat it as if it has an anchor point of 0.0,
//    // 0.0
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:
//                          self.addChallengeButton.frame];
//    
//    // Append a rectangular path around the mask layer so that
//    // we can use the even/odd fill rule to invert the mask
//    [path appendPath:[UIBezierPath bezierPathWithRect:[maskLayer bounds]]];
//    
//    // Set the path's fill color since layer masks depend on alpha
//    [maskLayer setFillColor:[[UIColor blackColor] CGColor]];
//    [maskLayer setPath:[path CGPath]];

}

- (void)onTooltipViewClicked:(UITapGestureRecognizer*)rec {
    
}

- (void)animateReveal
{
    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.duration = 0.5f;
    [_containerLayer addAnimation:animation forKey:@"alphaanimation"];
}


@end
