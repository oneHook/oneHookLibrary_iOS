//
//  OHViewControllerWithToolbar.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHToolbar.h"
#import "OHFloatingActionButton.h"

typedef NS_ENUM(NSInteger, OHViewControllerToolbarStyle) {
    OHViewControllerNoToolbar,
    OHViewControllerToolbarAsStatusBar,
    OHViewControllerHasToolbar
};

typedef NS_ENUM(NSInteger, OHViewControllerFloatingActionButtonStyle) {
    OHViewControllerFloatingActionButtonStyleAlwaysBottom,
    OHViewControllerFloatingActionButtonStyleDefault
};

@interface OHViewController : UIViewController <UIScrollViewDelegate>

- (id)initWithStyle:(OHViewControllerToolbarStyle)style;

@property (strong, nonatomic) OHToolbar* toolbar;
@property (strong, nonatomic) UIScrollView* contentScrollableView;
@property (assign, nonatomic) OHViewControllerFloatingActionButtonStyle floatingActionButtonStyle;
@property (assign, nonatomic) BOOL hasPullToRefresh;
@property (assign, nonatomic, readonly) BOOL isRefreshing;
@property (assign, nonatomic) CGFloat pullToRefreshTriggerOffset;

/* styles */

@property (nonatomic, readonly) OHViewControllerToolbarStyle toolbarStyle;      // toolbar style, read only.

@property (nonatomic) BOOL toolbarCanBounce;                                    // determine if toolbar height can go over maximum height
@property (nonatomic) BOOL toolbarShouldStay;                                   // should the toolbar default size always visible
@property (nonatomic) BOOL toolbarShouldAutoExpandOrCollapse;                   // should the toolbar always expand to default size or minimum size

@property (nonatomic) CGFloat toolbarExtension;
@property (nonatomic) UIEdgeInsets padding;

- (CGFloat)defaultToolbarHeight;
- (CGFloat)maximumToolbarHeight;

- (void)manageFloatingActionButton:(OHFloatingActionButton*)fabButton;
- (void)endRefreshing;

/* child can override the following functions for call back */

- (void)toolbarDidLoad:(OHToolbar*)toolbar;
- (void)toolbar:(OHToolbar*)toolbar willLayoutTo:(CGRect)frame expand:(BOOL)isExpand;
- (void)toolbarDidLayout:(OHToolbar*)toolbar;

- (void)willStartPullToRefresh:(CGFloat)progress starting:(BOOL)starting;

@end
