//
//  SearchController.m
//  demo
//
//  Created by LinDaobin on 2023/7/7.
//

#import "SearchController.h"

@interface SearchController ()

@end

@implementation SearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = (id)self;
    self.searchResultsUpdater = (id)self;
    self.searchBar.delegate = (id)self;
    
    self.navigationItem.hidesSearchBarWhenScrolling = NO;
    self.navigationItem.leftBarButtonItem = self.searchBar;
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSLog(@"11");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
