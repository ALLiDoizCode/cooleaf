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
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SearchBar Delegates

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
