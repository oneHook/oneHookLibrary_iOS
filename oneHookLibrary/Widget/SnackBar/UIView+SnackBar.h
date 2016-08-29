//
//  UIView+SnackBar.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SNACK_DURATION_SHORT 1

typedef NS_ENUM(NSUInteger, OHSnackBarPresentationType) {
    OHSnackBarPresentationTypeBottom = 1,
    OHSnackBarPresentationTypeTop,
    OHSnackBarPresentationTypeFade
};

typedef NS_ENUM(NSUInteger, OHSnackBarStyle) {
    OHSnackBarStyleSingleText = 1
};

typedef NS_ENUM(NSInteger, OHSnackBarBackgroundStyle) {
    OHSnackBarBackgroundStyleSolid = 1,
    OHSnackBarBackgroundStyleLightBlur,
    OHSnackBarBackgroundStyleDarkBlur
};

@interface OHSnack : NSObject

@property (assign, nonatomic) OHSnackBarBackgroundStyle backgroundStyle;
@property (assign, nonatomic) OHSnackBarPresentationType presentationType;
@property (assign, nonatomic) OHSnackBarStyle style;
@property (strong, nonatomic) NSString* messageText;
@property (strong, nonatomic) NSAttributedString* messageAttributedText;
@property (strong, nonatomic) UIColor* backgroundColor;
@property (strong, nonatomic) UIColor* foregroundColor;
@property (strong, nonatomic) UIFont* foregroundFont;

@end

@interface UIView (SnackBar)

+ (void)setBackgroundStyle:(OHSnackBarBackgroundStyle)backgroundStyle;
+ (void)setBackgroundColor:(UIColor*)color;
+ (void)setForegroundColor:(UIColor*)color;
+ (void)setFont:(UIFont*)font;

+ (void)showText:(NSString*)text;
+ (void)showAttributedText:(NSAttributedString*)attributedText;

@end
