//
//  CLGroupDetailViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Edited by Haider Khan on 9/10/15
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLGroupDetailViewController.h"
#import "UIColor+CustomColors.h"
#import "CCColorCube.h"

@interface CLGroupDetailViewController ()  {
    @private
    UIColor *barColor;
}

@end

@implementation CLGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    [self setupSearch];
    
    [_detailView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.currentImagePath]
                                 placeholderImage:[UIImage imageNamed:nil]];
    _detailView.labelName.text =[NSString stringWithFormat: @"#%@", _currentName];
    [_detailView.postBtn addTarget:self action:@selector(goToGroupPostViewController) forControlEvents:UIControlEventTouchUpInside];
}

-(void)viewWillAppear:(BOOL)animated {
    [self grabColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)grabColor {
    
    // Get four dominant colors from the image, but avoid the background color of our UI
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    UIImage *img =_detailView.mainImageView.image;
    NSArray *imgColors = [colorCube extractColorsFromImage:img flags:nil];
    barColor = imgColors[1];
    
    self.navigationController.navigationBar.barTintColor = barColor;
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}

#pragma mark - searchDisplay

-(void)setupSearch {
    // Set text on navbar to white
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    // Set nav bar color
    barColor = [UIColor searchNavBarColor];
    self.navigationController.navigationBar.barTintColor = barColor;
    
    // Set buttons
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];

    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

- (void)goToGroupPostViewController {    
    CLGroupPostViewcontroller *search = [self.storyboard instantiateViewControllerWithIdentifier:@"groupPostViewController"];
    [[self navigationController] pushViewController:search animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLGroupPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupDetailCell"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
