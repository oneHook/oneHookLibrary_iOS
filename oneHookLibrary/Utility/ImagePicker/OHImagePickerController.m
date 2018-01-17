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
#import <Photos/Photos.h>
#import "OHLocalization.h"

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
            [self.options addObject:[OHLocalization localizedString:@"Take photo"]];
        }
        [self.options addObject:[OHLocalization localizedString:@"Choose from library"]];
    }
    return self;
}

- (void)takePhotoOrChooseFromLibrary
{
    OHCompactActionSheetController* actionSheet = [[OHCompactActionSheetController alloc]
                                                   initWithTitle:[OHLocalization localizedString:@"Choose your image"]
                                                   message:@""
                                                   options:self.options];
    self.actionSheetController = actionSheet;
    self.actionSheetController.delegate = self;
    [self.actionSheetController presentInViewController:self.presentingController];
}

- (void)actionSheetController:(OHCompactActionSheetController *)controller indexSelected:(NSInteger)index itemTitle:(NSString *)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.actionSheetController = nil;
        if(self.options.count > 1 && index == 0) {
            [self checkCameraPermission];
        } else if(self.options.count - 1 == index) {
            [self checkPhotoPermission];
        } else {
            [self.delegate oh_imagePickerControllerCancelled:self];
        }
    });
}

- (void)checkPhotoPermission
{
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if(status == PHAuthorizationStatusAuthorized) {
        [self doPickPhoto];
    } else if(status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(status == PHAuthorizationStatusAuthorized) {
                    [self doPickPhoto];
                } else {
                    [self onNoPhotoPermission];
                }
            });
        }];
    } else {
        [self onNoPhotoPermission];
    }
}

- (void)onNoPhotoPermission
{
    [self.delegate oh_imagePickerControllerPhotoPermissionDenied:self];
}

- (void)doPickPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    self.imagePicker = picker;
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self.presentingController presentViewController:picker animated:YES completion:^{
        
    }];
}

- (void)checkCameraPermission
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized) {
        [self doCaptureImageFromCamera];
    } else if(authStatus == AVAuthorizationStatusNotDetermined){
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if(granted){
                    [self doCaptureImageFromCamera];
                } else {
                    [self onCameraPermissionDenied];
                }
            });
        }];
    } else {
        [self onCameraPermissionDenied];
    }}

- (void)onCameraPermissionDenied
{
    [self.delegate oh_imagePickerControllerCameraPermissionDenied:self];
}

- (void)doCaptureImageFromCamera
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
    //https://stackoverflow.com/questions/29836488/uiimagepickercontrolleroriginalimage-nil-causing-crash-on-photo-capture
    //We have seen this particular stack/crash. This is just for safety purposes
    if ([[UIApplication sharedApplication] applicationState] != UIApplicationStateActive)
        return;
    
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

- (void)pickImageFromCamera
{
    [self checkCameraPermission];
}

@end
