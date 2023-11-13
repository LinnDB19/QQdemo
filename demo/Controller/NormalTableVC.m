//
//  NormalTableVC.m
//  demo
//
//  Created by LinDaobin on 2023/11/2.
//

#import <Foundation/Foundation.h>
#import "NormalTableVC.h"
#import "SlideViewController.h"

@interface NormalTableVC()

@end

@implementation NormalTableVC

-(void)viewDidLoad
{
    self.panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:nil];
    self.panGesture.cancelsTouchesInView = NO;
    self.panGesture.delaysTouchesBegan = YES;
    self.panGesture.delegate = self;
    [self.tableView addGestureRecognizer:self.panGesture];

}

#pragma mark gestureDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (![gestureRecognizer isMemberOfClass:[UIPanGestureRecognizer class]]) {
        return NO;
    }
    UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer *)gestureRecognizer;
    CGPoint translation = [panGesture translationInView:self.tableView]; // 滑动手势对于self.view的偏移量
    CGPoint location = [panGesture locationInView:self.tableView];
    NSIndexPath *index = [self.tableView indexPathForRowAtPoint:location];
    if(index)
    {
        //NSLog(@"点在cell上，tableview响应");
    }
    else
    {
        //NSLog(@"点不在cell上，tableView不响应");
    }
    return translation.x < 0 || (index && self.tableView.isEditing);
}

//多个手势同时响应，如果两个手势都是在tableView，那么不应该阻碍。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return otherGestureRecognizer.view == self.tableView;
}

@end
