//
//  OHRoundButton.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-03-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import "OHRoundButton.h"

@implementation OHRoundButton

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat length = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
    self.layer.cornerRadius = length / 2;
}

@end
