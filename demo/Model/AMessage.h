//
//  AMessage.h
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import <Foundation/Foundation.h>
#import "Person.h"

@interface AMessage : NSObject

@property (strong, nonatomic) Person *person; //消息发起人
@property (strong, nonatomic) NSDate *lastDate; //最后一条消息时间
@property (strong, nonatomic) NSString *lastMsg; //最后一条消息

-(instancetype)initWithPerson:(Person *)person lastMsg:(NSString *)msg lastDate:(NSDate*)date;
@end
