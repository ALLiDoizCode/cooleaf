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
    
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"Search...";
    
    _data = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
              @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
              @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
              @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
              @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
        
    cell.mainLablel.text = [_data objectAtIndex:indexPath.row];
    cell.subLabel.text = [_data objectAtIndex:indexPath.row];
    cell.countLabel.text = @"10";
    
    cell.cellImage.image = [UIImage imageNamed:@"TestImage"];
   
    return cell;
}

#pragma mark - SearchBar Delegates

/*-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    return YES;
}*/

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
