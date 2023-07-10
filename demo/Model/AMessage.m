//
//  AMessage.m
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import "AMessage.h"

@implementation AMessage

-(instancetype)initWithPerson:(Person *)person lastMsg:(NSString *)msg lastDate:(NSDate*)date
{
    self = [super init];
    if(self)
    {
        self.person = person;
        self.lastMsg = msg;
        self.lastDate = date;
    }
    
    return self;
}

@end
