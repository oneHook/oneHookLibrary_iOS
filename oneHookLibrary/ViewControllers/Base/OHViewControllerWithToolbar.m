//
//  OHViewControllerWithToolbar.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHViewControllerWithToolbar.h"
#import "OneHookFoundation.h"

@interface OHViewControllerWithToolbar() {
    
    CGFloat _lastWidth;
    CGFloat _lastHeight;
}



@end

@implementation OHViewControllerWithToolbar

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    
    [self setupToolbar];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view bringSubviewToFront:self.toolbar];
}

- (void)setupToolbar
{
    self.toolbar = [[OHToolbar alloc] init];
    [self.view addSubview:self.toolbar];
}

- (void)viewWillLayoutSubviews
{
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat height = CGRectGetHeight(self.view.bounds);
    
    if(_lastWidth != width && _lastHeight != height) {
        _lastWidth = width;
        _lastHeight = height;
        
        self.toolbar.showStatusBar = IS_PORTRAIT;
        CGFloat statusBarHeight = IS_PORTRAIT ? kSystemStatusBarHeight : 0;
        self.toolbar.frame = CGRectMake(0, 0, width, statusBarHeight + kToolbarDefaultHeight);
        
        CGFloat toolbarMaximumHeight = statusBarHeight + kToolbarDefaultHeight;
        
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

#pragma marks - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

@end
