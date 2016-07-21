//
//  AKImageViewerViewController.h
//  AKImageViewerViewController
//
//  Created by Alec Kretch on 8/28/15.
//  Copyright (c) 2015 Alec Kretch. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OHImageViewerViewController;

@protocol OHImageViewerViewControllerDelegate

- (void)imageViewer:(OHImageViewerViewController*)controller
  loadHighResForKey:(NSObject*)imageKey
      progressBlock:(void (^)(double))progressBlock
    completionBlock:(void (^)(UIImage*))completionBlock;

@end

@interface OHImageViewerViewController : UIViewController <UIActionSheetDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *pan;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) id<OHImageViewerViewControllerDelegate> delegate;

@property (assign, nonatomic) BOOL disableSavingImage;

- (id)initWithPlaceholderImage:(UIImage*)image imageKey:(NSObject*)imageKey;
- (void)presentPictureIn:(UIViewController*)parentViewController fromPoint:(CGPoint)point ofSize:(CGSize)size withCornerRadius:(float)radius;

@end
