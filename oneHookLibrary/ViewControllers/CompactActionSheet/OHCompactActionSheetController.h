//
//  OHCompactActionSheetController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-07-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHCompactActionSheetController : NSObject

- (id)initWithTitle:(NSString*)title message:(NSString*)message options:(NSArray*)options;
- (void)presentInViewController:(UIViewController*)controller;

@end
