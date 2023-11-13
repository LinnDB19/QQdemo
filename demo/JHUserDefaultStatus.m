//
//  JHUserDefaultStatus.m
//  demo
//
//  Created by LinDaobin on 2023/11/6.
//

#import <Foundation/Foundation.h>
#import "JHUserDefaultStatus.h"

@implementation JHUserDefaultStatus

+ (JHUserDefaultStatus *)sharedManager
{
    static JHUserDefaultStatus *userDefaultStatus = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userDefaultStatus = [[JHUserDefaultStatus alloc] init];
    });
    return userDefaultStatus;
}
//保存用户登录信息
- (void)saveLoginInfo
{
    //  self.Plan_count = 0;
    NSString *loginStr = @"Login";
    [[NSUserDefaults standardUserDefaults] setObject:loginStr forKey:@"Login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}
//删除用户信息
- (void)clearUserInfo
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"Login"];
}
//是否登录
+ (BOOL)isLogin
{
    NSString *loginStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"Login"];
    return loginStr == nil ? NO : YES;
}

@end
