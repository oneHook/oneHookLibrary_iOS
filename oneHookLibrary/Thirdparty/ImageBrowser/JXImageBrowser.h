//
//  JXImageViewer.h
//  JXImageBrowser
//
//  Created by CoderSun on 4/21/16.
//  Copyright © 2016 CoderSun. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ImageLoaderProressBlock)(NSInteger receivedSize, NSInteger expectedSize);
typedef void(^ImageLoaderCompleteBlock)(UIImage *image, NSError *error, BOOL finished);


@protocol JXImageLoader <NSObject>

@required

- (void)downloadImageWithURL:(NSURL *)url progress:(ImageLoaderProressBlock)progressBlock completed:(ImageLoaderCompleteBlock)completedBlock;

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface JXImage : NSObject
/**
 *  Url of image.
 *  图片的 url.
 */
@property (nonatomic, strong) NSURL         *urlImg;

/**
 *  ImageView from.(option)
 *  图片的来源 imageView.(可不传)
 */
@property (nonatomic, strong) UIImageView   *imageViewFrom;

@end

NS_CLASS_AVAILABLE_IOS(8_0) @interface JXImageBrowser : UIView

/**
 *  Browse images.
 *  浏览图片.
 *
 *  @param images    Images will be showed.
 *  @param images    将要显示的图片数组.
 *  @param fromIndex The index of first show.
 *  @param fromIndex 最先显示的索引.
 */
+ (void)browseImages:(NSArray <JXImage *> *)images fromIndex:(NSInteger)fromIndex imageLoader:(id<JXImageLoader>)loader;

NS_ASSUME_NONNULL_END

@end
