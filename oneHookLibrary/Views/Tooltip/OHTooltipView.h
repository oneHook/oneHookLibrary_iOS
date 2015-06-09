//
//  OHTooltipView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-06-08.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHTooltipView;

@protocol OHTooltipViewDelegate <NSObject>

- (void)onTooltipViewClicked:(OHTooltipView*)tooltipView;
- (void)onTooltipViewRevealed:(OHTooltipView*)tooltipView;
- (void)onTooltipViewDismissed:(OHTooltipView*)tooltipView;
@end

@interface OHTooltipView : UIView

@property (strong, nonatomic) UIView* contentView;
@property (assign, nonatomic) CGRect focusArea;
@property (assign, nonatomic) id <OHTooltipViewDelegate> delegate;

- (void)animateReveal;
- (void)animateDismiss;

@end
