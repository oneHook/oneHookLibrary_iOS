//
//  OHTagsView.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-20.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHFlowLayout.h"

@interface OHTagsView : OHFlowLayout

@property (assign, nonatomic) CGFloat tagPadding;
@property (assign, nonatomic) CGFloat tagCornerRadius;
@property (strong, nonatomic) UIColor* defaultBackgroundColor;
@property (strong, nonatomic) UIColor* defaultTextColor;

- (void)setTags:(NSArray*)tags;

@end
