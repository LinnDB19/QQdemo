//
//  NewsTableViewController.m
//  demo
//
//  Created by LinDaobin on 2023/7/12.
//

#import "NewsTableViewController.h"
#import "PersonInfoViewController.h"
#import "ANewView.h"
#import "ANew.h"
#import "Masonry.h"
#import "CommentView.h"
#import "WMZDialog.h"
#import "ImageZoom.h"
#import "Macro.h"
#import "AFNetworking.h"
@interface NewsTableViewController ()

@property(strong, nonatomic) NSMutableArray<ANew *> *news; // 存储的说说列表，每一个元素都是一条说说
@property(strong, nonatomic) CommentView * commentView;
@property (assign, nonatomic) NSUInteger sectionTag;
// 用于维护上一次按钮点击时来自哪个section，当评论被发送时可以以此tag更新news[tag]的数据
@property bool is_commentBtn; //用于判断出现的输入框是用于评论还是用于转发，如果是评论，值为YES
@property(assign, nonatomic) CGFloat lastYoffset; // 维护上一次键盘弹出，tableView未修改的偏移量，以便键盘隐藏后恢复
@property(assign, nonatomic) BOOL didComOrTrans; //已经评论了或者转发，用于确定tableView偏置逻辑
@end

@implementation NewsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self initData];
    
    
    //刷新功能
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.tintColor = [UIColor grayColor];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    self.refreshControl = refresh;
    [refresh addTarget:self action:@selector(StartRefresh) forControlEvents:UIControlEventValueChanged];
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏单元格分割线
    self.tableView.sectionHeaderHeight = UITableViewAutomaticDimension; // header自动高度
    //self.tableView.rowHeight = UITableViewAutomaticDimension; // cell自动高度
    self.tableView.estimatedSectionHeaderHeight = 100; // header预估高度
    //self.tableView.estimatedRowHeight = UITableViewAutomaticDimension; // cell预估高度
    
    //增加监听，当键盘出现或改变时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
    
    //增加监听，当键退出时收出消息
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
}

- (void) initData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"someNews" ofType:@"plist"];
    NSMutableArray *news = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
   
    self.news = [NSMutableArray new];
    
    for(NSDictionary *newDic in news)
    {
        ANew *theNew = [[ANew alloc] init];
        [theNew setValuesForKeysWithDictionary:newDic];
        [self.news addObject:theNew];

    }
}


-(void)StartRefresh
{
    //NSLog(@"刷新开始");
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3];
    
    NSString *path = @"http://127.0.0.1:4523/m1/3553268-0-default/user/news";
    NSDictionary *params = nil;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    //发请求
    [manager GET:path parameters:params headers:nil progress:nil success:^(NSURLSessionDataTask *task, id _Nullable responseObject){
//        responseObject 就是服务器返回的data数据，已经是字典
        NSArray<NSDictionary *> *arr = responseObject[@"data"];
        NSMutableArray<ANew *> *someNews = [NSMutableArray new];
        for(int i = 0; i < arr.count; i ++)
        {
            ANew *theNew = [ANew new];
            [theNew setValuesForKeysWithDictionary:arr[i]];
            theNew.date = [[NSDateFormatter new]dateFromString:arr[i][@"date"]];
            [someNews addObject:theNew];
        }
        
        WEAKSELF(weakSelf)
        weakSelf.news = someNews;
        [weakSelf endRefresh];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //NSLog(@"请求失败:%@",error);
        WEAKSELF(weakSelf)
        [weakSelf endRefresh];
    }];
}
-(void)endRefresh
{
    //NSLog(@"刷新结束");
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

-(void)iconTap:(UITapGestureRecognizer *)tap
{
    NSUInteger tapSection = tap.view.tag;
    PersonInfoViewController *personInfoVC = [PersonInfoViewController new];
    personInfoVC.iconName = [self.news[tapSection].iconName copy];
    [self.navigationController pushViewController:personInfoVC animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.news.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
// 一条说说内的评论数量
    return self.news[section].commentList.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ANewView *aNewView = [ANewView new];
    [self setANewView:aNewView WithANew:self.news[section]];
    aNewView.tag = section; //方便后面确定是哪条说说新增评论
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(iconTap:)];
    [aNewView addGestureRecognizer:tap];
    return aNewView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UITableViewHeaderFooterView *footerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footerID"];
    if(!footerView) footerView = [UITableViewHeaderFooterView new];
    return footerView;
}

//将一条说说的数据和视图对应起来
- (void) setANewView:(ANewView *)aNewView WithANew:(ANew *)aNew
{
    aNewView.topView.iconImageView.image = [UIImage imageNamed:aNew.iconName];
    aNewView.topView.nickNameLabel.text = aNew.nickName;
    aNewView.commentDelegate = self;  // 将评论按钮的按键实现放到Controller里
    aNewView.transDelegate = self;
    NSDateFormatter *dateForma = [NSDateFormatter new];
    [dateForma setDateFormat:@"HH:mm"];
    aNewView.topView.dateLabel.text = [NSString stringWithFormat:@"%@", [dateForma stringFromDate:aNew.date]];
    
    aNewView.bodyView.textBodyView.contentLabel.text = aNew.contentText;
    
    //设置说说图片
    [aNewView.bodyView setPicBodyImageCount:[aNew.photoNames count]];
    for(int i = 0; i < [aNew.photoNames count]; i ++)
    {
        UIImageView *imageView = aNewView.bodyView.picBodyView.imageViews[i];
        imageView.image = [UIImage imageNamed:aNew.photoNames[i]];
        //imageView.contentMode = UIViewContentModeScaleAspectFill;
    }
}

#pragma mark 评论cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int section = indexPath.section, row = indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = self.news[section].commentList[row];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}

- (void)cellDeleteAt:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section, row = indexPath.row;
    [self.news[section].commentList removeObjectAtIndex:row];
    [self.tableView reloadData];
}

