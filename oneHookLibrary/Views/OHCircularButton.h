//
//  OHCircularButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHButton.h"

@interface OHCircularButton : UIView

@property (strong, nonatomic) UIView* backgroundView;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* contentView;
@property (assign, nonatomic) BOOL hasShadow;

@end
