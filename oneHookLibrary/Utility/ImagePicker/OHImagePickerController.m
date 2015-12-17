//
//  OHImagePickerController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-14.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHImagePickerController.h"
#import "OHCompactActionSheetController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface OHImagePickerController() <OHCompactActionSheetControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
}

@property (strong, nonatomic) OHCompactActionSheetController* actionSheetController;
@property (weak, nonatomic) UIImagePickerController* imagePicker;
@property (strong, nonatomic) NSMutableArray* options;

@end

@implementation OHImagePickerController

- (id)initWithViewController:(UIViewController*)presentingController
{
    self = [super init];
    if(self) {
        self.presentingController = presentingController;
        self.options = [[NSMutableArray alloc] init];
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            [self.options addObject:@"Take photo"];
        }
        [self.options addObject:@"Choose from library"];
    }
    return self;
}

- (void)takePhotoOrChooseFromLibrary
{
    OHCompactActionSheetController* actionSheet = [[OHCompactActionSheetController alloc] initWithTitle:@"Choose your image"
                                                                                                message:@""
                                                                                                options:self.options];
    self.actionSheetController = actionSheet;
    self.actionSheetController.delegate = self;
    [self.actionSheetController presentInViewController:self.presentingController];
}

- (void)actionSheetController:(OHCompactActionSheetController *)controller indexSelected:(NSInteger)index itemTitle:(NSString *)title
{
    self.actionSheetController = nil;
    if(self.options.count > 1 && index == 0) {
        [self pickImageFromCamera];
    } else if(self.options.count - 1 == index) {
        [self pickImageFromLibrary];
    } else {
        [self.delegate oh_imagePickerControllerCancelled:self];
    }
}

- (void)pickImageFromLibrary
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    self.imagePicker = picker;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.presentingController presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)pickImageFromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    self.imagePicker = picker;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
    picker.showsCameraControls = YES;
    [self.presentingController presentViewController:picker animated:YES completion:^{
        
    }];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    NSString *mediaType = info[UIImagePickerControllerMediaType];
    UIImage *originalImage, *editedImage, *imageToSave;
    
    // Handle a still image capture
    if (CFStringCompare ((CFStringRef) mediaType, kUTTypeImage, 0) == kCFCompareEqualTo) {
        editedImage = (UIImage *) info[UIImagePickerControllerEditedImage];
        originalImage = (UIImage *) info[UIImagePickerControllerOriginalImage];
        
        if (editedImage) {
            imageToSave = editedImage;
        } else if (originalImage) {
            imageToSave = originalImage;
        } else {
//            if ([self.delegate respondsToSelector:@selector(takeController:didFailAfterAttempting:)])
//                [self.delegate takeController:self didFailAfterAttempting:YES];
            return;
        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        if(imageToSave) {
            [self.delegate oh_imagePickerController:self imagePicked:imageToSave];
        }
    }];
    self.imagePicker = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{

    [self.delegate oh_imagePickerControllerCancelled:self];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
