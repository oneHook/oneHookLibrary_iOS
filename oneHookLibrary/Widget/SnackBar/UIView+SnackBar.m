//
//  UIView+SnackBar.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "UIView+SnackBar.h"
#import "OHKeyFrameAnimator.h"
#import "OHBaseSnackView.h"
#import "OHSinglelineSnackView.h"

#define ANIMATION_DURATION 0.25

/* SnackBar singleton */

@interface OverlayView : UIControl

@property (strong, nonatomic) OHBaseSnackView* snackView;
@property (strong, nonatomic) OHKeyFrameAnimator* animator;

@end

@implementation OverlayView

- (void)showSnackView:(OHBaseSnackView*)snackView
{
    if(_snackView) {
        /* for now, ignore snack if something is presenting */
        return;
    }
    
    self.snackView = snackView;
    self.snackView.frame = CGRectMake(0,
                                CGRectGetHeight(self.frame),
                                CGRectGetWidth(self.frame),
                                [snackView measureHeightByWidth:CGRectGetWidth(self.frame)]);
    [self addSubview:snackView];
    
    self.animator = [[OHKeyFrameAnimator alloc] init];
    [self.animator startAnimatingWithDuration:ANIMATION_DURATION progress:^(double progress) {
        CGFloat measuredHeight = [snackView measureHeightByWidth:CGRectGetWidth(self.frame)];
        self.snackView.frame = CGRectMake(0,
                                          CGRectGetHeight(self.frame) - measuredHeight * progress,
                                          CGRectGetWidth(self.frame),
                                          measuredHeight);
    } finish:^{
        self.animator = nil;
        [self performSelector:@selector(dismissSnackView) withObject:nil afterDelay:self.snackView.idleTime];
    }];

}

- (void)dismissSnackView
{
    self.animator = [[OHKeyFrameAnimator alloc] init];
    [self.animator startAnimatingWithDuration:ANIMATION_DURATION progress:^(double progress) {
        CGFloat measuredHeight = [self.snackView measureHeightByWidth:CGRectGetWidth(self.frame)];
        self.snackView.frame = CGRectMake(0,
                                          CGRectGetHeight(self.frame) - measuredHeight * (1 - progress),
                                          CGRectGetWidth(self.frame),
                                          measuredHeight);
    } finish:^{
        /* clean up */
        self.animator = nil;
        [self.snackView removeFromSuperview];
        self.snackView = nil;
    }];

}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    for (UIView *view in self.subviews) {
        if (!view.hidden && view.alpha > 0 && view.userInteractionEnabled && [view pointInside:[self convertPoint:point toView:view] withEvent:event])
            return YES;
    }
    return NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if(_snackView && !_animator) {
        CGFloat measuredHeight = [_snackView measureHeightByWidth:CGRectGetWidth(self.frame)];
        _snackView.frame = CGRectMake(0,
                                       CGRectGetHeight(self.frame) - measuredHeight,
                                       CGRectGetWidth(self.frame),
                                       measuredHeight);
    }
}

@end

@interface SnackBar : NSObject

@property (strong, nonatomic) UIColor* backgroundColor;
@property (strong, nonatomic) UIColor* foregroundColor;
@property (strong, nonatomic) UIFont*  foregroundTextFont;

@property (strong, nonatomic) OverlayView* overlayView;

@end

@implementation SnackBar

- (id)init
{
    self = [super init];
    if(self) {
        self.backgroundColor = [UIColor redColor];
        self.foregroundColor = [UIColor whiteColor];
        self.foregroundTextFont = [UIFont systemFontOfSize:15];
    }
    return self;
}

- (UIControl *)overlayView {
    if(!_overlayView) {
        _overlayView = [[OverlayView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _overlayView.backgroundColor = [UIColor clearColor];
        //        [_overlayView addTarget:self action:@selector(overlayViewDidReceiveTouchEvent:forEvent:) forControlEvents:UIControlEventTouchDown];
    }
    return _overlayView;
}

- (void)test
{
    if(!self.overlayView.superview) {
        NSEnumerator *frontToBackWindows = [UIApplication.sharedApplication.windows reverseObjectEnumerator];
        for (UIWindow *window in frontToBackWindows){
            BOOL windowOnMainScreen = window.screen == UIScreen.mainScreen;
            BOOL windowIsVisible = !window.hidden && window.alpha > 0;
            BOOL windowLevelNormal = window.windowLevel == UIWindowLevelNormal;
            
            if (windowOnMainScreen && windowIsVisible && windowLevelNormal) {
                [window addSubview:self.overlayView];
                break;
            }
        }
    } else {
        [self.overlayView.superview bringSubviewToFront:self.overlayView];
    }
    
    OHSinglelineSnackView* testView = [[OHSinglelineSnackView alloc] init];
    testView.textLabel.text = @"this is a toast message, This is very very very long , very very vey veyeyeyey hsfhh kjdfksjfksdjfdks";
    testView.textLabel.font = self.foregroundTextFont;
    testView.textLabel.textColor = self.foregroundColor;
    testView.backgroundColor = self.backgroundColor;
    
    [self.overlayView showSnackView:testView];
}

@end

/* SnackBar */

@interface UIView (SnackBar)

+ (SnackBar*)sharedConfig;

@end

@implementation UIView (SnackBar)

/* Config functions */

+ (SnackBar*)sharedInstance
{
    static dispatch_once_t once;
    static SnackBar *config;
    dispatch_once(&once, ^ {
        config = [[SnackBar alloc] init];
    });
    return config;
}

+ (void)setBackgroundColor:(UIColor *)color
{
    [self sharedInstance].backgroundColor = color;
}

+ (void)setForegroundColor:(UIColor *)color
{
    [self sharedInstance].foregroundColor = color;
}

+ (void)setFont:(UIFont *)font
{
    [self sharedInstance].foregroundTextFont = font;
}

+ (void)test
{
    [[self sharedInstance] test];
}


@end
