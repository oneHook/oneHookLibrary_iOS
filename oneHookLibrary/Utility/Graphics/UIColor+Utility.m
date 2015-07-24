//
//  UIColor+Utility.m
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2015-07-15.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIColor+Utility.h"

@implementation UIColor (Utility)

+ (UIColor*)colorWithColor:(UIColor*)color alpha:(CGFloat)alpha
{
    const CGFloat* colors = CGColorGetComponents( color.CGColor);
    return RGBA(colors[0], colors[1], colors[2], alpha);
}

@end
