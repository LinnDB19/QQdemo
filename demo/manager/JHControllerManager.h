#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const ControllerManagerChangeToLaunchNotification;
extern NSString * const ControllerManagerChangeToHomeNotification;
@interface JHControllerManager : NSObject
+ (instancetype)ShareManager;
- (void)postNotification:(NSString *)name userInfo:(NSDictionary * )info;
@end

NS_ASSUME_NONNULL_END
