//
//  UIScrollView+gestureDelegate.h
//  demo
//
//  Created by LinDaobin on 2023/10/31.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView ()

@end

@implementation UIScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {

    return YES;
 }


@end

NS_ASSUME_NONNULL_END
