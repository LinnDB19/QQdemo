//
//  TabBarController.m
//  demo
//
//  Created by Abakus on 2023/7/4.
//

#import "TabBarController.h"
#import "SlideViewController.h"

@interface TabBarController ()

@property(strong, nonatomic) UINavigationController *messNVC;
@property(strong, nonatomic) UINavigationController *contNVC;
@property(strong, nonatomic) UINavigationController *newsNVC;
@property(strong, nonatomic) UISwipeGestureRecognizer *rightSwipe;
@property(strong, nonatomic) SlideViewController *slideVC;
@property(assign, nonatomic) CGFloat screenWidth, screenHeight;
@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.screenWidth = self.view.bounds.size.width;
    self.screenHeight = self.view.bounds.size.height;
    //消息页
    self.msgTVC = [MsgTableViewController new];
    _messNVC = [UINavigationController new];
    _messNVC.tabBarItem.title = @"消息";
    _messNVC.tabBarItem.image = [UIImage imageNamed:@"message"];
    [_messNVC pushViewController:self.msgTVC animated:YES];
    [self addChildViewController:_messNVC];
    
    //联系人页
    self.contTVC = [TableViewController new];
    _contNVC = [UINavigationController new];
    [_contNVC pushViewController:self.contTVC animated:YES]; // 加入navigation
    _contNVC.tabBarItem.title = @"联系人";
    _contNVC.tabBarItem.image = [UIImage imageNamed:@"contact"];
    [self addChildViewController:_contNVC]; //加入tab

    //动态页
    self.newsVC = [[NewsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    self.newsVC.title = @"动态";
    //newsVC.view.backgroundColor = [UIColor grayColor];
    _newsNVC = [UINavigationController new];
    _newsNVC.tabBarItem.title = @"动态";
    _newsNVC.tabBarItem.image = [UIImage imageNamed:@"star"];
    [_newsNVC pushViewController:self.newsVC animated:YES];
    [self addChildViewController:_newsNVC];
    
//    self.slideVC = [SlideViewController new];
//    
//    self.rightSwipe = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleRightPan:)];
//    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
//    [self.view addGestureRecognizer:self.rightSwipe];
}

-(void)handleRightPan:(UISwipeGestureRecognizer *)recognizer;
{
    NSLog(@"检测到左滑");
    UINavigationController *nvc = [self selectedViewController];
    [nvc pushViewController:self.slideVC animated:YES];
    
}

@end
