//
//  Person.m
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import "Person.h"

@implementation Person

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        self.photoName = @"unknown";
        self.nickName = @"unknown";
        self.info = @"unknown";
        self.online = NO;
    }
    
    return self;
}

- (instancetype)initWithPotoName:(NSString *)photoName nickName:(NSString *)nickName Info:(NSString *)info Online:(BOOL)online
{
    self = [super init];
    if(self)
    {
        self.photoName = photoName;
        self.nickName = nickName;
        self.info = info;
        self.online = online;
    }
    return self;
}

@end
