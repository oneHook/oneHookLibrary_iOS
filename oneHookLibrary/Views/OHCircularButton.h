//
//  OHCircularButton.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-03-27.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHButton.h"

@interface OHCircularButton : UIView

@property (strong, nonatomic) UIButton *button;

// User can override this function to set customized style
- (void)doInit;

- (void)setButtonBackgroundWithNormalState:(UIColor *)normalColor pressedState:(UIColor *)pressedColor disabledState:(UIColor *)disabledColor;
- (void)setButtonTextColorWithNormalState:(UIColor *)normalColor pressedState:(UIColor *)pressedColor disabledState:(UIColor *)disabledColor;

- (void)setButtonTextWithAllState:(NSString *)text;
- (void)setButtonTextWithNormalState:(NSString *)normalText pressedState:(NSString *)pressedText disabledState:(NSString *)disabledText;
- (void)setButtonAttributedTextWithNormalState:(NSAttributedString *)normalText pressedState:(NSAttributedString *)pressedText disabledState:(NSAttributedString *)disabledText;
@end
