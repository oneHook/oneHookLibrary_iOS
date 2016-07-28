//
//  AKImageViewerViewController.m
//  AKImageViewerViewController
//
//  Created by Alec Kretch on 8/28/15.
//  Copyright (c) 2015 Alec Kretch. All rights reserved.
//

#import "OHImageViewerViewController.h"
#import "OHCompactActionSheetController.h"

@interface OHImageViewerViewController () <OHCompactActionSheetControllerDelegate>

@property (strong, nonatomic) UIImage* displayingImage;
@property (strong, nonatomic) NSObject* imageKey;
@property (strong, nonatomic) OHCompactActionSheetController* actionSheetController;

@end

@implementation OHImageViewerViewController

- (id)initWithPlaceholderImage:(UIImage *)image imageKey:(NSString *)imageKey
{
    self = [super init];
    if(self) {
        self.displayingImage = image;
        self.imageKey = imageKey;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.scrollView.maximumZoomScale = 3.0;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.zoomScale = 1.0;
    self.scrollView.delegate = self;
    self.scrollView.userInteractionEnabled = YES;
    [self.view addSubview:self.scrollView];
    
    UITapGestureRecognizer *tapOnce = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapOnce:)];
    UITapGestureRecognizer *tapTwice = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTwice:)];
    tapOnce.numberOfTapsRequired = 1;
    tapTwice.numberOfTapsRequired = 2;
    [tapOnce requireGestureRecognizerToFail:tapTwice];
    
    [self.scrollView addGestureRecognizer:tapOnce];
    [self.scrollView addGestureRecognizer:tapTwice];
}


- (void)presentPictureIn:(UIViewController*)parentViewController fromPoint:(CGPoint)point ofSize:(CGSize)size withCornerRadius:(float)radius
{
    [parentViewController addChildViewController:self];
    [parentViewController.view addSubview:self.view];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(point.x, point.y, size.width, size.height)];
    self.imageView.layer.cornerRadius = radius;
    self.imageView.clipsToBounds = YES;
    
    UIImage* image = self.displayingImage;
    self.imageView.image = image;
    [self.scrollView addSubview:self.imageView];
    
    [UIView animateWithDuration:0.3f animations:^{
        CGFloat imageWidth = image.size.width;
        CGFloat imageHeight = image.size.height;
        CGFloat imageRatio = imageWidth/imageHeight;
        CGFloat viewRatio = self.view.frame.size.width/self.view.frame.size.height;
        CGFloat ratio;
        if (imageRatio >= viewRatio) //image is wider
        {
            ratio = imageWidth/self.view.frame.size.width;
        }
        else
        {
            ratio = imageHeight/self.view.frame.size.height;
        }
        CGFloat newWidth = imageWidth/ratio;
        CGFloat newHeight = imageHeight/ratio;
        self.imageView.frame = CGRectMake(self.scrollView.frame.origin.x, self.scrollView.frame.origin.y, newWidth, newHeight);
        self.imageView.center = self.scrollView.center;
        self.imageView.layer.cornerRadius = 0.0;
        self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    } completion:^(BOOL finished) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        if (!self.disableSavingImage)
        {
            UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
            [self.scrollView addGestureRecognizer:longPress];
        }
        self.pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveImage:)];
        [self.scrollView addGestureRecognizer:self.pan];
        
        /* we can load high res now if needed */
        if(self.delegate) {
            typeof(self) weakSelf = self;
            [self.delegate imageViewer:self
                     loadHighResForKey:self.imageKey
                         progressBlock:^(double progress) {
                         } completionBlock:^(UIImage *image) {
                             weakSelf.displayingImage = image;
                             weakSelf.imageView.image = self.displayingImage;
                         }];
        }
    }];

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.scrollView.frame = self.view.bounds;
    [self centerScrollViewContents];
}

- (void)tapOnce:(UIGestureRecognizer *)gestureRecognizer
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [UIView animateWithDuration:0.3f animations:^{
        self.view.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        self.delegate = nil;
    }];
}

