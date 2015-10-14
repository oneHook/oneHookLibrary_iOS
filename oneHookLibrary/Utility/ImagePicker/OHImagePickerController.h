//
//  OHImagePickerController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-14.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHImagePickerController : NSObject

@property (weak, nonatomic) UIViewController* presentingController;

- (id)initWithViewController:(UIViewController*)presentingController;

- (void)takePhotoOrChooseFromLibrary;

@end
