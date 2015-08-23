//
//  UIImageViewWithOverlay.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-08-13.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageViewWithOverlay : UIImageView

@property (assign, nonatomic) BOOL showOverlay;
@property (assign, nonatomic) BOOL showPlaceholder;
@property (strong, nonatomic) UIImage* placeholderImage;

@end
