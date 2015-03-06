//
//  NPInterestsViewController.m
//  Cooleaf
//
//  Created by Dirk R on 2/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestsViewController.h"

@interface NPInterestsViewController ()

@end

@implementation NPInterestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"Groups";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (UITabBarItem *)tabBarItem
{
	return [[UITabBarItem alloc] initWithTitle:self.title
										 image:[[UIImage imageNamed:@"Interests"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
								 selectedImage:[UIImage imageNamed:@"Interests"]];
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
