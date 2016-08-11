//
//  NYTSimplePhoto.h
//  oneHookLibrary
//
//  Created by Eagle Diao@ToMore on 2016-08-10.
//  Copyright © 2016 oneHook inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NYTPhoto.h"

@interface NYTSimplePhoto : NSObject <NYTPhoto>

@property (nonatomic) UIImage *image;
@property (nonatomic) NSData *imageData;
@property (nonatomic) UIImage *placeholderImage;
@property (nonatomic) NSAttributedString *attributedCaptionTitle;
@property (nonatomic) NSAttributedString *attributedCaptionSummary;
@property (nonatomic) NSAttributedString *attributedCaptionCredit;

@property (weak, nonatomic) UIView* referenceView;

@end
