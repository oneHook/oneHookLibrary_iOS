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

+ (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

+ (UIColor *)darkestColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.4, 0.0)
                               green:MAX(g - 0.4, 0.0)
                                blue:MAX(b - 0.4, 0.0)
                               alpha:a];
    return nil;
}

+ (BOOL)isLightColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    [c getRed:&r green:&g blue:&b alpha:&a];
    double darkness = 1 - (r * 0.299 + g * 0.587 + b * 0.114);
    return darkness < 0.5;
}

@end
