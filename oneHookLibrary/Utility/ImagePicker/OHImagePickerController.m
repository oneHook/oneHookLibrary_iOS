//
//  OHImagePickerController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-10-14.
//  Copyright © 2015 oneHook inc. All rights reserved.
//

#import "OHImagePickerController.h"
#import "OHCompactActionSheetController.h"

@interface OHImagePickerController() <OHCompactActionSheetControllerDelegate> {
    
}

@property (strong, nonatomic) OHCompactActionSheetController* actionSheetController;
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
    } else {
        [self pickImageFromLibrary];
    }
}

- (void)pickImageFromLibrary
{
    
}

- (void)pickImageFromCamera
{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    //    picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        picker.showsCameraControls = YES;
    [self.presentingController presentViewController:picker animated:YES completion:^{
        
    }];

}

@end
