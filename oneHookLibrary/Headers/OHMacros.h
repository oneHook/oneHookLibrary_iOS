//
//  OHMacros.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#ifndef oneHookLibrary_OHMacros_h
#define oneHookLibrary_OHMacros_h

#define OLDER_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0)

/** String: Identifier **/
#define DEVICE_IDENTIFIER ( ( IS_IPAD ) ? DEVICE_IPAD : ( IS_IPHONE ) ? DEVICE_IPHONE , DEVICE_SIMULATOR )

/** String: iPhone **/
#define DEVICE_IPHONE @"iPhone"

/** String: iPad **/
#define DEVICE_IPAD @"iPad"

/** String: Device Model **/
#define DEVICE_MODEL ([[UIDevice currentDevice] model])

/** String: Localized Device Model **/
#define DEVICE_MODEL_LOCALIZED ([[UIDevice currentDevice] localizedModel])

/** String: Device Name **/
#define DEVICE_NAME ([[UIDevice currentDevice] name])

/** Double: Device Orientation **/
#define DEVICE_ORIENTATION ([[UIDevice currentDevice] orientation])

#define IS_LANDSCAPE UIDeviceOrientationIsLandscape(DEVICE_ORIENTATION)
#define IS_PORTRAIT !UIDeviceOrientationIsLandscape(DEVICE_ORIENTATION)
#define STATUS_BAR_HEIGHT (SHOW_STATUS_BAR ? [UIApplication sharedApplication].statusBarFrame.size.height : 0)
#define NAVIGATION_BAR_HEIGHT self.navigationController.navigationBar.frame.size.height
#define SHOW_STATUS_BAR (IS_PORTRAIT || IS_IPAD)

/** String: Simulator **/
#define DEVICE_SIMULATOR @"Simulator"

/** BOOL: Detect if device is an iPad **/
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** BOOL: Detect if device is an iPhone or iPod **/
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** BOOL: Detect if device is an iPhone 5 **/
#define IS_IPHONE_5                                                      \
    (IS_IPHONE                                                           \
         ? CGSizeEqualToSize([[UIScreen mainScreen] preferredMode].size, \
                             CGSizeMake(640, 1136))                      \
               ? YES                                                     \
               : NO                                                      \
         : NO)

/** BOOL: IS_RETINA **/
#define IS_RETINA                                                   \
    ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && \
     [[UIScreen mainScreen] scale] == 2)

/** BOOL: Detect if device is the Simulator **/
#define IS_SIMULATOR (TARGET_IPHONE_SIMULATOR)

/** grabbing application delegate **/
#define ApplicationDelegate \
    ((AppDelegate *)[[UIApplication sharedApplication] delegate])

/** grabbing user defaults **/
#define UserDefaults [NSUserDefaults standardUserDefaults]

/** grabbing notification center **/
#define NotificationCenter [NSNotificationCenter defaultCenter]

/** grabbing shared application **/
#define SharedApplication [UIApplication sharedApplication]

/** grabbing main bundle **/
#define Bundle [NSBundle mainBundle]

/** grabbing main screen **/
#define MainScreen [UIScreen mainScreen]

/** show network activity indicator **/
#define ShowNetworkActivityIndicator() \
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES

/** hide network activity indicator **/
#define HideNetworkActivityIndicator() \
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO

/** check if network activity indicator is visible **/
#define NetworkActivityIndicatorVisible(x) \
    [UIApplication sharedApplication].networkActivityIndicatorVisible = x

/** screen width **/
#define ScreenWidth [[UIScreen mainScreen] bounds].size.width

/** screen height **/
#define ScreenHeight [[UIScreen mainScreen] bounds].size.height

/** screen scale **/
#define ScreenScale (MIN(ScreenWidth, ScreenHeight) / (IS_IPAD? 768 : 320))

/** default minimum touchable area height **/
#define TouchHeightDefault 44

/** small minimum touchable area height **/
#define TouchHeightSmall 32

/** grabbing width of view **/
#define ViewWidth(v) v.frame.size.width

/** grabbing height of view **/
#define ViewHeight(v) v.frame.size.height

/** grabbing x position of view **/
#define ViewX(v) v.frame.origin.x

/** grabbing y position of view **/
#define ViewY(v) v.frame.origin.y

#define RectX(f) f.origin.x
#define RectY(f) f.origin.y
#define RectWidth(f) f.size.width
#define RectHeight(f) f.size.height
#define RectSetWidth(f, w) CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h) CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x) CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y) CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h) CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y) CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS \
    NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
#define TIME_COMPONENTS \
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit
#define RGB(r, g, b) \
    [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1.0]
#define RGBA(r, g, b, a) \
    [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:a]

/** obtain UIColor from hex **/
#define HEXRGB(rgbValue)                                                 \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                     blue:((float)(rgbValue & 0xFF)) / 255.0             \
                    alpha:1.0]

/** obtain UIColor from hex with alpha **/
#define HEXRGBA(rgbValue, a)                                             \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0    \
                     blue:((float)(rgbValue & 0xFF)) / 255.0             \
                    alpha:a]

#define DEGREES_TO_RADIANS(angle) (angle / 180.0 * M_PI)

#endif
