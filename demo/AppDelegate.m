//
//  AppDelegate.m
//  demo
//
//  Created by Abakus on 2023/6/25.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "TableViewController.h"
#import "TabBarController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "JHControllerManager.h"
#import "JHUserDefaultStatus.h"

@interface AppDelegate()
@property(strong, nonatomic) UIScrollView *scrollView;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
//    TabBarController *tabBarC = [[TabBarController alloc] init];
//    ViewController *vc = [ViewController new];
//    //MainPageVC *mainPageVC = [MainPageVC new];
//
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    
    if([JHUserDefaultStatus isLogin])
    {
        [[JHControllerManager ShareManager]postNotification:ControllerManagerChangeToHomeNotification userInfo:nil];
    }
    else
    {
        [[JHControllerManager ShareManager]postNotification:ControllerManagerChangeToLaunchNotification userInfo:nil];
    }
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = true;

    return YES;
}


@end
