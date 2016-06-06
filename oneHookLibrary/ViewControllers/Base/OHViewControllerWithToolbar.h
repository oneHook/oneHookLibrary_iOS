//
//  OHViewControllerWithToolbar.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHToolbar.h"

@interface OHViewControllerWithToolbar : UIViewController <UIScrollViewDelegate>



@property (strong, nonatomic) OHToolbar* toolbar;
@property (strong, nonatomic) UIScrollView* contentScrollableView;

/* styles */
@property (nonatomic) BOOL toolbarCanBounce;
@property (nonatomic) BOOL toolbarShouldStay;
@property (nonatomic) CGFloat toolbarExtension;
@property (nonatomic) UIEdgeInsets padding;

/* child can override the following functions for call back */

- (void)toolbarDidLayout:(OHToolbar*)toolbar;

@end
