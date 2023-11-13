//
//  JHUserDefaultStatus.h
//  demo
//
//  Created by LinDaobin on 2023/11/6.
//

#ifndef JHUserDefaultStatus_h
#define JHUserDefaultStatus_h

#import <Foundation/Foundation.h>

@interface JHUserDefaultStatus : NSObject
+ (JHUserDefaultStatus *)sharedManager;
//是否登录
+ (BOOL)isLogin;
//保存用户信息
- (void)saveLoginInfo;
//删除用户信息
- (void)clearUserInfo;
@end

#endif /* JHUserDefaultStatus_h */
