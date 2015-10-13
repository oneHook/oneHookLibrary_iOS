//
//  OHReactiveButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-09.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHReactiveButton.h"

@interface OHReactiveButton() {
    
}

@end

@implementation OHReactiveButton

- (void)commonInit {
    [super commonInit];
    self.buttonStyle = kButtonStyleSolid;
}

- (void)showDefault
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    [UIView animateWithDuration:0.25 animations:^{
        _progressView.alpha = 0.0f;
        _finishView.alpha = 0.0;
        self.titleLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showLoading
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    if(!_progressView) {
        UIView* progressView = self.progressView;
        progressView.alpha = 0.0;
        [self addSubview:progressView];
        progressView.bounds = CGRectMake(0, 0, height, height);
        progressView.center = CGPointMake(width / 2, height / 2);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.progressView.alpha = 1.0f;
        _finishView.alpha = 0.0;
        self.titleLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
    [self startLoadingAnimation];
}

- (void)showFinish
{
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    if(!_finishView) {
        UIView* finishView = self.finishView;
        finishView.alpha = 0.0;
        [self addSubview:finishView];
        finishView.bounds = CGRectMake(0, 0, height, height);
        finishView.center = CGPointMake(width / 2, height / 2);
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.finishView.alpha = 1.0f;
        _progressView.alpha = 0.0;
        self.titleLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)startLoadingAnimation
{
    UIActivityIndicatorView* indicator = (UIActivityIndicatorView*) self.progressView;
    [indicator startAnimating];
}

- (UIView*)finishView
{
    if(_finishView == nil) {
        _finishView = [[UIView alloc] init];
        _finishView.backgroundColor = [UIColor redColor];
    }
    return _finishView;
}

- (UIView*)progressView
{
    if(_progressView == nil) {
        UIActivityIndicatorView* indicatorView = [[UIActivityIndicatorView alloc] init];
        _progressView = indicatorView;
    }
    return _progressView;
}


@end
