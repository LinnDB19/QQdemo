//
//  ViewController.h
//  demo
//
//  Created by Abakus on 2023/6/25.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface ViewController : UIViewController<UIPageViewControllerDataSource, UIPageViewControllerDelegate, UIScrollViewDelegate, UIGestureRecognizerDelegate>
@property(strong, nonatomic) UIScrollView *scrollView;
@end

