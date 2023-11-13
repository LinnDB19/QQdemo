#import "CusViewController.h"
#import "ChatBaseRight.h"
#import "ChatBaseLeft.h"
#import "KUILabel.h"
#import <Masonry.h>
#import "CusLeftCell.h"
#import "CusRightCell.h"

#define k_width self.view.bounds.size.width
#define k_height self.view.bounds.size.height
#define knavbar_height (kstatusBarHeight + 44)
#define kstatusBarHeight [UIApplication sharedApplication].statusBarFrame.size.height
@interface CusViewController ()<UITableViewDelegate, UITableViewDataSource>
@property(strong, nonatomic) UITableView *listtableView;
@property(strong, nonatomic) UITextField *inputTextField;
@property(strong, nonatomic) UIButton *sendBtn;

@end

@implementation CusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = self.friendName;
    //默认的fake数据
    if(_contentArray == nil)
    {
        _contentArray = [NSMutableArray arrayWithArray:@[@"最近在忙什么呢？", @"在忙着做课设，你做了吗？", @"还没", @"感觉不是那么简单…………", @"确实是这样，还要弄什么神经网络。", @"那咋办，不会啊", @"github上查查？", @"我找找", @"你识别率多少", @"91%吧", @"啊？卧槽我怎么才80%", @"图片预处理了吗", @"处理了呀。。。"]];
    }
    if(_isSender == nil)
    {
        _isSender = [NSMutableArray new];
        for(int i = 0; i < self.contentArray.count; i ++)
            [self.isSender addObject:[NSNumber numberWithBool:i % 2 ? YES : NO]];
    }
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:1 green:1 blue:1 alpha:0.7],NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:17]}];
    //self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.view.backgroundColor = [UIColor grayColor];
    
    UIImageView *imgView = [UIImageView new];
    imgView.clipsToBounds = YES;
    imgView.image = [UIImage imageNamed:@"background.jpeg"];
    imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.mas_equalTo(0);
    }];


//    UIImageView *inputImgView = [UIImageView new];
//    inputImgView.image = [UIImage imageNamed:@"input.jpeg"];
//    [imgView addSubview:inputImgView];
//    [inputImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.bottom.right.mas_equalTo(0);
//        make.height.mas_equalTo(184 / (1320 / k_width));
//    }];
    
    
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(0);
        make.height.mas_equalTo(184 / (1320 / k_width));
    }];
    
    
    self.inputTextField = [UITextField new];
    [bottomView addSubview:self.inputTextField];
    self.inputTextField.layer.cornerRadius = 10; // 圆角
    self.inputTextField.backgroundColor = [UIColor whiteColor];
    self.inputTextField.placeholder = @"输入内容";
    self.inputTextField.delegate = self;
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(-70);
        make.top.mas_equalTo(0);
        //make.height.mas_equalTo(184 / (1320 / k_width));
    }];
    
    self.sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [bottomView addSubview:self.sendBtn];
    self.sendBtn.layer.cornerRadius = 5;
    self.sendBtn.enabled = NO;
    [self.sendBtn setAlpha:0.3];
    [self.sendBtn setBackgroundColor:[UIColor whiteColor]];
    [self.sendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    
    [self.sendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTextField.mas_right).offset(5);
        make.bottom.mas_equalTo(self.inputTextField).offset(-5);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.inputTextField).offset(5);
        //make.height.mas_equalTo(184 / (1320 / k_width));
    }];
    [self.sendBtn addTarget:self action:@selector(sendBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.listtableView = [[UITableView alloc] initWithFrame:CGRectMake(0, knavbar_height, k_width, k_height - knavbar_height - 184 / (1320 / k_width)) style:UITableViewStylePlain];
    self.listtableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.listtableView.backgroundColor = [UIColor clearColor];
    self.listtableView.estimatedRowHeight = 100;
    self.listtableView.showsVerticalScrollIndicator = YES;
    self.listtableView.delegate = self;
    self.listtableView.dataSource = self;
    [self.view addSubview:self.listtableView];
    [self.listtableView reloadData];
    
    [self scrollViewToBottom:YES];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *text = self.contentArray[indexPath.row];
    if (![self.isSender[indexPath.row] boolValue]) {
        CusLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:@"leftCell"];
        if (!cell) {
            if(self.friendImgName == nil)
                cell = [[CusLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"leftCell"];
            else
                cell = [[CusLeftCell alloc] initWithStyle:UITableViewCellStyleDefault
                                          reuseIdentifier:@"leftCell"
                                              WithImgName:self.friendImgName];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refreshCellWithText:text];
        return cell;
    }
    else
    {
        CusRightCell *cell = [tableView dequeueReusableCellWithIdentifier:@"rightCell"];
        if (!cell) {
            cell = [[CusRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"rightCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell refreshCellWithText:text];
        return cell;
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendBtnClicked
{
    NSString *str = self.inputTextField.text;
    self.inputTextField.text = @"";
    [self.inputTextField endEditing:NO];
    NSLog(@"发送消息: %@", str);
    [self.isSender addObject:[NSNumber numberWithBool:YES]];
    [self.contentArray addObject:str];
    self.sendBtn.enabled = NO;
    [self.sendBtn setAlpha:0.3];
    [self.listtableView reloadData];
    [self scrollViewToBottom:YES];
}

- (void)scrollViewToBottom:(BOOL)animated
{
    NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:self.contentArray.count - 1 inSection:0];
    [self.listtableView scrollToRowAtIndexPath:lastIndex atScrollPosition:UITableViewScrollPositionBottom animated:animated];
}

#pragma mark textField Delegate
- (void)textFieldDidChangeSelection:(UITextField *)textField
{
    NSLog(@"%@", textField.text);
    if([textField.text isEqual:@""] && self.sendBtn.enabled)
    {
        self.sendBtn.enabled = NO;
        [self.sendBtn setAlpha:0.3];
    }
    else if(![textField.text isEqual:@""] && !self.sendBtn.enabled)
    {
        self.sendBtn.enabled = YES;
        [self.sendBtn setAlpha:1];
    }
}

//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    NSLog(@"当前tableView最大偏置y = %lf, size.offsety = %lf, size.tableView.h = %lf, diff = %lf", self.listtableView.contentOffset.y, self.listtableView.contentSize.height, self.listtableView.frame.size.height, self.listtableView.contentSize.height - self.listtableView.frame.size.height);
//}

@end
