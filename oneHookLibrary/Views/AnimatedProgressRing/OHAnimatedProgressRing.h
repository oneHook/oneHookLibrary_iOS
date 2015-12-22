//
//  OHAnimatedProgressRing.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-11-12.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHAnimatedProgressRing : UIView

@property (assign, nonatomic) CGFloat progress;
@property (strong, nonatomic) UIColor* progressColor;

- (id)initWithStrokeLength:(CGFloat)strokeLength;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

- (void)hideProgressRing;
- (void)hideProgressRingWithDuration:(double)duration;
- (void)revealProgressRing;
- (void)revealProgressRingWithDuration:(double)duration;

- (void)setProgress:(CGFloat)progress animationDuration:(double)duration;


@end
