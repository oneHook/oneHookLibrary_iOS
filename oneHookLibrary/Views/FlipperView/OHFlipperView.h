//
//  OHFlipperView.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2016-11-17.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHFlipperView : UIView

@property (assign, nonatomic) CGFloat topPadding;
@property (assign, nonatomic) CGFloat leftPadding;
@property (assign, nonatomic) CGFloat rightPadding;
@property (assign, nonatomic) CGFloat bottomPadding;

@property (assign, nonatomic) CGFloat frontBottomMargin;
@property (assign, nonatomic) CGFloat bottomScale;

- (UIView*)frontPage;
- (UIView*)bottomPage;

/* child class should override this function */
- (UIView*)createPage;

- (void)flip;

@end
