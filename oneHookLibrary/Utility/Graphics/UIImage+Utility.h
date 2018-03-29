//
//  UIImage+Utility.h
//  oneHookLibrary
//
//  Created by EagleDIao@Optimity on 2018-03-28.
//  Copyright © 2018 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)

+ (UIImage *)imageByCroppingToSquare:(UIImage *)image;
+ (UIImage *)imageByRotate:(UIImage*)image rotation:(CGFloat)degrees;
+ (UIImage *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

@end

