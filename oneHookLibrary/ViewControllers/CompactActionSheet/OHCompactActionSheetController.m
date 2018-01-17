//
//  OHCompactActionSheetController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-07-24.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHCompactActionSheetController.h"
#import "OHMacros.h"
#import "OHLocalization.h"

@interface OHCompactActionSheetController() {
    NSString* _title;
    NSString* _message;
    NSArray* _options;
}

@end

@implementation OHCompactActionSheetController

- (id)initWithTitle:(NSString*)title message:(NSString*)message options:(NSArray*)options
{
    self = [super init];
    if(self) {
        _title = title;
        _message = message;
        _options = options;
    }
    return self;
}

- (void)presentInViewController:(UIViewController *)controller
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:_title message:_message preferredStyle:UIAlertControllerStyleActionSheet];
    NSInteger index = 0;
    for(NSString* option in _options) {
        [alertController addAction:[UIAlertAction actionWithTitle:option style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.delegate actionSheetController:self indexSelected:index itemTitle:option];
        }]];
        index++;
    }
    [alertController addAction:[UIAlertAction actionWithTitle:[OHLocalization localizedString:@"Cancel"] style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        [self.delegate actionSheetController:self indexSelected:-1 itemTitle:@"Cancel"];
    }]];
    [controller presentViewController:alertController animated:YES completion:^{
        
    }];
}

@end
