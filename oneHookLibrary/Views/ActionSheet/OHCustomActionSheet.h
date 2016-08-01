//
//  OHCutomActionSheet.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-08-01.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

enum OHCustomActionSheetRevealStyle {
    OHCustomActionSheetRevealStyleTop,
    OHCustomActionSheetRevealStyleBottom
};

@interface OHCustomActionSheet : UIView

@property (assign, nonatomic) enum OHCustomActionSheetRevealStyle revealStyle;


- (void)showInView:(UIView*)view;

@end
