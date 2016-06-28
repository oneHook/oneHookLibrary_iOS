//
//  SimpleBadge.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-06-23.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "SimpleBadge.h"

@implementation SimpleBadge

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, 25, 25)];
    if(self) {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
        self.adjustsFontSizeToFitWidth = YES;
        self.numberOfLines = 1;
        self.clipsToBounds = YES;
        self.textAlignment = NSTextAlignmentCenter;
        self.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
    }
    return self;
}

- (void)setBadge:(int)count
{
    if(count > 99) {
        self.text = @"99+";
        self.alpha = 1;
    } else if(count > 0) {
        self.text = [NSString stringWithFormat:@"%d", count];
        self.alpha = 1;
    } else {
        self.alpha = 0;
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetWidth(self.frame) / 2;
}

@end
