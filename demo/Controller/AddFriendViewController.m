//
//  AddFriendViewController.m
//  demo
//
//  Created by LinDaobin on 2023/11/5.
//

#import <Foundation/Foundation.h>
#import "AddFriendViewController.h"
#import "masonry.h"

@interface AddFriendViewController()
@property(strong, nonatomic) UITextField *textFiled;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) NSArray *dataList;
@end

@implementation AddFriendViewController

-(void)viewDidLoad
{
    self.edgesForExtendedLayout = UIRectEdgeNone; // self.view.frame不考虑状态栏区域
    self.self.navigationController.navigationBar.translucent = NO; // 不透明
    //self.view.frame = UIScreen.mainScreen.bounds;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initData];
    [self.view addSubview:self.textFiled];
    [self.view addSubview:self.tableView];

    [self.textFiled mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.left.equalTo(self.view);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.textFiled.mas_bottom).offset(20);
        make.left.width.bottom.equalTo(self.view);
    }];
}

-(void)initData
{
    _dataList = @[@"添加手机联系人", @"扫一扫添加好友", @"面对面添加好友", @"按条件查找陌生人", @"扩列匹配",
                  @"面对面发起群聊", @"查看附近的人"];
}

#pragma mark lazyInit

-(UITableView *)tableView
{
    if(!_tableView)
    {
        _tableView = [UITableView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UITextField *)textFiled
{
    if(!_textFiled)
    {
        _textFiled = [UITextField new];
        _textFiled.placeholder = @"  输入QQ号或者QQ群号";
    }
    return _textFiled;
}

#pragma mark tableView dataSoure

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell) cell = [[UITableViewCell alloc]
                       initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    cell.textLabel.text = self.dataList[indexPath.row];
    
    return cell;
}

#pragma mark tableView delegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (void)dealloc
{
    self.edgesForExtendedLayout = UIRectEdgeAll; // 销毁时恢复默认，避免对其它的VC造成影响
}

@end
