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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[TabBarController alloc] init];
//    UISearchController *searchC = [UISearchController new];
//    searchC.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
//    searchC.view.backgroundColor = [UIColor whiteColor];
//    searchC.navigationItem.hidesSearchBarWhenScrolling = NO;
//    self.window.rootViewController = searchC;
//    [self.window makeKeyAndVisible];
     
    return YES;
}


@end
