//
//  OHPullToRefreshWidget.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-10-04.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneHookFoundation.h"

@protocol OHPullToRefreshWidgetDelegate <NSObject>

- (void)willStartPullToRefresh:(CGFloat)progress starting:(BOOL)starting;

@end

@interface OHPullToRefreshWidget : NSObject

@property (weak, nonatomic) id<OHPullToRefreshWidgetDelegate> delegate;

- (void)didScroll:(UIScrollView*)scrollView;
- (void)didEndDragging:(UIScrollView*)scrollView;
- (void)endRefreshing;

@end
