//
//  SettingViewController.h
//  demo
//
//  Created by LinDaobin on 2023/11/7.
//

#ifndef SettingViewController_h
#define SettingViewController_h
#import <UIKit/UIKit.h>

@interface SettingViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property(assign, nonatomic) BOOL somethingEditing;
@property(strong, nonatomic) UITableView *tableView;
@end

#endif /* SettingViewController_h */
