//
//  NewsTableViewController.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "NewsTableViewController.h"
#import "ANewView.h"
#import "Masonry.h"

@interface NewsTableViewController ()

@property(strong, nonatomic) NSMutableArray *news; // 存储的说说列表，每一个元素都是一条说说

@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
    //刷新功能
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.tintColor = [UIColor grayColor];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    self.refreshControl = refresh;
    [refresh addTarget:self action:@selector(StartRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏单元格分割线
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension; // header自动高度
    self.tableView.rowHeight = UITableViewAutomaticDimension; // cell自动高度
    self.tableView.estimatedSectionHeaderHeight = 100; // header预估高度
    self.tableView.estimatedRowHeight = 50; // cell预估高度
}

-(void)StartRefresh
{
    NSLog(@"刷新开始");
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3];
}
-(void)endRefresh
{
    NSLog(@"刷新结束");
    [self.refreshControl endRefreshing];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
// 一条说说内的评论数量
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ANewView *aNewView = [ANewView new];
    
    aNewView.topView.nickNameLabel.text = @"隐居于月球";
    aNewView.topView.dateLabel.text = @"13:30";
    aNewView.topView.iconImageView.image = [UIImage imageNamed:@"icon6"];
    aNewView.bodyView.textBodyView.contentLabel.text = @"我们过了江，进了车站。我买票，他忙着照看行李。行李太多了，得向脚夫行些小费才可过去。他便又忙着和他们讲价钱。我那时真是聪明过分，总觉他说话不大漂亮，非自己插嘴不可，但他终于讲定了价钱；就送我上车。他给我拣定了靠车门的一张椅子；我将他给我做的紫毛大衣铺好座位。他嘱我路上小心，夜里要警醒些，不要受凉。又嘱托茶房好好照应我。我心里暗笑他的迂；他们只认得钱，托他们只是白托！而且我这样大年纪的人，难道还不能料理自己么？我现在想想，我那时真是太聪明了。";
    [aNewView.bodyView setPicBodyImageCount:2]; // 要先调用此函数以设置内部的图片视窗布局
    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[0]).image = [UIImage imageNamed:@"icon1"];
    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[1]).image = [UIImage imageNamed:@"icon2"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[2]).image = [UIImage imageNamed:@"icon3"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[3]).image = [UIImage imageNamed:@"icon4"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[4]).image = [UIImage imageNamed:@"icon5"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[5]).image = [UIImage imageNamed:@"icon6"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[6]).image = [UIImage imageNamed:@"icon7"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[7]).image = [UIImage imageNamed:@"icon8"];
//    ((UIImageView *)aNewView.bodyView.picBodyView.imageViews[8]).image = [UIImage imageNamed:@"icon9"];
    return aNewView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 25;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //用来放评论输入栏
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 0, 500, 30)];
    textField.text = @"评论";
    return textField;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    return cell;
}

@end