- (void)cellCopyAt:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section, row = indexPath.row;
    
    [[UIPasteboard generalPasteboard] setString:self.news[section].commentList[row]];
    
    WMZDialogParam *param = WMZDialogParam.new;
    param.wType = DialogTypeAuto;
    param.wMessage = @"复制成功";
    param.wDisappelSecond = 0.8;
    Dialog().wStartParam(param);
}

- (void)cellReplyAt:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section, row = indexPath.row;
    self.commentView.textView.text = [NSString stringWithFormat: @"回复”%@“：", self.news[section].commentList[row]];
    [self didClickCommentBtnWithTag:section];
}

- (void)cellPlusOneAt:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section, row = indexPath.row;
    [self.news[section].commentList addObject:[self.news[section].commentList[row] copy]];
    [self.tableView reloadData];
}


#pragma mark UITableView delegate

- (UIContextMenuConfiguration *)tableView:(UITableView *)tableView contextMenuConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath point:(CGPoint)point
{
    UIContextMenuConfiguration *config = [UIContextMenuConfiguration configurationWithIdentifier:nil previewProvider:nil
        actionProvider:^UIMenu* _Nullable(NSArray<UIMenuElement*>* _Nonnull suggestedActions){
        NSMutableArray *actions = [NSMutableArray new];
        [actions addObject:[UIAction actionWithTitle:@"删除" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action){
            WEAKSELF(weakSelf)
            [weakSelf cellDeleteAt:indexPath];
        }]];
        [actions addObject:[UIAction actionWithTitle:@"复制" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action){
            WEAKSELF(weakSelf)
            [weakSelf cellCopyAt:indexPath];
        }]];
        [actions addObject:[UIAction actionWithTitle:@"回复" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action){
            WEAKSELF(weakSelf)
            [weakSelf cellReplyAt:indexPath];
        }]];
        [actions addObject:[UIAction actionWithTitle:@"+1" image:nil identifier:nil handler:^(__kindof UIAction* _Nonnull action){
            WEAKSELF(weakSelf)
            [weakSelf cellPlusOneAt:indexPath];
        }]];
        UIMenu *menu = [UIMenu menuWithTitle:@"" children:actions];
        return menu;
    }];
    
    return config;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section = indexPath.section, row = indexPath.row;
    NSString *text = self.news[section].commentList[row];
    CGSize labelSize = [text sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0] constrainedToSize:CGSizeMake(self.tableView.frame.size.width / 3 * 2, 1000) lineBreakMode:NSLineBreakByWordWrapping];
    //CGSize textSize = [text sizeWithAttributes:@{ NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue-Light" size:16.0]}];
    return labelSize.height + 10;
}

#pragma mark 底部的按钮代理
-(void)didClickCommentBtnWithTag:(NSUInteger)tag
{
    //NSLog(@"commentBtn was clicked in newsVC from %d", tag);
    self.sectionTag = tag;
    self.is_commentBtn = YES;
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self.commentView];
    [self.commentView.textView becomeFirstResponder];
}
-(void)didClickTransBtnWithTag:(int)tag
{
    //NSLog(@"transBtn was clicked in newsvC from %d", tag);
    self.sectionTag = tag;
    self.is_commentBtn = NO;
    //转发框和评论框目前作用一致，先用评论输入框代替
    [[[UIApplication sharedApplication] keyWindow] bringSubviewToFront:self.commentView];
    [self.commentView.textView becomeFirstResponder];
}

