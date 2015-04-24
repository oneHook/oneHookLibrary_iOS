//
//  OHTableViewEffectController.h
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-23.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface OHTableViewWIthCardEffectController : NSObject

+ (void)onDequeueCell:(UITableViewCell *)cell;
+ (void)onTableViewScrolled:(UITableView *)tableView withParentView:(UIView *)view;

@end
