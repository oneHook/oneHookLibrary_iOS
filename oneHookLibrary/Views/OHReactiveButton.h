//
//  OHReactiveButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-09.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHButton.h"

@interface OHReactiveButton : OHButton

@property (strong, nonatomic) UIView* progressView;
@property (strong, nonatomic) UIView* finishView;

- (void)showDefault;
- (void)showLoading;
- (void)startLoadingAnimation;
- (void)showFinish;

@end
