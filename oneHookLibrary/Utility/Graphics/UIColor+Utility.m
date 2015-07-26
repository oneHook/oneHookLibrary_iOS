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
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat nah;
    [color getRed:&red green:&green blue:&blue alpha:&nah];
    return RGBA(red * 255, green * 255, blue * 255, alpha);
}

@end
