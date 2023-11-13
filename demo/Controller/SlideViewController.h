//
//  SlideTableViewController.h
//  demo
//
//  Created by LinDaobin on 2023/10/29.
//

#ifndef SlideTableViewController_h
#define SlideTableViewController_h
#import <UIKit/UIKit.h>

@interface SlideViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(assign, nonatomic) BOOL somethingEditing;
@property(strong, nonatomic) UITableView *tableView;
@end

#endif /* SlideTableViewController_h */
