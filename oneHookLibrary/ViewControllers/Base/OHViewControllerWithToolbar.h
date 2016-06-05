//
//  OHViewControllerWithToolbar.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-06-05.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OHToolbar.h"

@interface OHViewControllerWithToolbar : UIViewController <UIScrollViewDelegate>



@property (strong, nonatomic) OHToolbar* toolbar;
@property (strong, nonatomic) UIScrollView* contentScrollableView;

/* styles */
@property (nonatomic) UIEdgeInsets padding;

@end
