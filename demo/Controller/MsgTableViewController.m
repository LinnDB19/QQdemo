//
//  MsgTableViewController.m
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import "MsgTableViewController.h"
#include "MessageCell.h"
#include "Person.h"
#include "AMessage.h"

@interface MsgTableViewController () <UISearchResultsUpdating, UISearchControllerDelegate>

@property(strong, nonatomic) NSArray *allMsgs;
@property(strong, nonatomic) NSMutableArray *msgs;  //存放AMessage类型

@property(strong, nonatomic) UISearchController *searchC;
@property(strong, nonatomic) NSIndexPath *indexPath;
@property(strong, nonatomic) UITableViewCell *moveCell;
@property(strong, nonatomic) UIView *snapView;

typedef enum{
    SnapshotMeetsEdgeTop = 1,
    SnapshotMeetsEdgetBottom,
}SnapShotMeetEdge;

//自动滚动的方向
@property(nonatomic, assign) SnapShotMeetEdge autoScrollDirection;
@property(nonatomic, strong) CADisplayLink *autoScrollTimer;

@end

static const double SECTION_HEIGHT = 40, CELL_HEIGHT = 50;
@implementation MsgTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initMsgData];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //刷新功能
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.tintColor = [UIColor grayColor];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    self.refreshControl = refresh;
    [refresh addTarget:self action:@selector(startRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏分割线
    //添加长按手势
    [self.tableView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    
    //顶部左端头像
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"paidaxing"]];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    
    //顶部右端按钮
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" menu:nil];
    rightItem.image = [UIImage imageNamed:@"addFriend"];
    [rightItem setTintColor:[UIColor blackColor]];
    UIAction *buildGroup = [UIAction actionWithTitle:@"创建群聊"
                                               image:nil
                                          identifier:nil
                                             handler:^(UIAction *){NSLog(@"创建群聊");}];
    UIAction *addFriendGroup = [UIAction actionWithTitle:@"加好友/群"
                                                   image:nil
                                              identifier:nil
                                                 handler:^(UIAction *){NSLog(@"加好友/群");}];
    UIAction *scanning = [UIAction actionWithTitle:@"扫一扫"
                                             image:nil
                                        identifier:nil
                                           handler:^(UIAction *){NSLog(@"扫一扫");}];
    NSArray *actions = @[buildGroup, addFriendGroup, scanning];
    UIMenu *menu = [UIMenu menuWithChildren:actions];
    menu.preferredElementSize = UIMenuElementSizeLarge;
    rightItem.menu = menu;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    //header里的搜索栏
    self.searchC = [UISearchController new];
    self.tableView.tableHeaderView = self.searchC.searchBar;
    self.searchC.obscuresBackgroundDuringPresentation = NO;
    [self.searchC.searchBar sizeToFit];
    self.searchC.delegate = (id)self;
    self.searchC.searchBar.delegate = (id)self;
    self.searchC.searchResultsUpdater = (id)self;
    self.searchC.searchBar.keyboardType = UIKeyboardTypeDefault;
    //self.searchC.view.backgroundColor = [UIColor brownColor];
    
}

-(void)initMsgData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSMutableArray *messages = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
   
    self.msgs = [NSMutableArray new];
    
    for(NSDictionary *msg in messages)
    {
        Person *person = [[Person alloc] initWithPotoName:[msg objectForKey:@"photoName"] nickName:[msg objectForKey:@"nickName"] Info:@"" Online:YES];
        AMessage *aMessage = [[AMessage alloc] initWithPerson:person lastMsg:[msg objectForKey:@"lastMsg"] lastDate:[msg objectForKey:@"LastDate"]];
        [self.msgs addObject:aMessage];
    }
    
    _allMsgs = [NSArray arrayWithArray:_msgs];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"更新消息搜索结果");
    
    NSString *searchStr = searchController.searchBar.text;
    [self.msgs removeAllObjects];
    if(!searchStr.length)
    {
        [self.msgs addObjectsFromArray: self.allMsgs];
    }
    else
    {
        for(AMessage *msg in self.allMsgs)
            if([msg.person.nickName containsString:searchStr])
                [self.msgs addObject:msg];
    }

    
    [self.tableView reloadData];
}

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索栏获得焦点");
    //后面需要添加，在搜索时禁用删除、拖拽、和刷新功能
    
    self.tabBarController.tabBar.hidden = YES;
}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"搜索栏失去焦点");
    //后面需要恢复，在搜索时已经禁用的删除、拖拽、和刷新功能
    self.tabBarController.tabBar.hidden = NO;
}


