//
//  CLSearchViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/2/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLSearchViewController.h"
#import "CLHomeTableViewController.h"
#import "CLSearchPresenter.h"
#import "UIColor+CustomColors.h"
#import "CLQuery.h"

@interface CLSearchViewController() {
    @private
    CLSearchPresenter *_searchPresenter;
    NSMutableArray *_queryResults;
    NSInteger _currentScope;
}
    
@end

@implementation CLSearchViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSearch];
    [_activityIndicator setHidden:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupSearchPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_searchPresenter)
        [_searchPresenter unregisterOnBus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - setupSearchPresenter

- (void)setupSearchPresenter {
    _searchPresenter = [[CLSearchPresenter alloc] initWithInteractor:self];
    [_searchPresenter registerOnBus];
}

# pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // TODO - add data
    return [_queryResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    
    // Get the query
    CLQuery *query = [_queryResults objectAtIndex:[indexPath row]];
    
    // Set the image
    NSString *imagePath = [query imagePath];
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:nil]];
    
    // Set labels
    cell.mainLabel.text = ([query queryName]) ? [query queryName] : [query content];
    cell.subLabel.text = [query type];

    return cell;
}

# pragma setupSearch

- (void)setupSearch {
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search...";
    self.searchBar.showsScopeBar = YES;
    self.searchBar.scopeButtonTitles = [NSArray arrayWithObjects:@"All", @"People", @"Events", @"Groups", @"Posts", nil];
    _currentScope = 0;
}

# pragma mark - ISearchInteractor Methods

- (void)initWithQueryResults:(NSMutableArray *)results {
    [self hideActivityIndicator];
    _queryResults = results;
    [self.tableView reloadData];
}

# pragma mark - SearchBar Delegates

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSLog(@"%@", searchText);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = TRUE;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSString *query = searchBar.text;
    NSString *scope = [searchBar.scopeButtonTitles objectAtIndex:_currentScope];
    scope = ([scope isEqualToString:@"All"]) ? @"" : [scope lowercaseString];
    [_searchPresenter loadQuery:query scope:scope];
    [self showActivityIndicator];
    [self.view endEditing:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    //dismiss keyboard and reload table
    [self.searchBar resignFirstResponder];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    NSArray *titles = searchBar.scopeButtonTitles;
    NSString *title = [titles objectAtIndex:selectedScope];
    _currentScope = selectedScope;
    // Do any work here when user selects scope, i.e. change results without doing an API call
}

# pragma mark - showActivityIndicator

- (void)showActivityIndicator {
    [_activityIndicator setHidden:NO];
    [_activityIndicator setColor:[UIColor colorAccent]];
    [_activityIndicator startAnimating];
}

# pragma mark - hideActivityIndicator

- (void)hideActivityIndicator {
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidden:YES];
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
