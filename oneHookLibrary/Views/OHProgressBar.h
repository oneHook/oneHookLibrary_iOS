//
//  OHProgressBar.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-11.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHProgressBar : UIView

@property (assign, nonatomic) CGFloat padding;
@property (strong, nonatomic) UIColor* mainProgressColor;
@property (strong, nonatomic) UIColor* subProgressColor;
@property (assign, nonatomic) CGFloat mainProgress;
@property (assign, nonatomic) CGFloat subProgress;

- (void)setMainProgress:(CGFloat)mainProgress subProgress:(CGFloat)subProgress animated:(BOOL)animated;

@end
