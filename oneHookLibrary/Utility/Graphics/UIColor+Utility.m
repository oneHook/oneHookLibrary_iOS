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


+ (UIColor*)transitionColorFrom:(UIColor*)fromColor to:(UIColor*)toColor step:(CGFloat)step
{
    CGFloat fred;
    CGFloat fgreen;
    CGFloat fblue;
    CGFloat fnah;
    [fromColor getRed:&fred green:&fgreen blue:&fblue alpha:&fnah];
    
    CGFloat tred;
    CGFloat tgreen;
    CGFloat tblue;
    CGFloat tnah;
    [toColor getRed:&tred green:&tgreen blue:&tblue alpha:&tnah];
    
    return RGBA((fred * step + tred * (1-step)) * 255,
                (fgreen * step + tgreen * (1-step)) * 255,
                (fblue * step + tblue * (1-step)) * 255,
                (fnah * step + tnah * (1-step)) * 255);
}

@end
