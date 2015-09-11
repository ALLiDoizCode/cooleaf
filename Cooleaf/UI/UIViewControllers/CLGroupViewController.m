//
//  CLGroupViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupViewController.h"
#import "UIColor+CustomColors.h"
#import "CLGroupDetailViewController.h"
#import "CLInterestPresenter.h"

@interface CLGroupViewController () {
    @private
    CLInterestPresenter *_interestPresenter;
    NSArray *_interests;
    UIColor *_barColor;
}

@end

@implementation CLGroupViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearch];
    
//    images = @[@"heavenly.jpg",@"nature.jpg",@"Running.jpg",@"garden.jpg",@"wine.jpg"];
//    names = @[@"Heavenly",@"Nature",@"Running",@"Garden",@"Wine"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.rowHeight = UITableViewAutomaticDimension;
    //self.estimatedRowHeight = 400.0;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
    [self initInterestPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [_interestPresenter unregisterOnBus];
    _interestPresenter = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchDisplay

-(void)setupSearch {
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];

    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

# pragma mark - initInterestPresenter

- (void)initInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithInteractor:self];
    [_interestPresenter registerOnBus];
    [_interestPresenter loadInterests];
}

# pragma mark - IInterestInteractor Methods

- (void)initInterests:(NSMutableArray *)interests {
    _interests = interests;
    [self.tableView reloadData];
}

/*#pragma mark - Search

- (void)SearchViewController {
    
    CLSearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    
    //searchomtroller
    [[self navigationController] pushViewController:search animated:YES];
}*/

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _interests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
//    cell.groupImageView.image = [UIImage imageNamed:images[indexPath.row]];
//    cell.labelName.text = [NSString stringWithFormat: @"#%@", names[indexPath.row]];
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toDetail"]) {
        [self goToDetailView:segue];
    }
}

# pragma mark - goToDetailView

- (void)goToDetailView:(UIStoryboardSegue *)segue {
    CLGroupDetailViewController *detailView = (CLGroupDetailViewController *)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
//    NSString *currentImage = [images objectAtIndex:indexPath.row];
//    NSString *currentName = [names objectAtIndex:indexPath.row];
    
//    detailView.currentImage = currentImage;
//    detailView.currentName = currentName;

}

# pragma mark - setupNavBar

- (void)setupNavBar {
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    _barColor = [UIColor groupNavBarColor];
    self.navigationController.navigationBar.barTintColor = _barColor;
}

@end
