//
//  ViewController.m
//  demo
//
//  Created by Abakus on 2023/6/25.
//

#import "ViewController.h"
#import "TableViewController.h"
#import "IQkeyboardManager.h"
#import "ImageZoom.h"
#import "TabBarController.h"
#import "SlideViewController.h"
#import "PageViewController.h"

@interface ViewController ()
@property(strong, nonatomic) NSArray<UIViewController *>* contentVC;
@property(strong, nonatomic) UIPageViewController *pageVC;
@property(strong, nonatomic) TabBarController *tabBarC;
@property(strong, nonatomic) SlideViewController *slideVC;
@end

@implementation ViewController

-(void)viewDidLoad {

    self.view.backgroundColor = [UIColor whiteColor];
    self.pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll
                navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal
                                                                options:nil];
    
    self.pageVC.delegate = self;
    self.pageVC.dataSource = self;
    self.tabBarC = [TabBarController new];
    self.slideVC = [SlideViewController new];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:self.slideVC];
    _contentVC = @[navi, self.tabBarC];
    [self.pageVC setViewControllers:@[self.tabBarC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];

    
    [self addChildViewController:self.pageVC];
    [self.view addSubview:self.pageVC.view];
    
    for(UIView *view in [self.pageVC.view subviews])
        if([view isKindOfClass:[UIScrollView class]])
        {
            NSLog(@"pagevc里找到了scrollview");
            self.scrollView = (UIScrollView *)view;
            self.scrollView.delegate = self;
            self.scrollView.canCancelContentTouches = YES;
            [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.tabBarC.contTVC.panGesture];
            break;
        }
}

#pragma  mark dataSourceDelegate

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger i = [self.contentVC indexOfObject:viewController];
    if(i == 0 || i == NSNotFound) return nil;
    
    return self.contentVC[i - 1];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger i = [self.contentVC indexOfObject:viewController];
    if(i + 1 == self.contentVC.count || i == NSNotFound) return nil;
    
    return self.contentVC[i + 1];
}

#pragma mark pageViewControllerDelegate

//- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed
//{
//    if(!completed) return;
//    self.currentIndex = [self.contentVC indexOfObject:self.pageVC.viewControllers.firstObject];
//}

#pragma  mark scrollView Delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    UIViewController *topVC = [((UINavigationController *)[self.tabBarC selectedViewController]) topViewController];
    UIViewController *topVCLeft = [((UINavigationController *)self.contentVC[0]) topViewController];//左边的navi的当前VC
    NSLog(@"topVC %@", topVC.description);
    NSLog(@"topVCLeft %@", topVCLeft.description);
    if(!([topVC isEqual:self.tabBarC.msgTVC] || [topVC isEqual:self.tabBarC.contTVC] || [topVC isEqual:self.tabBarC.newsVC]) || ![topVCLeft isEqual:self.slideVC])
    {
        //两个page页有其中一个不是主页面时没法切换
        self.scrollView.scrollEnabled = NO;
        self.scrollView.scrollEnabled = YES;
        NSLog(@"不在首页，PageViewController不能滑动");
        return;
    }
    TableViewController *tableVC = (TableViewController *)topVC;
    if(self.slideVC.somethingEditing || self.slideVC.tableView.isEditing || tableVC.somethingEditing || tableVC.tableView.isEditing)
    {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.scrollEnabled = YES;
        NSLog(@"好友列表编辑中");
    }
    else NSLog(@"未在编辑中");
}

- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers
{
    NSLog(@"pageVC即将转向 %@", pendingViewControllers.description);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.scrollView.bounces = NO;
}

@end
