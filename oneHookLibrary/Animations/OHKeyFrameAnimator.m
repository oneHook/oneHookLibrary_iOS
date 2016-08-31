//
//  OHKeyFrameAnimator.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-12-24.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHKeyFrameAnimator.h"

@interface OHKeyFrameAnimator() {
    NSTimer* _timer;
    double _totalDuration;
    double _currDuration;
    void (^_timeblock)(double);
    void (^_finishblock)(void);
}

@end

@implementation OHKeyFrameAnimator

- (id)init
{
    self = [super init];
    if(self) {
#ifdef DEBUG
        NSLog(@"%@ ALLOC", [[self class] description]);
#endif
    }
    return self;
}

- (void)dealloc
{
#ifdef DEBUG
    NSLog(@"%@ DEALLOC", [[self class] description]);
#endif
}

- (void)startAnimatingWithDuration:(double)duration progress:(void (^)(double))block
{
    [self startAnimatingWithDuration:duration progress:block finish:_finishblock];
}


- (void)startAnimatingWithDuration:(double)duration progress:(void (^)(double))block finish:(void (^)(void))finishBlock
{
    _timeblock = block;
    _finishblock = finishBlock;
    if(_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    _totalDuration = duration;
    _currDuration = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1. / 60
                                              target:self
                                            selector:@selector(onTimer) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    [_timer fire];
}

- (void)onTimer {
    _currDuration += 1. /60;
    if(_currDuration >= _totalDuration) {
        [_timer invalidate];
        _timer = nil;
        _timeblock(1);
        if(_finishblock) {
            _finishblock();
        }
        _timeblock = nil;
        _finishblock = nil;
    } else {
        _timeblock(_currDuration / _totalDuration);
    }
}

@end
