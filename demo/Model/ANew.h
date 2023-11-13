//
//  ANew.h
//  demo
//
//  Created by LinDaobin on 2023/7/14.
//

#import <Foundation/Foundation.h>

@interface ANew : NSObject

@property(copy, nonatomic) NSString *iconName;
@property(copy, nonatomic) NSString *nickName;
@property(copy, nonatomic) NSDate *date;
@property(copy, nonatomic) NSString *contentText;
@property(strong, nonatomic) NSMutableArray *photoNames;
@property(strong, nonatomic) NSMutableArray<NSString *> *commentList;
@end

