//
//  OHTableViewEffectController.m
//  oneHookLibrary
//
//  Created by Eagle Diao on 2015-04-23.
//  Copyright (c) 2015 oneHook inc. All rights reserved.
//

#import "OHTableViewWIthCardEffectController.h"

@implementation OHTableViewWIthCardEffectController

+ (void)onDequeueCell:(UITableViewCell *)cell {
    cell.layer.anchorPoint = CGPointMake(0.5, 0);
    cell.layer.transform = CATransform3DIdentity;
}

+ (void)onTableViewScrolled:(UITableView *)tableView withParentView:(UIView *)view {
    NSArray *visibleCells = tableView.visibleCells;
    CGFloat topOffset = tableView.contentOffset.y + tableView.contentInset.top;

    if (topOffset <= 0) {
        for (UIView *cell in visibleCells) {
            CATransform3D transform = CATransform3DIdentity;
            transform.m34 = 1.0 / -500;
            cell.layer.transform = CATransform3DRotate(transform, topOffset * 0.005, 1.0, 0, 0);
        }
    } else {
        for (UIView *cell in visibleCells) {

            CGPoint p = [cell.superview convertPoint:cell.center toView:view];
            CGFloat yPos = p.y;
            if (yPos < 0) {
                CATransform3D transform = CATransform3DMakeTranslation(0, -yPos, yPos);
                cell.layer.transform = transform;
            } else {
                cell.layer.transform = CATransform3DIdentity;
            }
        }
    }
}

@end
