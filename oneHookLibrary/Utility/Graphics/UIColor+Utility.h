//
//  UIColor+Utility.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2015-07-15.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHMacros.h"

@interface UIColor (Utility)

+ (UIColor*)colorWithColor:(UIColor*)color alpha:(CGFloat)alpha;
+ (UIColor*)transitionColorFrom:(UIColor*)fromColor to:(UIColor*)toColor step:(CGFloat)step;

+ (UIColor *)lighterColorForColor:(UIColor *)c;
+ (UIColor *)darkerColorForColor:(UIColor *)c;
+ (UIColor *)darkestColorForColor:(UIColor *)c;
+ (BOOL)isLightColor:(UIColor*)c;

@end
