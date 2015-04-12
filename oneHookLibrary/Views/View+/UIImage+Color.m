//
//  UIImage+Color.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (UIImageColorAdditions)

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

@end
