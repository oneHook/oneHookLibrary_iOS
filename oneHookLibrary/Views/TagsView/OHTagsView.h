//
//  OHTagsView.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-07-20.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHFlowLayout.h"

@class OHTagsView;


@interface OHTag : NSObject

@property (strong, nonatomic) NSString* tagString;
@property (strong, nonatomic) id tagKey;

@end

@protocol OHTagsViewDelegate <NSObject>

- (void)onTagClicked:(UIView*)tagView tag:(OHTag*)tag in:(OHTagsView*)tagsView;

@end

@interface OHTagsView : OHFlowLayout

@property (assign, nonatomic) CGFloat tagPadding;
@property (assign, nonatomic) CGFloat tagCornerRadius;
@property (strong, nonatomic) UIColor* defaultBackgroundColor;
@property (strong, nonatomic) UIColor* defaultTextColor;

@property (weak, nonatomic) id<OHTagsViewDelegate> delegate;

- (void)setTags:(NSArray*)tags;

@end
