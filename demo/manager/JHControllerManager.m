//
//  JHControllerManager.m
//  demo
//
//  Created by LinDaobin on 2023/11/6.
//
#import "JHControllerManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ViewController.h"

NSString * const ControllerManagerChangeToLaunchNotification = @"com.i-shan.mobile.change.toLaunch";
NSString * const ControllerManagerChangeToHomeNotification = @"com.i-shan.mobile.change.toHome";
@implementation JHControllerManager
+ (instancetype)ShareManager {
    static JHControllerManager *controllerManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controllerManager = [[JHControllerManager alloc] initManager];
    });
    return controllerManager;
}

- (instancetype)initManager {
    self = [super init];
    if (self) {
        //     注册通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recevieNoticatLogin:) name:ControllerManagerChangeToLaunchNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotificatHome:) name:ControllerManagerChangeToHomeNotification object:nil];
    }
    return self;
}

- (void)postNotification:(NSString *)name userInfo:(NSDictionary * )info {
    //  发布通知
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:nil userInfo:info];
}

//如果为登录状态，则keywindow为你的主控制器

- (void)receiveNotificatHome:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:ControllerManagerChangeToHomeNotification]) {
        ViewController * vc = [ViewController new];
        [UIApplication sharedApplication].keyWindow.rootViewController = vc;
    }
}

//如果不为登录状态则，则到登录界面，keywindow为登录界面，或者你需要让他去的界面

-(void)recevieNoticatLogin:(NSNotification *)notification
{
    if([[notification name] isEqualToString:ControllerManagerChangeToLaunchNotification]) {
        LoginViewController * loginVC = [LoginViewController new];
        [UIApplication sharedApplication].keyWindow.rootViewController = loginVC;
    }
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
