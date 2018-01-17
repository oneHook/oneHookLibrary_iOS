//
//  OHCompactActionSheetController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-07-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHCompactActionSheetController;

@protocol OHCompactActionSheetControllerDelegate <NSObject>

- (void)actionSheetController:(OHCompactActionSheetController*)controller indexSelected:(NSInteger)index itemTitle:(NSString*)title;

@end

@interface OHCompactActionSheetController : NSObject

- (id)initWithTitle:(NSString*)title message:(NSString*)message options:(NSArray*)options;
- (void)presentInViewController:(UIViewController*)controller;

@property (weak, nonatomic) id <OHCompactActionSheetControllerDelegate> delegate;

@end
