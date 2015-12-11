//
//  AKImageViewerViewController.h
//  AKImageViewerViewController
//
//  Created by Alec Kretch on 8/28/15.
//  Copyright (c) 2015 Alec Kretch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OHImageViewerViewController : UIViewController <UIActionSheetDelegate, UIScrollViewDelegate>

@property (retain, nonatomic) IBOutlet UIImage *image;
@property (retain, nonatomic) IBOutlet UIImageView *imageView;
@property (retain, nonatomic) IBOutlet UIPanGestureRecognizer *pan;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;

@property (assign, nonatomic) BOOL disableSavingImage;

- (void)centerPictureFromPoint:(CGPoint)point ofSize:(CGSize)size withCornerRadius:(float)radius;

@end
