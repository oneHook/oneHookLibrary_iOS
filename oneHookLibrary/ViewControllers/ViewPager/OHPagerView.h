//
//  OHPagerViewController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-30.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHHorizontalScrollView.h"

@class OHPagerView;

@protocol OHPagerViewDatasource <NSObject>

- (NSInteger)numberOfPagesInPager:(OHPagerView *)pagerView;
- (UIView *)pagerView:(OHPagerView *)pagerView viewControllerAtIndex:(NSInteger)index;

@end

@protocol OHPagerViewDelegate <NSObject>

- (void)pagerView:(OHPagerView *)pagerView viewPurgedAt:(NSInteger)index;
- (void)pagerView:(OHPagerView *)pagerView viewAddedAt:(NSInteger)index;

@end

@interface OHPagerView : UIView <UIScrollViewDelegate>

@property (assign, nonatomic) NSInteger selectedIndex;

@property (strong, nonatomic) OHHorizontalScrollView *scrollView;
@property (weak, nonatomic) id<OHPagerViewDatasource> datasource;
@property (weak, nonatomic) id<OHPagerViewDelegate> delegate;

- (void)gotoPageAtIndex:(NSInteger)index animated:(BOOL)animated;

@end
