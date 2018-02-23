//
//  OHCountDownProgressView.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-07.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHCountDownProgressView.h"

#define kDefaultFireIntervalHighUse  0.02

@interface OHCountDownProgressView() {
    double _startTime;
    void (^_progressBlock)(NSTimeInterval);
    void (^_endedBlock)(NSTimeInterval);
}

@property (strong, nonatomic) NSTimer *timer;

@end

@implementation OHCountDownProgressView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc
{
    _progressBlock = nil;
    _endedBlock = nil;
#ifdef DEBUG
    NSLog(@"DEALLOC ANIMATED PROGRESS RING");
#endif
}

- (void)commonInit {
#ifdef DEBUG
    NSLog(@"ALLOC ANIMATED PROGRESS RING");
#endif
    self.progressRing = [[OHAnimatedProgressRing alloc] init];
    [self addSubview:self.progressRing];
    
    self.secondsLabel = [[UILabel alloc] init];
    self.secondsLabel.textAlignment = NSTextAlignmentCenter;
    self.secondsLabel.adjustsFontSizeToFitWidth = YES;
    self.secondsLabel.accessibilityTraits = UIAccessibilityTraitUpdatesFrequently;
    
    [self addSubview:self.secondsLabel];
}

-(void)startWithProgressBlock:(void (^)(NSTimeInterval))progressBloack
                  EndingBlock:(void (^)(NSTimeInterval))endBlock
{
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _progressBlock = progressBloack;
    _endedBlock = endBlock;
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:kDefaultFireIntervalHighUse
                                              target:weakSelf
                                            selector:@selector(updateProgress)
                                            userInfo:nil
                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    _startTime = CACurrentMediaTime();
    [_timer fire];
}

- (void)updateProgress
{
    double currTime = CACurrentMediaTime();
    double past = currTime - _startTime;
    self.secondsLabel.text = [NSString stringWithFormat:@"%d", (int) ceil(_secondsToCountDown - past)];
    CGFloat progress = past / self.secondsToCountDown;
    self.progressRing.progress = progress;
    if(_progressBlock) {
        _progressBlock(past);
    }
    if(progress >= 1.0) {
        if(_timer) {
            [_timer invalidate];
            _timer = nil;
            _endedBlock(past);
        }
    }
}

- (void)removeFromSuperview
{
    [super removeFromSuperview];
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)layoutSubviews
{
    self.progressRing.frame = self.bounds;
    
    self.secondsLabel.bounds = CGRectMake(0, 0, CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
    self.secondsLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2);
}

- (void)setSecondsToCountDown:(double)secondsToCountDown
{
     _secondsToCountDown = secondsToCountDown;
    [self reset];
}

- (void)reset
{
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    self.secondsLabel.text = [NSString stringWithFormat:@"%d", (int)_secondsToCountDown];
    self.progressRing.progress = 0.0f;
}


@end
