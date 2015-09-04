//
//  CLPostViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLPostViewController.h"
#import "UIColor+CustomColors.h"

@interface CLPostViewController () {
    @private 
    UIColor *offWhite;
    UIColor *offBlack;
    UITextView *postTextView;
}

@end

@implementation CLPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    postTextView.delegate = self;
     postTextView.editable = YES;

    offWhite = [UIColor UIColorFromRGB:0xFDFDFD];
    offBlack = [UIColor UIColorFromRGB:0x252525];
    
    [self buildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildView {
    
    
    UIView *postView = [[UIView alloc] initWithFrame:CGRectMake(10, 75, 300, 300)];
    
    postView.backgroundColor = offWhite;
    postView.layer.cornerRadius = 2;
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 50, 300, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //TextView
    postTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 51, postView.bounds.size.width, postView.bounds.size.height - 50)];
    postTextView.backgroundColor = [UIColor clearColor];
    postTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    
    //Title
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 0, 0)];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.text = @"Create a Post";
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = offBlack;
    [labelTitle sizeToFit];
    labelTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Post
    UIButton *postBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(210, 20, 100, 18);
    [postBtn setTitle:@"Post" forState:UIControlStateNormal];
    //[postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Cancel
    UIButton *cancelBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(0, 20, 100, 18);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    //[cancelBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];

    
    [self.view addSubview:postView];
    [postView addSubview:border];
    [postView addSubview:labelTitle];
    [postView addSubview:postBtn];
    [postView addSubview:cancelBtn];
    [postView addSubview:postTextView];
   
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [postTextView endEditing:YES];
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
