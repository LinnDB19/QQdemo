//
//  Group.m
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import "Group.h"

@interface Group()

@property(strong, nonatomic) NSMutableArray *persons;  // 类型为Person

@end

@implementation Group

-(instancetype)init
{
    self = [super init];
    if(self)
    {
        _onlineCount = 0;  //初始值
        _persons = [NSMutableArray new];
    }
    return  self;
}

- (int)count
{
    return (int)self.persons.count;
}

- (void)addPerson:(Person *)person
{
    if(person.isOnline) _onlineCount ++;
    
    [_persons addObject:person];
}

- (void)insertPerson:(Person *)person AtIndex:(int)index
{
    if(person.isOnline) _onlineCount ++;
    [_persons insertObject:person atIndex:index];
}

- (void)removePersonAtIndex:(int)index
{
    if(index < 0 || index >= self.count) return;
    
    if([_persons[index] isOnline]) _onlineCount --;
    
    [_persons removeObjectAtIndex:index];
}

- (void)movePersonFromIndex:(int)FromIndex toIndex:(int)toIndex
{
    if(FromIndex == toIndex) return;
    
    Person * person = _persons[FromIndex];

    [_persons removeObjectAtIndex:FromIndex];
    [_persons insertObject:person atIndex:toIndex];
}

- (const Person *)PersonAtIndex:(int)index
{
    return _persons[index];
}

@end
