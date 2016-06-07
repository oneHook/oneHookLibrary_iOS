//
//  OHFloatingActionButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-06.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHFloatingActionButton : UIView

@property (strong, nonatomic) UIView* backgroundView;
@property (strong, nonatomic) UILabel* titleLabel;
@property (strong, nonatomic) UIView* contentView;
@property (assign, nonatomic) BOOL hasShadow;

@end
