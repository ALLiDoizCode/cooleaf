//
//  CLCommentController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentController.h"
#import "UIColor+CustomColors.h"
#import "CLCommentCell.h"

@interface CLCommentController ()

@end

@implementation CLCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];
    [self buildTextField];
    [self buildBorders];
    [self buildButtons];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configureView {
    
    
    //Name
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 100, 18)];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.text = @"Comments";
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor offBlack];
    [labelTitle sizeToFit];
    labelTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    _tableView.backgroundColor = [UIColor offWhite];
    _mainView.backgroundColor = [UIColor offWhite];
    _mainView.layer.cornerRadius = 3;
    
    [_mainView addSubview:labelTitle];
}

-(void)buildTextField {
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(60, 497, 180, 25)];
    textField.backgroundColor = [UIColor clearColor];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.textColor = [UIColor darkTextColor];
    textField.placeholder = @"Leave a comment...";
    
    [_mainView addSubview:textField];
}

-(void)buildButtons {
    
    //Send
    UIButton *sendBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    sendBtn.frame = CGRectMake(220, 500, 100, 18);
    [sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    //[sendBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    
    //Send
    UIButton *addImageBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    addImageBtn.frame = CGRectMake(15, 494, 30, 30);
    [addImageBtn setTitle:@"Send" forState:UIControlStateNormal];
    [addImageBtn setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    //[sendBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];
    
    //Cancel
    UIButton *cancelBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(-10, 10, 100, 18);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:sendBtn];
    [_mainView addSubview:cancelBtn];
    [_mainView addSubview:addImageBtn];
}

//This function is here to demostrate closing the postview controller but needs to be added to the navigation class once the group branch is merged with master
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)buildBorders {
    
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 300, 0.5)];
    topBorder.backgroundColor = [UIColor offBlack];
    
    UIView *bottomBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 488, 300, 0.5)];
    bottomBorder.backgroundColor = [UIColor offBlack];
    
    [_mainView addSubview:topBorder];
    [_mainView addSubview:bottomBorder];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    cell.cellImage.image = [UIImage imageNamed:@"TestImage"];
    cell.nameLabel.text = @"Prem Bhatia";
    cell.postLabel.text = @"Hopefully something fun";
    cell.timeLabel.text = @"1h";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
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
