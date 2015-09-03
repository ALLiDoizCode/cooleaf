//
//  CLSearchViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/2/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchViewController.h"
#import "UIColor+CustomColors.h"
#import "CLHomeTableViewController.h"

@interface CLSearchViewController () {
    
    UIColor *barColor;
}

@end

@implementation CLSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchBar.showsCancelButton = TRUE;
    self.searchBar.delegate = self;
    
    
    // Do any additional setup after loading the view.
    
    //[self toggleSearch];
   
    
    //Searchbar color
    barColor = [UIColor UIColorFromRGB:0x69C4BB];
    
}


-(void)viewWillAppear:(BOOL)animated {
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - toggleSearch

/*- (void)toggleSearch {
    
    // place search bar coordinates where the navbar is position - offset by statusbar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    //self.searchController.searchResultsDataSource = self;
    //self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    
    [self.view addSubview:self.searchBar];
    self.searchBar.barTintColor = barColor;
}*/

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    //dismiss keyboard and reload table
    [self.searchBar resignFirstResponder];
    
    NSLog(@"stop");
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
