//
//  OHImagePickerController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-14.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHImagePickerController;

@protocol OHImagePickerControllerDelegate <NSObject>

- (void)oh_imagePickerController:(OHImagePickerController*)pickerController imagePicked:(UIImage*)image;
- (void)oh_imagePickerControllerCancelled:(OHImagePickerController *)pickerController;
- (void)oh_imagePickerControllerPhotoPermissionDenied:(OHImagePickerController*)pickerController;
- (void)oh_imagePickerControllerCameraPermissionDenied:(OHImagePickerController*)pickerController;

@end

@interface OHImagePickerController : NSObject

@property (weak, nonatomic) UIViewController* presentingController;
@property (weak, nonatomic) id<OHImagePickerControllerDelegate> delegate;

- (id)initWithViewController:(UIViewController*)presentingController;
- (void)takePhotoOrChooseFromLibrary;
- (void)pickImageFromCamera;

@end
