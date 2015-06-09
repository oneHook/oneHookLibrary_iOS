//
//  OHTooltipView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-06-08.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHTooltipView : UIView

@property (assign, nonatomic) CGRect focusArea;

- (void)animateReveal;

@end
