//
//  CLGroupEventsController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupEventsController.h"
#import "CLGroupEventCell.h"

@interface CLGroupEventsController ()

@end

@implementation CLGroupEventsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
     CLGroupEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupEvent"];
    
    return cell;
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
