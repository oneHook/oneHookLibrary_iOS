//
//  OHBaseSnackView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SnackBar.h"

@interface OHBaseSnackView : UIView

@property (assign, nonatomic) double idleTime;
@property (assign, nonatomic) OHSnackBarBackgroundStyle backgroundStyle;

- (id)initWithBackgroundStyle:(OHSnackBarBackgroundStyle)style;

- (CGFloat)measureHeightByWidth:(CGFloat)width;

@end
