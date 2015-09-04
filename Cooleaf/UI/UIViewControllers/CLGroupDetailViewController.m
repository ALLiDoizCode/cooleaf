//
//  CLGroupDetailViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupDetailViewController.h"
#import "UIColor+CustomColors.h"


@interface CLGroupDetailViewController ()  {
    
    UIColor *barColor;
}

@end

@implementation CLGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self searchDisplay];
    
    _detailView.mainImageView.image = [UIImage imageNamed:_currentImage];
    _detailView.labelName.text =[NSString stringWithFormat: @"#%@", _currentName];
    [_detailView.postBtn addTarget:self action:@selector(groupPostViewController) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.alpha = 0.7;
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    barColor = [UIColor UIColorFromRGB:0xF07073];
    
    self.navigationController.navigationBar.barTintColor = barColor;
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchDisplay

-(void)searchDisplay {
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    barColor = [UIColor UIColorFromRGB:0x52B6AC];
    
    self.navigationController.navigationBar.barTintColor = barColor;
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    
    
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];
    
    
    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

- (void)groupPostViewController {
    
    CLGroupPostViewcontroller *search = [self.storyboard instantiateViewControllerWithIdentifier:@"groupPostViewController"];
    
    //searchomtroller
    [[self navigationController] pushViewController:search animated:YES];
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
