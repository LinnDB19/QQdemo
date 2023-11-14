//
//  SlideTableViewController.m
//  demo
//
//  Created by LinDaobin on 2023/10/29.
//

#import <Foundation/Foundation.h>
#import "SlideViewController.h"
#import <Masonry.h>
#import "SlideCell.h"
#import "SCCustomButton.h"
#import "SettingViewController.h"
#import "PersonInfoViewController.h"

@interface SlideViewController()

@property(strong, nonatomic) NSArray<UIImage *> *imgList;
@property(strong, nonatomic) NSArray<NSString *> *strList;
@property(strong, nonatomic) UIView *topView;
@property(strong, nonatomic) UIView *bottomView;

@end

@implementation SlideViewController

-(void)viewDidLoad
{
    
    [self initListData];
    [self initUI];
}

-(void)initListData
{
    NSArray *imgName = @[@"liveStream", @"VIP", @"purse", @"dress", @"coupleZoom", @"free", @"collect", @"album", @"doc"];
    NSMutableArray *tmpArr = [NSMutableArray new];
    for(NSString *str in imgName)
    {
        [tmpArr addObject:[UIImage imageNamed:str]];
    }
    self.imgList = [NSArray arrayWithArray:tmpArr];
    self.strList = @[@"直播购物", @"点我6折开会员", @"我的钱包", @"装扮我的QQ", @"我的情侣空间",
                     @"免流量送VIP", @"我的收藏", @"我的相册", @"我的文件"];
}

-(void)initUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = UIScreen.mainScreen.bounds;
    self.topView = [UIView new];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 50, 50)];
    imgView.image = [UIImage imageNamed:@"paidaxing"];
    imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap:)];
    [imgView addGestureRecognizer:tap];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 70, 20)];
    label.text = @"tour1st";
    [self.topView addSubview:label];
    [self.topView addSubview:imgView];
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    //self.bottomView.backgroundColor = [UIColor blackColor];
    self.tableView = [UITableView new];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // 分割线
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    
    UIEdgeInsets edgeInsets = [[UIApplication sharedApplication] keyWindow].safeAreaInsets;
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.view);
        make.left.width.equalTo(self.view);
        make.height.mas_equalTo(70);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.width.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-edgeInsets.bottom);
        make.height.mas_equalTo(70);
    }];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.topView.mas_bottom).offset(20);
        make.bottom.equalTo(self.bottomView).offset(-20);
    }];
    
    CGRect btnFrame = CGRectMake(0, 0, 50, 50);
    SCCustomButton *settingBtn = [[SCCustomButton alloc] initWithFrame:btnFrame];
    [settingBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    settingBtn.imagePosition = SCCustomButtonImagePositionTop;
    [settingBtn setTitle:@"设置" forState:UIControlStateNormal];
    [settingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [settingBtn addTarget:self action:@selector(settingBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    SCCustomButton *masterBtn = [[SCCustomButton alloc] initWithFrame:btnFrame];
    [masterBtn setImage:[UIImage imageNamed:@"master"] forState:UIControlStateNormal];
    masterBtn.imagePosition = SCCustomButtonImagePositionTop;
    [masterBtn setTitle:@"达人" forState:UIControlStateNormal];
    [masterBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

    SCCustomButton *moonBtn = [[SCCustomButton alloc] initWithFrame:btnFrame];
    [moonBtn setImage:[UIImage imageNamed:@"moon"] forState:UIControlStateNormal];
    moonBtn.imagePosition = SCCustomButtonImagePositionTop;
    [moonBtn setTitle:@"夜间" forState:UIControlStateNormal];
    [moonBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.bottomView addSubview:settingBtn];
    [self.bottomView addSubview:masterBtn];
    [self.bottomView addSubview:moonBtn];
    
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(self.bottomView).offset(20);
        make.top.equalTo(self.bottomView).offset(15);
    }];
   
    [moonBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(settingBtn.mas_right).offset(20);
        make.top.equalTo(self.bottomView).offset(15);
    }];
    
    [masterBtn mas_makeConstraints:^(MASConstraintMaker *make){
        make.left.equalTo(moonBtn.mas_right).offset(20);
        make.top.equalTo(self.bottomView).offset(15);
    }];

}

-(void)iconTap:(UITapGestureRecognizer *)tap
{
    NSUInteger tapSection = tap.view.tag;
    PersonInfoViewController *personInfoVC = [PersonInfoViewController new];
    personInfoVC.iconName = @"paidaxing";
    [self.navigationController pushViewController:personInfoVC animated:YES];
}

#pragma mark tableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.strList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (SlideCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SlideCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell) cell = [[SlideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    NSUInteger index = indexPath.row;
    cell.imageView.image = self.imgList[index];
    cell.textLabel.text = self.strList[index];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark tableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma mark ScrollView Delegate

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.somethingEditing = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    self.somethingEditing = NO;
}

-(void)settingBtnClicked
{
    NSLog(@"设置按钮被点击");
    SettingViewController *settingVC = [SettingViewController new];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.self.navigationController.navigationBar.translucent = NO; // 不透明
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.self.navigationController.navigationBar.translucent = YES; // 透明
    self.edgesForExtendedLayout = UIRectEdgeAll;
}


@end
