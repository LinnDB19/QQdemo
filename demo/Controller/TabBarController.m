//
//  TabBarController.m
//  demo
//
//  Created by Abakus on 2023/7/4.
//

#import "TabBarController.h"
#import "TableViewController.h"
#import "MsgTableViewController.h"

@interface TabBarController ()

@property(strong, nonatomic) UINavigationController *messNVC;
@property(strong, nonatomic) UINavigationController *contNVC;
@property(strong, nonatomic) UINavigationController *newsNVC;

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //消息页
    MsgTableViewController *msgTVC = [MsgTableViewController new];
    _messNVC = [UINavigationController new];
    _messNVC.tabBarItem.title = @"消息";
    _messNVC.tabBarItem.image = [UIImage imageNamed:@"message"];
    [_messNVC pushViewController:msgTVC animated:YES];
    [self addChildViewController:_messNVC];
    
    //联系人页
    TableViewController *contTVC = [TableViewController new];
    _contNVC = [UINavigationController new];
    [_contNVC pushViewController:contTVC animated:YES]; // 加入navigation
    _contNVC.tabBarItem.title = @"联系人";
    _contNVC.tabBarItem.image = [UIImage imageNamed:@"contact"];
    [self addChildViewController:_contNVC]; //加入tab

    //动态页
    UIViewController *newsVC = [UIViewController new];
    newsVC.title = @"动态";
    newsVC.view.backgroundColor = [UIColor grayColor];
    _newsNVC = [UINavigationController new];
    _newsNVC.tabBarItem.title = @"动态";
    _newsNVC.tabBarItem.image = [UIImage imageNamed:@"star"];
    [_newsNVC pushViewController:newsVC animated:YES];
    [self addChildViewController:_newsNVC];
}

@end
