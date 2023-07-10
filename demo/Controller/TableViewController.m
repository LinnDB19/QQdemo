//
//  TableViewController.m
//  demo
//
//  Created by Abakus on 2023/6/27.
//

#import "TableViewController.h"
#import "SearchViewController.h"
#import "PersonCell.h"
#import "SectionView.h"
#import "Group.h"
#import "Person.h"

@interface TableViewController ()<UISearchControllerDelegate>

@property(strong, nonatomic) NSMutableArray *groups; //每个元素是一个group
@property(strong, nonatomic) NSMutableArray *isopen; // 存布尔值，表示section是否打开
@property(nonatomic, strong) UIView *snapView;
@property(nonatomic, strong) NSIndexPath *indexPath;
@property(nonatomic, strong) UITableViewCell *moveCell;
@property(nonatomic, strong) UIButton *searchBtn;
@property(nonatomic, strong) UIButton *newsFriendBtn;
@property(nonatomic, strong) UIButton *groupNewsBtn;
@property(nonatomic, strong) UIView *headerV;
@property(strong, nonatomic) UISearchController *searchC;
typedef enum{
    SnapshotMeetsEdgeTop = 1,
    SnapshotMeetsEdgetBottom,
}SnapShotMeetEdge;

//自动滚动的方向
@property(nonatomic, assign) SnapShotMeetEdge autoScrollDirection;
@property(nonatomic, strong) CADisplayLink *autoScrollTimer;

@end

static const double SECTION_HEIGHT = 40, CELL_HEIGHT = 50;
@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGroupsData]; //先初始化模型数据
    //注册后使用的是默认类型的cell，无法显示detail文字
    //[self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    //刷新功能
    UIRefreshControl *refresh = [UIRefreshControl new];
    refresh.tintColor = [UIColor grayColor];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新"];
    self.refreshControl = refresh;
    [refresh addTarget:self action:@selector(StartRefresh) forControlEvents:UIControlEventValueChanged];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone; //隐藏分割线

    //添加长按手势
    [self.tableView addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)]];
    
    self.title = @"联系人";
    //顶部右端按钮
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(barRightItemClick)];
    rightItem.image = [UIImage imageNamed:@"addFriend"];
    [rightItem setTintColor:[UIColor blackColor]];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //顶部左端头像
    UIImageView *iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"paidaxing"]];
    iconView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:iconView];
    
    static const int GAP_Y = CELL_HEIGHT / 5, GAP_X = 10;
    //tableView顶部视图
    self.headerV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, GAP_Y * 2 + CELL_HEIGHT * 3)];
    self.tableView.tableHeaderView = self.headerV;
    //self.headerV.backgroundColor = [UIColor brownColor];
    

    //给tableView的head添加搜索按钮
