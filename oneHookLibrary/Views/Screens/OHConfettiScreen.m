//
//  OHConfettiScreen.m
//  Challenger
//
//  Created by Eagle Diao on 2015-05-29.
//  Copyright (c) 2015 Eagle Diao. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "OHConfettiScreen.h"


@implementation OHConfettiScreen {
    __weak CAEmitterLayer *_confettiEmitter;
    UIImage* _confettiImage;
    CGFloat _decayAmount;
}

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
    //self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    _confettiEmitter = (CAEmitterLayer*)self.layer;
    _confettiEmitter.emitterPosition = CGPointMake(self.bounds.size.width /2, 0);
    _confettiEmitter.emitterSize = self.bounds.size;
    _confettiEmitter.emitterShape = kCAEmitterLayerLine;
    _confettiEmitter.beginTime = CACurrentMediaTime();
    _confettiEmitter.birthRate = 0;
}

- (void)setColors:(NSArray *)colors
{
    NSInteger count = colors.count;
    NSMutableArray* cells = [[NSMutableArray alloc] init];
    for(UIColor* color in colors) {
        CAEmitterCell* cell = [CAEmitterCell emitterCell];
        cell.name = @"confetti";
        cell.birthRate = 15 / count;
        cell.lifetime = 5.0;
        cell.color = color.CGColor;
        cell.redRange = 0;
        cell.blueRange = 0;
        cell.greenRange = 0;
        
        cell.velocity = 250;
        cell.velocityRange = 50;
        cell.emissionRange = (CGFloat) M_PI_2;
        cell.emissionLongitude = (CGFloat) M_PI;
        cell.yAcceleration = 150;
        cell.scale = 1.0;
        cell.scaleRange = 0.2;
        cell.spinRange = 10.0;
        cell.contents = (__bridge id) [_confettiImage CGImage];
        [cells addObject:cell];
    }
    _confettiEmitter.emitterCells = cells;
}

- (void)setConfettiImage:(UIImage *)image
{
    _confettiImage = image;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _confettiEmitter.emitterPosition = CGPointMake(self.bounds.size.width / 2, 0);
    _confettiEmitter.emitterSize = self.bounds.size;
}

+ (Class) layerClass {
    return [CAEmitterLayer class];
}


- (void) startEmitting {
    _confettiEmitter.beginTime = CACurrentMediaTime();
    _confettiEmitter.birthRate = 2.0f;
}

static NSTimeInterval const kDecayStepInterval = 0.1;
- (void) decayStep {
    _confettiEmitter.birthRate -=_decayAmount;
    if (_confettiEmitter.birthRate < 0) {
        _confettiEmitter.birthRate = 0;
        [self removeFromSuperview];
    } else {
        [self performSelector:@selector(decayStep) withObject:nil afterDelay:kDecayStepInterval];
    }
}

- (void) decayOverTime:(NSTimeInterval)interval {
    _decayAmount = (CGFloat) (_confettiEmitter.birthRate /  (interval / kDecayStepInterval));
    [self decayStep];
}

- (void) stopEmitting {
    _confettiEmitter.birthRate = 0.0;
    [self removeFromSuperview];
}

@end
