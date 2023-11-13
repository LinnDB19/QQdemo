//
//  PageViewController.m
//  demo
//
//  Created by LinDaobin on 2023/11/3.
//

#import <Foundation/Foundation.h>
#import "PageViewController.h"

@implementation PageViewController

-(void)viewDidLoad
{
    UIScrollView *scrollView;
    for(UIView *view in [self.view subviews])
        if([view isKindOfClass:[UIScrollView class]])
        {
            NSLog(@"pagevc中找到scrollV");
            scrollView = (UIScrollView *)view;
            for(UIGestureRecognizer *gesture in scrollView.gestureRecognizers)
            {
                //NSLog(@"scrollView gesture\n%@", gesture.description);
                if([gesture isKindOfClass:[UIPanGestureRecognizer class]])
                {
                    NSLog(@"scrollView got panGesture");
                    self.panGesture = (UIPanGestureRecognizer *)gesture;
                    break;
                }
            }
        }
    
}

@end
