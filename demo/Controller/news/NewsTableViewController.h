//
//  NewsTableViewController.h
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

// 动态页面的VC

#import <UIKit/UIKit.h>
#import "Delegate.h"
#import "NormalTableVC.h"

@interface NewsTableViewController : UITableViewController<CommentDelegate, TransDelegate>
@property(assign) BOOL somethingEditing; //用于外部判断此时所处的上层scrollView是否应该滑动
@end

