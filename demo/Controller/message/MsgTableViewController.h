//
//  MsgTableViewController.h
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import <UIKit/UIKit.h>
#import "NormalTableVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface MsgTableViewController : NormalTableVC
@property(assign) BOOL somethingEditing; //用于外部判断此时所处的上层scrollView是否应该滑动
@end

NS_ASSUME_NONNULL_END