- (void) longPress:(UILongPressGestureRecognizer *)longPress
{
    switch(longPress.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            NSLog(@"UIGestureRecognizerStateBegan");
            [self.tableView reloadData];
            CGPoint point = [longPress locationOfTouch:0 inView:longPress.view];
            point.y -= 25; //加个偏置，避免点击的是某个单元格，实际获取的是这个单号格的下一个
            self.indexPath = [self.tableView indexPathForRowAtPoint:point];
            //NSLog(@"第一次赋值");
            if(self.indexPath)
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.moveCell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                    self.snapView = [self.moveCell snapshotViewAfterScreenUpdates:NO];
                    self.snapView.frame = self.moveCell.frame;
                    [self.tableView addSubview:self.snapView];  //显示要移动的cell的快照
                    self.moveCell.hidden = YES;
                    [UIView animateWithDuration:0.1 animations:^{
                        self.snapView.transform = CGAffineTransformScale(self.snapView.transform, 1.03, 1.05);
                        self.snapView.alpha = 0.8;
                    }];
                });
            }
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint point = [longPress locationOfTouch:0 inView:longPress.view];
            CGPoint center = self.snapView.center;
            center.y = point.y;
            self.snapView.center = center;
            if([self checkIfSnapshotMeetsEdge])
                [self startAutoScrollTimer];
            else
                [self stopAutoScrollTimer];
            
            NSIndexPath *exchangeIndex = [self.tableView indexPathForRowAtPoint:point];
            if(exchangeIndex && self.indexPath)
            {
                [self updateDataWithIndexPath:exchangeIndex];
                
                [self.tableView moveRowAtIndexPath:self.indexPath toIndexPath:exchangeIndex];
                self.indexPath = exchangeIndex;
                //NSLog(@"第二次赋值");
            }
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"UIGestureRecognizerStateEnded");
            dispatch_async(dispatch_get_main_queue(), ^{
                self.moveCell = [self.tableView cellForRowAtIndexPath:self.indexPath];
                [UIView animateWithDuration:0.2
                                 animations:^{
                    self.snapView.center = self.moveCell.center;
                    self.snapView.transform = CGAffineTransformIdentity;
                    self.snapView.alpha = 1.0;}
                                 completion:^(BOOL finished){
                    self.moveCell.hidden = NO;
                    [self.snapView removeFromSuperview];
                    [self stopAutoScrollTimer];}];
            });
            [self.tableView reloadData];
        }
            break;
        default:
            break;
    }
}

- (BOOL) checkIfSnapshotMeetsEdge
{
    CGFloat minY = CGRectGetMinY(self.snapView.frame);
    CGFloat maxY = CGRectGetMaxY(self.snapView.frame);
    if(minY < self.tableView.contentOffset.y)
    {
        self.autoScrollDirection = SnapshotMeetsEdgeTop;
        return YES;
    }
    if(maxY > self.tableView.bounds.size.height + self.tableView.contentOffset.y)
    {
        self.autoScrollDirection = SnapshotMeetsEdgetBottom;
        return YES;
    }
    
    return NO;
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

//增加定时器自动滑动
#pragma mark 定时器
- (void)startAutoScrollTimer
{
    if(self.autoScrollTimer == nil)
    {
        self.autoScrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(startAutoScroll)];
        [self.autoScrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}
- (void)stopAutoScrollTimer
{
    if(self.autoScrollTimer)
    {
        [self.autoScrollTimer invalidate];
        self.autoScrollTimer = nil;
    }
}

- (void)startAutoScroll
{
    CGFloat pixelSpeed = 4;
    if(self.autoScrollDirection == SnapshotMeetsEdgeTop)
    {
        if(self.tableView.contentOffset.y > 0)
        {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y - pixelSpeed)];
            self.snapView.center = CGPointMake(self.snapView.center.x, self.snapView.center.y - pixelSpeed);
        }
    }
    else
    {
        if(self.tableView.contentOffset.y + self.tableView.bounds.size.height < self.tableView.contentSize.height)
        {
            [self.tableView setContentOffset:CGPointMake(0, self.tableView.contentOffset.y + pixelSpeed)];
            self.snapView.center = CGPointMake(self.snapView.center.x, self.snapView.center.y + pixelSpeed);
        }
    }
    
    //交换cell
    NSIndexPath *exchangePath = [self.tableView indexPathForRowAtPoint:self.snapView.center];
    if(exchangePath) [self updateDataWithIndexPath:exchangePath];
    
}

#pragma mark - Table view data source

- (void) updateDataWithIndexPath:(NSIndexPath *)moveIndexPath
{
    int row1 = (int)self.indexPath.row, row2 = (int)moveIndexPath.row;
    
    AMessage *msg = self.msgs[row1];
    [self.msgs removeObject:msg];
    [self.msgs insertObject:msg atIndex:row2];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.msgs.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}


- (MessageCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell) cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];

    AMessage *msg = (AMessage *)self.msgs[indexPath.row];
    
    cell.imageView.image = [UIImage imageNamed:msg.person.photoName];
    cell.textLabel.text = msg.person.nickName;
    cell.detailTextLabel.text = msg.lastMsg;
    NSDateFormatter *dateForma = [NSDateFormatter new];
    [dateForma setDateFormat:@"HH:mm"];
    cell.lastDateLabel.text = [NSString stringWithFormat:@"%@",
                               [dateForma stringFromDate:msg.lastDate]];
    cell.lastDateLabel.textAlignment = NSTextAlignmentRight;
    //NSLog(@"%@", msg.lastDate);
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

-(void)startRefresh
{
    NSLog(@"刷新开始");
    [self performSelector:@selector(endRefresh) withObject:nil afterDelay:3];
}
-(void)endRefresh
{
    NSLog(@"刷新结束");
    [self.refreshControl endRefreshing];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.msgs removeObjectAtIndex:indexPath.row];
    [self.tableView
     deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
     withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}



@end