- (void)tapTwice:(UIGestureRecognizer *)gestureRecognizer
{
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) //if zoomed all the way out
    {
        CGRect zoomRect = [self zoomRectForScale:self.scrollView.maximumZoomScale withCenter:[gestureRecognizer locationInView:gestureRecognizer.view]];
        [self.scrollView zoomToRect:zoomRect animated:YES]; //zoom in at the tapped point
    }
    else
    {
        [self.scrollView setZoomScale:self.scrollView.minimumZoomScale animated:YES]; //or else zoom out on double tap
    }
    
}

- (void)moveImage:(UIPanGestureRecognizer *)gesture
{
    int deltaY = [gesture translationInView:self.scrollView].y;
    CGPoint translatedPoint = CGPointMake(self.view.center.x, self.view.center.y+deltaY);
    self.scrollView.center = translatedPoint;
    
    if ((gesture.state == UIGestureRecognizerStateEnded))
    {
        CGFloat velocityY = ([gesture velocityInView:self.scrollView].y);
        int maxDeltaY = (self.view.frame.size.height-self.imageView.frame.size.height)/2;
        if (velocityY > 700 || (abs(deltaY)>maxDeltaY && deltaY>0)) //swipe down
        {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [UIView animateWithDuration:0.3f animations:^{
                self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, self.view.frame.size.height, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.view.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
        }
        else if (velocityY < -700 || (abs(deltaY)>maxDeltaY && deltaY<0)) //swipe up
        {
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [UIView animateWithDuration:0.3f animations:^{
                self.imageView.frame = CGRectMake(self.imageView.frame.origin.x, -self.imageView.frame.size.height, self.imageView.frame.size.width, self.imageView.frame.size.height);
                self.view.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self.view removeFromSuperview];
            }];
        }
        else //return to center
        {
            [UIView animateWithDuration:0.1f animations:^{
                self.scrollView.center = self.view.center;
            }];
        }
    }
    
}

- (void)longPress:(UILongPressGestureRecognizer *)gesture {
    if(UIGestureRecognizerStateBegan == gesture.state)
    {
        OHCompactActionSheetController* actionSheet = [[OHCompactActionSheetController alloc] initWithTitle:nil
                                                                                                    message:@""
                                                                                                    options:@[@"Save to camera roll"]];
        self.actionSheetController = actionSheet;
        self.actionSheetController.delegate = self;
        [self.actionSheetController presentInViewController:self];
    }
}

- (void)actionSheetController:(OHCompactActionSheetController *)controller indexSelected:(NSInteger)index itemTitle:(NSString *)title
{
    self.actionSheetController = nil;
    if(index == 0) {
        UIImageWriteToSavedPhotosAlbum(self.imageView.image,
                                       self,
                                       @selector(image:finishedSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *) error contextInfo:(void *)contextInfo
{
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Uh, oh!" message: @"There was a problem saving the photo." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Success!" message: @"The picture has been saved to your camera roll." delegate: nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)centerScrollViewContents
{
    CGSize boundsSize = self.scrollView.bounds.size;
    CGRect contentsFrame = self.imageView.frame;
    
    if (contentsFrame.size.width < boundsSize.width)
    {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    }
    else
    {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height)
    {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    }
    else
    {
        contentsFrame.origin.y = 0.0f;
    }
    
    self.imageView.frame = contentsFrame;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
    
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    [self centerScrollViewContents];
    if (self.scrollView.zoomScale == self.scrollView.minimumZoomScale) {
        [self.scrollView addGestureRecognizer:self.pan];
    } else {
        [self.scrollView removeGestureRecognizer:self.pan];
    }
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    
    zoomRect.size.height = self.imageView.frame.size.height / scale;
    zoomRect.size.width  = self.imageView.frame.size.width  / scale;
    
    center = [self.imageView convertPoint:center fromView:self.view];
    
    zoomRect.origin.x = center.x - ((zoomRect.size.width / 2.0));
    zoomRect.origin.y = center.y - ((zoomRect.size.height / 2.0));
    
    return zoomRect;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
