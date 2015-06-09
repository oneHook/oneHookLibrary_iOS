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
    __weak CAEmitterCell *_emitterCell;
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
    self.userInteractionEnabled = NO;
    self.backgroundColor = [UIColor clearColor];
    _confettiEmitter = (CAEmitterLayer*)self.layer;
    _confettiEmitter.emitterPosition = CGPointMake(self.bounds.size.width /2, 0);
    _confettiEmitter.emitterSize = self.bounds.size;
    _confettiEmitter.emitterShape = kCAEmitterLayerLine;
    
    __strong CAEmitterCell* cell = [CAEmitterCell emitterCell];
    _emitterCell = cell;
    _emitterCell.name = @"confetti";
    _emitterCell.birthRate = 15;
    _emitterCell.lifetime = 5.0;
    _emitterCell.color = [[UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:1.0] CGColor];
    _emitterCell.redRange = 0.8;
    _emitterCell.blueRange = 0.8;
    _emitterCell.greenRange = 0.8;
    
    _emitterCell.velocity = 250;
    _emitterCell.velocityRange = 50;
    _emitterCell.emissionRange = (CGFloat) M_PI_2;
    _emitterCell.emissionLongitude = (CGFloat) M_PI;
    _emitterCell.yAcceleration = 150;
    _emitterCell.scale = 1.0;
    _emitterCell.scaleRange = 0.2;
    _emitterCell.spinRange = 10.0;
    _confettiEmitter.emitterCells = [NSArray arrayWithObject:_emitterCell];  
}

- (void)setConfettiImage:(UIImage *)image
{
    _emitterCell.contents = (__bridge id) [image CGImage];
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
    _confettiEmitter.birthRate = 2.0f;
}

static NSTimeInterval const kDecayStepInterval = 0.1;
- (void) decayStep {
    _confettiEmitter.birthRate -=_decayAmount;
    if (_confettiEmitter.birthRate < 0) {
        _confettiEmitter.birthRate = 0;
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
}

@end