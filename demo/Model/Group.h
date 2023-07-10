//
//  Group.h
//  demo
//
//  Created by Abakus on 2023/6/30.
//

#import <Foundation/Foundation.h>
#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Group : NSObject


@property(strong, nonatomic) NSString *nickName;
@property(strong, nonatomic) NSString *photoName;
@property(nonatomic, readonly) int onlineCount;
@property(nonatomic, readonly) int count;

- (void)addPerson:(Person *)person;
- (void)removePersonAtIndex:(int)index;
- (void)movePersonFromIndex:(int)FromIndex toIndex:(int)toIndex;
- (void)insertPerson:(Person *)person AtIndex:(int)index;
- (const Person *)PersonAtIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
