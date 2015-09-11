//
//  CLSearchViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/2/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchViewController.h"
#import "CLHomeTableViewController.h"

@interface CLSearchViewController ()
    
@end

@implementation CLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO - add data
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    cell = [self configureSearchCell:cell];
    return cell;
}

# pragma setupSearch

- (void)setupSearch {
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search...";
}

# pragma mark - configureSearchCell

- (CLSearchCell *)configureSearchCell:(CLSearchCell *)searchCell {
    searchCell.countLabel.text = @"10";
    searchCell.cellImage.image = [UIImage imageNamed:@"TestImage"];
    return searchCell;
}

# pragma mark - SearchBar Delegates

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = TRUE;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //dismiss keyboard and reload table
    [self.searchBar resignFirstResponder];
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