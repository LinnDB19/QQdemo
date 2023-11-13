//
//  PageViewController.h
//  demo
//
//  Created by LinDaobin on 2023/11/3.
//

#ifndef PageViewController_h
#define PageViewController_h

#import <UIKit/UIKit.h>

@interface PageViewController : UIPageViewController
@property(weak, nonatomic) UIPanGestureRecognizer *panGesture; // 平移
@end

#endif /* PageViewController_h */
