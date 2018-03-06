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

@implementation OHSnack

@end

/* SnackBar singleton */

@interface OverlayView : UIControl

@property (strong, nonatomic) OHBaseSnackView* snackView;
@property (strong, nonatomic) OHKeyFrameAnimator* animator;
@property (strong, nonatomic) NSMutableArray* snackQueue;

@end

@implementation OverlayView

- (NSMutableArray*)snackQueue
{
    if(!_snackQueue) {
        _snackQueue = [[NSMutableArray alloc] init];
    }
    return _snackQueue;
}

/* master function for showing a snack */
- (void)showSnack:(OHSnack*)snack
{
    if(_snackView) {
        /* something is currently showing, put new snack to queue */
        
        if(snack.snackFlag == OHSnackBarFlagImmediate) {
            /* show current snack next */
            [self.snackQueue insertObject:snack atIndex:0];
        } else if(snack.snackFlag == OHSnackBarFlagClearHistory) {
            /* remove all snacks not shown */
            [self.snackQueue removeAllObjects];
            [self.snackQueue addObject:snack];
        } else {
            /* default behavior */
            [self.snackQueue addObject:snack];
        }
        return;
    }
    
    if(snack.style == OHSnackBarStyleSingleText) {
        OHSinglelineSnackView* singleLineView = [[OHSinglelineSnackView alloc] initWithBackgroundStyle:snack.backgroundStyle];
        if(snack.messageText) {
            singleLineView.textLabel.text = snack.messageText;
        } else {
            singleLineView.textLabel.attributedText = snack.messageAttributedText;
        }
        singleLineView.textLabel.font = snack.foregroundFont;
        singleLineView.textLabel.textColor = snack.foregroundColor;
        singleLineView.backgroundColor = snack.backgroundColor;
        singleLineView.idleTime = snack.duration;
        [self showSnackView:singleLineView];
    } else {
        /* NOT SUPPORTED */
    }
}

- (void)showSnackView:(OHBaseSnackView*)snackView
{
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
        [self checkQueue];
        [self.superview sendSubviewToBack:self];
    }];
}

- (void)checkQueue
{
    if(_snackView == nil && self.snackQueue.count > 0) {
        OHSnack* first = self.snackQueue.firstObject;
        [self.snackQueue removeObjectAtIndex:0];
        [self showSnack:first];
    }
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

@property (assign, nonatomic) OHSnackBarBackgroundStyle backgroundStyle;
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
        self.backgroundStyle = OHSnackBarBackgroundStyleSolid;
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

- (void)showSnack:(OHSnack*)snack
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
    
    [self.overlayView showSnack:snack];
}

@end

/* SnackBar */

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

+ (void)setSnackBackgroundStyle:(OHSnackBarBackgroundStyle)backgroundStyle
{
    [self sharedInstance].backgroundStyle = backgroundStyle;
}

+ (void)setSnackBackgroundColor:(UIColor *)color
{
    [self sharedInstance].backgroundColor = color;
}

+ (void)setSnackForegroundColor:(UIColor *)color
{
    [self sharedInstance].foregroundColor = color;
}

+ (void)setSnackFont:(UIFont *)font
{
    [self sharedInstance].foregroundTextFont = font;
}

#pragma mark - display calls

+ (void)showSnackText:(NSString* _Nonnull)text {
    [UIView showSnackText:text duration:SNACK_DURATION_SHORT flag:OHSnackBarFlagDefault];
}

+ (void)showSnackText:(NSString* _Nonnull)text duration:(double)duration {
    [UIView showSnackText:text duration:duration flag:OHSnackBarFlagDefault];
}

+ (void)showSnackText:(NSString* _Nonnull)text duration:(double)duration flag:(OHSnackBarFlag)flag
{
    OHSnack* snack = [[OHSnack alloc] init];
    snack.presentationType = OHSnackBarPresentationTypeBottom;
    snack.style = OHSnackBarStyleSingleText;
    snack.messageText = text;
    snack.duration = duration;
    snack.snackFlag = flag;
    snack.backgroundStyle = [self sharedInstance].backgroundStyle;
    snack.backgroundColor = [self sharedInstance].backgroundColor;
    snack.foregroundColor = [self sharedInstance].foregroundColor;
    snack.foregroundFont = [self sharedInstance].foregroundTextFont;
    [[self sharedInstance] showSnack:snack];
}

+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text
{
    [UIView showSnackAttributedText:text duration:SNACK_DURATION_SHORT flag:OHSnackBarFlagDefault];
}

+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text duration:(double)duration
{
    [UIView showSnackAttributedText:text duration:duration flag:OHSnackBarFlagDefault];
}

+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text duration:(double)duration flag:(OHSnackBarFlag)flag
{
    OHSnack* snack = [[OHSnack alloc] init];
    snack.presentationType = OHSnackBarPresentationTypeBottom;
    snack.style = OHSnackBarStyleSingleText;
    snack.messageAttributedText = text;
    snack.duration = duration;
    snack.snackFlag = flag;
    snack.backgroundStyle = [self sharedInstance].backgroundStyle;
    snack.backgroundColor = [self sharedInstance].backgroundColor;
    snack.foregroundColor = [self sharedInstance].foregroundColor;
    snack.foregroundFont = [self sharedInstance].foregroundTextFont;
    [[self sharedInstance] showSnack:snack];
}

@end
