//
//  Person.h
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property(strong, nonatomic) NSString *photoName;
@property(strong, nonatomic) NSString *nickName;
@property(strong, nonatomic) NSString *info;
@property(nonatomic, getter = isOnline) BOOL online;

- (instancetype)initWithPotoName:(NSString *)photoName nickName:(NSString *)nickName Info:(NSString *)info Online:(BOOL)online;

@end

NS_ASSUME_NONNULL_END
