//
//  OHToolbar.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneHookFoundation.h"

@interface OHToolbar : UIView

@property (assign, nonatomic) BOOL showStatusBar;

@property (strong, nonatomic) UIView* toolbarContainer;
@property (strong, nonatomic) UIButton* leftButton;
@property (strong, nonatomic) UIButton* rightButton;
@property (strong, nonatomic) UILabel* titleLabel;

- (CGPoint)leftButtonCenter;
- (CGPoint)rightButtonCenter;

@end
