//
//  CLGroupViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupViewController.h"
#import "UIColor+CustomColors.h"

@interface CLGroupViewController () {
    
    NSArray *images;
    NSArray *names;
    UIColor *barColor;

}

@end

@implementation CLGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self searchDisplay];
    
    images = @[@"heavenly.jpg",@"nature.jpg",@"Running.jpg",@"garden.jpg",@"wine.jpg"];
    names = @[@"heavenly",@"nature",@"Running",@"garden",@"wine"];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.rowHeight = UITableViewAutomaticDimension;
    //self.estimatedRowHeight = 400.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return images.count;
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

/*#pragma mark - Search

- (void)SearchViewController {
    
    CLSearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    
    //searchomtroller
    [[self navigationController] pushViewController:search animated:YES];
}*/



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
    
    cell.groupImageView.image = [UIImage imageNamed:images[indexPath.row]];
    cell.labelName.text = names[indexPath.row];
    
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
