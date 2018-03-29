//
//  NoStatusBarImagePickerController.m
//  oneHookLibrary
//
//  Created by EagleDiao@Optimity on 2018-03-29.
//  Copyright © 2018 oneHook inc. All rights reserved.
//

#import "NoStatusBarImagePickerController.h"

@implementation NoStatusBarImagePickerController

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return nil;
}

@end
