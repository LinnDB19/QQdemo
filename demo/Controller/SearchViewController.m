//
//  SearchViewController.m
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UISearchControllerDelegate>

@property (strong, nonatomic) UISearchController *searchC;
@property (strong, nonatomic) UITableView *tableV;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.frame = CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.height);
    
    self.searchC = [UISearchController new];
    self.searchC.delegate = (id)self;
    self.searchC.searchBar.delegate = (id)self;
    self.searchC.searchResultsUpdater = (id)self;
    self.searchC.searchBar.frame = CGRectMake(0, 100, UIScreen.mainScreen.bounds.size.width, 50);
    [self.view addSubview:self.searchC.searchBar];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSLog(@"111");
}


@end
