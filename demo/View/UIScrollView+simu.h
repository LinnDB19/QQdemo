//
//  UIScrollView+simu.h
//  demo
//
//  Created by LinDaobin on 2023/11/2.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIScrollView ()

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
@end

@implementation UIScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer;
{
    NSLog(@"got gesture1");
    return gestureRecognizer.state;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollView scroll");
    scrollView.bounces = NO;
}

@end

NS_ASSUME_NONNULL_END
