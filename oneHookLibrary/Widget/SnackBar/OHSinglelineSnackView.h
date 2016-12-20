//
//  OHSinglelineSnackView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-08-29.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHBaseSnackView.h"

@interface OHSinglelineSnackView : OHBaseSnackView

@property (strong, nonatomic) UILabel* textLabel;
@property (assign, nonatomic) CGFloat padding;

- (id)initWithBackgroundStyle:(OHSnackBarBackgroundStyle)style;

@end
