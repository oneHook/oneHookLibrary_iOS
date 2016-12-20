//
//  UIView+SnackBar.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SNACK_DURATION_SHORT 2

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

typedef NS_ENUM(NSInteger, OHSnackBarFlag) {
    OHSnackBarFlagDefault = 1,
    OHSnackBarFlagImmediate,
    OHSnackBarFlagClearHistory
};

@interface OHSnack : NSObject

/* snack style */
@property (assign, nonatomic) OHSnackBarBackgroundStyle backgroundStyle;
@property (assign, nonatomic) OHSnackBarPresentationType presentationType;
@property (assign, nonatomic) OHSnackBarStyle style;
@property (strong, nonatomic) UIColor* _Nullable backgroundColor;
@property (strong, nonatomic) UIColor* _Nonnull foregroundColor;
@property (strong, nonatomic) UIFont* _Nonnull foregroundFont;

/* snack content */
@property (strong, nonatomic) NSString* _Nullable messageText;
@property (strong, nonatomic) NSAttributedString* _Nullable messageAttributedText;

/* snack flag and display parameters */
@property (assign, nonatomic) double duration;
@property (assign, nonatomic) OHSnackBarFlag snackFlag;

@end

@interface UIView (SnackBar)

+ (void)setSnackBackgroundStyle:(OHSnackBarBackgroundStyle)backgroundStyle;
+ (void)setSnackBackgroundColor:(UIColor* _Nonnull)color;
+ (void)setSnackForegroundColor:(UIColor* _Nonnull)color;
+ (void)setSnackFont:(UIFont* _Nonnull)font;

+ (void)showSnackText:(NSString* _Nonnull)text;
+ (void)showSnackText:(NSString* _Nonnull)text duration:(double)duration;
+ (void)showSnackText:(NSString* _Nonnull)text duration:(double)duration flag:(OHSnackBarFlag)flag;

+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text;
+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text duration:(double)duration;
+ (void)showSnackAttributedText:(NSAttributedString* _Nonnull)text duration:(double)duration flag:(OHSnackBarFlag)flag;

@end
