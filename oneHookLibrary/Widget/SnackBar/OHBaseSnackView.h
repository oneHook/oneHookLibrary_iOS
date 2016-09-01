//
//  OHBaseSnackView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHBaseSnackView : UIView

@property (assign, nonatomic) double idleTime;

- (CGFloat)measureHeightByWidth:(CGFloat)width;

@end