#pragma mark 键盘通知事件

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    self.tableView.userInteractionEnabled = NO;
    self.somethingEditing = YES;
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //int width = keyboardRect.size.width;
    int screenHeight = UIScreen.mainScreen.bounds.size.height;
    CGRect rect = self.commentView.frame;
    [self.commentView setFrame:CGRectMake(0, screenHeight - height - rect.size.height, rect.size.width, rect.size.height)];
    //计算tableView需要的偏移量
    self.lastYoffset = self.tableView.contentOffset.y;
    CGRect footerFrameInTV = [self.tableView rectForFooterInSection:self.sectionTag];
    CGRect footerFrame = [self.tableView convertRect:footerFrameInTV toView:nil]; // 转换出来的坐标相当于屏幕坐标
    CGFloat yOffset = footerFrame.origin.y - rect.origin.y;
    //NSLog(@"yoffset = %lf", yOffset);
    if(yOffset > 0)
        [self.tableView setContentOffset:CGPointMake(0, self.lastYoffset + yOffset) animated:YES];
}

//当键退出时调用
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [[[UIApplication sharedApplication] keyWindow] sendSubviewToBack:self.commentView];
    [self.commentView.textView resignFirstResponder];
    self.somethingEditing = NO;
    self.tableView.userInteractionEnabled = YES;
    //如果是评论恢复偏移量，转发移到顶部
    if(self.didComOrTrans && !self.is_commentBtn) //只有转发成功了才偏置到最顶部
        [self scrollToTopWithAnimation:YES];
    //[self.tableView setContentOffset:CGPointMake(0, self.lastYoffset) animated:YES];
    
}

#pragma mark 延迟初始化
-(CommentView *)commentView
{
    if(_commentView == nil)
    {
        _commentView = [CommentView new];
        [[[UIApplication sharedApplication] keyWindow] addSubview:_commentView];
        [[[UIApplication sharedApplication] keyWindow] sendSubviewToBack:_commentView];
        [_commentView.commitBtn addTarget:self action:@selector(commentSend) forControlEvents:UIControlEventTouchUpInside];
        //发送评论的按钮事件
    }
    return _commentView;
}

-(void)commentSend
{
    NSString *str = self.commentView.textView.text;
    if([str isEqualToString:@""])
    {
        WMZDialogParam *param = WMZDialogParam.new;
        param.wType = DialogTypeAuto;
        param.wMessage = @"内容不能为空";
        param.wDisappelSecond = 0.8;
        Dialog().wStartParam(param);
        return;
    }
    self.didComOrTrans = YES;
    [self.commentView.textView setText:@""];
    if(self.is_commentBtn)
    {
        
        NSLog(@"%@", str);
        
        if(self.news[self.sectionTag].commentList == nil) // 仅当有评论时才分配评论列表内存
            self.news[self.sectionTag].commentList = [NSMutableArray new];
        
        [self.news[self.sectionTag].commentList addObject:str];
    }
    else
    {
        ANew *transNew = [ANew new];
        transNew.nickName = @"tour1st";
        transNew.iconName = @"paidaxing";
        transNew.date = [NSDate now];
        NSString *theStr = self.news[self.sectionTag].contentText;
        transNew.contentText = [NSString stringWithFormat:@"转发理由：%@\n%@", str, theStr];
        transNew.photoNames = [self.news[self.sectionTag].photoNames mutableCopy];
        transNew.commentList = [NSMutableArray new]; // 转发后评论不应该跟随新说说
        
        [self.news insertObject:transNew atIndex:0]; // 转发的说说应该是最新的
        
        WMZDialogParam *param = WMZDialogParam.new;
        param.wType = DialogTypeAuto;
        param.wMessage = @"转发成功";
        param.wDisappelSecond = 0.8;
        Dialog().wStartParam(param);
    }
    
    [self.tableView reloadData];
    [self.commentView.textView resignFirstResponder];
}

-(void)scrollToTopWithAnimation:(BOOL)animate
{
    //CGRect rect = [self.tableView rectForHeaderInSection:0];
    //    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:animate];
    //[self.tableView setContentOffset:CGPointMake(0, 0) animated:animate];
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //NSLog(@"offset x = %lf, y = %lf", self.tableView.contentOffset.x, self.tableView.contentOffset.y);
    self.somethingEditing = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //NSLog(@"offset x = %lf, y = %lf", self.tableView.contentOffset.x, self.tableView.contentOffset.y);
    self.somethingEditing = NO;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"keyboardWillShow:" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"keyboardWillHide:" object:nil];
}

@end
