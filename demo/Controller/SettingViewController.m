//
//  SettingViewController.m
//  demo
//
//  Created by LinDaobin on 2023/11/7.
//

#import <Foundation/Foundation.h>
#import "SettingViewController.h"
#import <Masonry.h>
#import "JHControllerManager.h"
#import "JHUserDefaultStatus.h"

@interface SettingViewController()
@property(strong, nonatomic) NSArray *listData;
@end

@implementation SettingViewController

-(void)viewDidLoad
{
    self.navigationController.navigationBar.translucent = NO; // 不透明
    self.hidesBottomBarWhenPushed = YES;
    [self initData];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

-(void)initData
{
    _listData = @[@"账号管理", @"手机号码", @"账号安全", @"消息通知", @"隐私", @"通用", @"辅助功能", @"退出登录"];
}

#pragma mark lazyInit
-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make){
            make.left.top.width.bottom.equalTo(self.view);
        }];
    }
    
    return _tableView;
}

#pragma mark tableView dataSoure
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if(indexPath.row == self.listData.count - 1)
    {
        cell.backgroundColor = [UIColor colorWithRed:52/255.0 green:171/255.0 blue:235/255.0 alpha:1];
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    else
    {
        cell.backgroundColor = [UIColor whiteColor];
        cell.textLabel.textColor = [UIColor blackColor];
    }
    cell.textLabel.text = self.listData[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row != self.listData.count - 1) return;
    [[JHControllerManager ShareManager] postNotification:ControllerManagerChangeToLaunchNotification userInfo:nil];
    [[JHUserDefaultStatus sharedManager] clearUserInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

@end