//    self.searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(GAP_X, GAP_Y, UIScreen.mainScreen.bounds.size.width - GAP_X * 2, CELL_HEIGHT)];
//    self.searchBtn.layer.cornerRadius = 25;
//    self.searchBtn.layer.masksToBounds = YES; //没有这行无法显示圆角
//    self.searchBtn.backgroundColor = [UIColor grayColor];
//    [self.searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [self.searchBtn setTitle:@"搜索" forState:UIControlStateNormal];
//    [self.headerV addSubview:self.searchBtn];
    
    //给tableView的head添加新朋友按钮
    self.newsFriendBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, GAP_Y * 2 + CELL_HEIGHT, UIScreen.mainScreen.bounds.size.width, CELL_HEIGHT)];
    //self.newsFriendBtn.backgroundColor = [UIColor grayColor];
    [self.newsFriendBtn setTitle:@"  新朋友" forState:UIControlStateNormal];
    self.newsFriendBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.newsFriendBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headerV addSubview:self.newsFriendBtn];
    
    //给tableView的head添加群通知按钮
    self.groupNewsBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, GAP_Y * 2 + CELL_HEIGHT * 2, UIScreen.mainScreen.bounds.size.width, CELL_HEIGHT)];
    //self.groupNewsBtn.backgroundColor = [UIColor grayColor];
    [self.groupNewsBtn setTitle:@"  群通知" forState:UIControlStateNormal];
    self.groupNewsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.groupNewsBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.headerV addSubview:self.groupNewsBtn];
    
    //给tableView的head的三个按钮添加点击事件
    [self.searchBtn addTarget:self action:@selector(searchBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.newsFriendBtn addTarget:self action:@selector(newsFriendBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.groupNewsBtn addTarget:self action:@selector(groupNewsBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.searchC = [UISearchController new];
    self.searchC.delegate = (id)self;
    self.searchC.searchBar.delegate = (id)self;
    self.searchC.searchResultsUpdater = (id)self;
    self.searchC.obscuresBackgroundDuringPresentation = YES;
    self.searchC.searchBar.frame = CGRectMake(0, GAP_Y, UIScreen.mainScreen.bounds.size.width - GAP_X * 2, CELL_HEIGHT);
    [self.headerV addSubview:self.searchC.searchBar];
}

#pragma mark head三个按钮的点击事件
- (void)searchBtnClick
{
    SearchViewController *searchVC = [SearchViewController new];
    
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)newsFriendBtnClick
{
    
}

- (void)groupNewsBtnClick
{
    
}

#pragma mark 联系人页面顶部右侧按钮点击事件
- (void) barRightItemClick
{
    NSLog(@"联系人页面顶部栏右侧按钮点击事件触发");
    UIViewController *vc = [UIViewController new];
    
        vc.title = @"添加好友";
        vc.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
        vc.view.backgroundColor = [UIColor whiteColor];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
}

-(void)initGroupsData
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"friends" ofType:@"plist"];
    NSMutableArray *friends = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    self.groups = [[NSMutableArray alloc] init];
    self.isopen = [NSMutableArray new];
    
    static NSArray *infos = @[@"WIFI 在线", @"4G 在线", @"5G 在线"];
    for(NSDictionary *theDic in friends)
    {
        Group* PersonGroup = [[Group alloc] init];
        PersonGroup.nickName = [theDic objectForKey:@"nickName"];
        NSMutableArray *theGroup = [theDic objectForKey:@"group"];
        for(NSDictionary *dicPerson in theGroup)
        {
            Person *person = [[Person alloc] initWithPotoName:[dicPerson objectForKey:@"photoName"]
                                                     nickName:[dicPerson objectForKey:@"nickName"]
                                                         Info:infos[arc4random() % 3]
                                                       Online:(arc4random() % 2 ? NO : YES)];
            if(!person.isOnline) person.info = @"离线";
            [PersonGroup addPerson:person];
            
        }
        [self.groups addObject:PersonGroup];
        
        [self.isopen addObject:@NO];  //作为判断section是否打开
    }
    
    
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

#pragma mark 更新数据源
- (void) updateDataWithIndexPath:(NSIndexPath *)moveIndexPath
{
    if(self.indexPath == nil) return; // 某些情况self.indexPath会获取不到，导致它本身是nil，这时候无法交换数据
    
    int section1 = (int)self.indexPath.section, section2 = (int)moveIndexPath.section;
    int row1 = (int)self.indexPath.row, row2 = (int)moveIndexPath.row;
    if(section1 != section2)
    {
        Person *thePerson = (Person *)[((Group *)self.groups[section1]) PersonAtIndex:row1];
        [self.groups[section1] removePersonAtIndex:row1];
        [self.groups[section2] insertPerson:thePerson AtIndex:row2];
    }
    else if(row1 != row2)
    {
        NSLog(@"from indexRow %d to indexRow %d in section %d", row1, row2, section1);
        [self.groups[section1] movePersonFromIndex:row1 toIndex:row2];
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
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [_isopen[section] isEqual:@YES] ? [(Group *)self.groups[section] count] : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CELL_HEIGHT;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return SECTION_HEIGHT;
}

#pragma mark cell
- (PersonCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if(!cell) cell = [[PersonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellID"];
    
    Person *thePerson =(Person *)([(Group *)self.groups[indexPath.section] PersonAtIndex:(int)indexPath.row]);
    if(!thePerson.isOnline)
    {
        cell.textLabel.textColor = [UIColor grayColor]; // 不在线的设成灰名
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    
    cell.textLabel.text = thePerson.nickName;
    cell.imageView.image = [UIImage imageNamed:thePerson.photoName];
    cell.detailTextLabel.text = thePerson.info;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    SectionView *sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, SECTION_HEIGHT)];
    NSString *sectionImageName = @"sectionOpen";
    if([_isopen[section] isEqual:@NO])
        sectionImageName = @"sectionClose";
    UIImage *triangleImage = [UIImage imageNamed:sectionImageName];
    
    sectionView.stateImageView.image = triangleImage;
    Group *theGroup = ((Group *)self.groups[section]);
    sectionView.sectionName.text = theGroup.nickName;
    sectionView.onlineTotal.text = [NSString stringWithFormat:@"%d/%d", theGroup.onlineCount, theGroup.count];
    sectionView.tag = section;
    [sectionView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchSectionView:)]];
    return sectionView;
}

-(void)touchSectionView:(UITapGestureRecognizer *)tap
{
    NSInteger section = tap.view.tag;
    _isopen[section] = [_isopen[section] isEqual:@YES] ? @NO : @YES;
    //NSLog(@"section%d %@", section, _isopen[section]);
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{ return YES; }

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self.groups[indexPath.section] removePersonAtIndex:(int)indexPath.row];
    [self.tableView
     deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
     withRowAnimation:UITableViewRowAnimationTop];
    [self.tableView reloadData];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"1212");
}

@end
