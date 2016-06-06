//
//  OHViewControllerWithToolbar.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHViewController.h"
#import "OneHookFoundation.h"

@interface OHViewController() {
    CGFloat _lastWidth;
    CGFloat _lastHeight;
    CGFloat _toolbarHeight;
    CGFloat _scrollViewLastContentOffsetY;
}

@end

@implementation OHViewController

- (id)initWithStyle:(OHViewControllerToolbarStyle)style
{
    self = [super init];
    if(self) {
        _toolbarStyle = style;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.toolbarExtension = 0;
    self.toolbarCanBounce = NO;
    self.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    self.toolbarShouldStay = NO;
    self.toolbarShouldAutoExpandOrCollapse = YES;
    
    if(self.toolbarStyle != OHViewControllerNoToolbar) {
        [self setupToolbar];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"view will appear %@", self.toolbar);
    [self.view bringSubviewToFront:self.toolbar];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"view did appear");
}

- (void)setupToolbar
{
    self.toolbar = [[OHToolbar alloc] init];
    [self.view addSubview:self.toolbar];
    
    [self toolbarDidLoad:self.toolbar];
}

- (void)viewWillLayoutSubviews
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    if(_lastWidth != width && _lastHeight != height) {
        NSLog(@"view will layout subviews ");
        
        self.toolbar.showStatusBar = IS_PORTRAIT;
        CGFloat statusBarHeight = IS_PORTRAIT ? kSystemStatusBarHeight : 0;
        CGFloat toolbarMaximumHeight = statusBarHeight + kToolbarDefaultHeight + self.toolbarExtension;
        
        if(self.toolbarStyle == OHViewControllerToolbarAsStatusBar) {
            toolbarMaximumHeight = statusBarHeight;
        }
        
        if(_contentScrollableView) {
            _contentScrollableView.frame = self.view.bounds;
            _contentScrollableView.contentInset = UIEdgeInsetsMake(self.padding.top + toolbarMaximumHeight,
                                                                   self.padding.left,
                                                                   self.padding.bottom,
                                                                   self.padding.right);
        } else {
#ifdef DEBUG
            NSLog(@"Warning: content scrollable view is not set");
#endif
        }
        
        if(_lastWidth == 0) {
            _toolbarHeight = toolbarMaximumHeight;
            _scrollViewLastContentOffsetY = -toolbarMaximumHeight;
            self.contentScrollableView.contentOffset = CGPointMake(0, -toolbarMaximumHeight);
        }
        
        if(self.toolbarStyle == OHViewControllerToolbarAsStatusBar) {
            self.toolbar.frame = CGRectMake(0,
                                            0,
                                            CGRectGetWidth(self.view.bounds),
                                            statusBarHeight);
        } else if(self.toolbarStyle == OHViewControllerHasToolbar) {
            [self scrollViewDidScroll:_contentScrollableView];
        }
        
        _lastWidth = width;
        _lastHeight = height;
    }
}

- (void)setContentScrollableView:(UIScrollView *)contentScrollableView
{
    _contentScrollableView = contentScrollableView;
    _contentScrollableView.delegate = self;
    if(_contentScrollableView.superview) {
#ifdef DEBUG
        NSLog(@"Warning: do not assign content scroll view a parent");
#endif
    } else {
        [self.view addSubview:_contentScrollableView];
    }
}

- (void)doExpandOrCollapse
{
    CGFloat statusBarHeight = self.toolbar.showStatusBar ? kSystemStatusBarHeight : 0;
    CGFloat toolbarDefaultHeight = statusBarHeight + kToolbarDefaultHeight;
    CGFloat toolbarMinimumHeight = self.toolbarShouldStay ? (statusBarHeight + kToolbarDefaultHeight) : statusBarHeight;
    
    if(_toolbarHeight < toolbarDefaultHeight) {
        CGFloat progress = _toolbarHeight / toolbarDefaultHeight;
        CGFloat targetHeight = _toolbarHeight;
        BOOL expand = NO;
        NSLog(@"progress %f", progress);
        if(progress < 0.5) {
            targetHeight = toolbarMinimumHeight;
        } else {
            expand = YES;
            targetHeight = toolbarDefaultHeight;
        }
        
        CGRect finalFrame = CGRectMake(0, 0,
                                       CGRectGetWidth(self.view.bounds),
                                       targetHeight);
        
        [UIView animateWithDuration:0.15 animations:^{
            [self toolbar:self.toolbar willLayoutTo:finalFrame expand:expand];
            self.toolbar.frame = finalFrame;
        } completion:^(BOOL finished) {
            _toolbarHeight = targetHeight;
        }];
    }
}

#pragma marks - for child class to implement

- (void)toolbar:(OHToolbar *)toolbar willLayoutTo:(CGRect)frame expand:(BOOL)isExpand
{
    
}

- (void)toolbarDidLoad:(OHToolbar *)toolbar
{
    
}

- (void)toolbarDidLayout:(OHToolbar *)toolbar
{
    
}

#pragma marks - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.toolbarStyle != OHViewControllerHasToolbar) {
        return;
    }
    CGFloat width = CGRectGetWidth(self.view.bounds);
    
    CGFloat yOffset = scrollView.contentOffset.y;
    CGFloat yDiff = yOffset - _scrollViewLastContentOffsetY;
    
    CGFloat statusBarHeight = self.toolbar.showStatusBar ? kSystemStatusBarHeight : 0;
    CGFloat toolbarDefaultHeight = statusBarHeight + kToolbarDefaultHeight;
    CGFloat toolbarMaximumHeight = toolbarDefaultHeight + self.toolbarExtension;
    CGFloat toolbarMinimumHeight = self.toolbarShouldStay ? (statusBarHeight + kToolbarDefaultHeight) : statusBarHeight;
    
    _toolbarHeight -= yDiff;
    
    if(_toolbarHeight < toolbarMinimumHeight) {
        /* make sure toolbar minimum height */
        _toolbarHeight = toolbarMinimumHeight;
    } else if(yOffset > -toolbarDefaultHeight && _toolbarHeight > toolbarDefaultHeight) {
        /* make sure reveal all toolbar only when at top */
        _toolbarHeight = toolbarDefaultHeight;
    } else if(yOffset < -toolbarDefaultHeight && _toolbarHeight != toolbarMaximumHeight) {
        /* when almost reach the top, make sure maximum height if in none-boucing mode */
        _toolbarHeight = self.toolbarCanBounce ? -yOffset : MIN(toolbarMaximumHeight, -yOffset);
    }
    
    NSLog(@"scroll view offset %f diff %f toolbar height %f", yOffset, yDiff, _toolbarHeight);
    
    self.toolbar.frame = CGRectMake(0, 0, width, _toolbarHeight);
    
    _scrollViewLastContentOffsetY = yOffset;
    
    [self toolbarDidLayout:self.toolbar];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if(self.toolbarStyle != OHViewControllerHasToolbar) {
        return;
    }
    [self doExpandOrCollapse];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(self.toolbarStyle != OHViewControllerHasToolbar) {
        return;
    }
    if(!decelerate) {
        [self doExpandOrCollapse];
    }
}

@end
