//
//  TabBarController.h
//  demo
//
//  Created by Abakus on 2023/7/4.
//

#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "MsgTableViewController.h"
#import "NewsTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TabBarController : UITabBarController

@property(strong, nonatomic) MsgTableViewController *msgTVC;
@property(strong, nonatomic) TableViewController *contTVC;
@property(strong, nonatomic) NewsTableViewController *newsVC;

@end

NS_ASSUME_NONNULL_END
