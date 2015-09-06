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

    [self buildView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildView {
    
    UIView *postView = [[UIView alloc] initWithFrame:CGRectMake(10, 75, 300, 285)];
    
    postView.backgroundColor = [UIColor offWhite];
    postView.layer.cornerRadius = 2;
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, postView.frame.size.height - 235, 300, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //Border2
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, postView.frame.size.height - 55, 300, 0.5)];
    border2.backgroundColor = [UIColor lightGrayColor];
    
    //TextView
    postTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 51, postView.bounds.size.width, 180)];
    postTextView.backgroundColor = [UIColor clearColor];
    postTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
   CGPoint scrollPoint = postTextView.contentOffset;
    scrollPoint.y= scrollPoint.y+40;
    [postTextView setContentOffset:scrollPoint animated:YES];
    
    //cameraBtn
    UIButton *cameraBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cameraBtn.frame = CGRectMake(10, postView.frame.size.height - 50, 40, 40);
    [cameraBtn setTitle:@"Image" forState:UIControlStateNormal];
    [cameraBtn setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    //[postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //addImage
    UIButton *addImageBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    addImageBtn.frame = CGRectMake(250, postView.frame.size.height - 50, 40, 40);
    [addImageBtn setTitle:@"Image" forState:UIControlStateNormal];
    [addImageBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    //[postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    /*UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 355, 40, 40)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.image = [UIImage imageNamed:@"Camera"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.borderColor = [UIColor clearColor].CGColor;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;*/
    
    //Title
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 0, 0)];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.text = @"Create a Post";
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor offBlack];
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
    [cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:postView];
    [postView addSubview:border];
    [postView addSubview:border2];
    [postView addSubview:labelTitle];
    [postView addSubview:postBtn];
    [postView addSubview:cancelBtn];
    [postView addSubview:postTextView];
    [postView addSubview:cameraBtn];
    [postView addSubview:addImageBtn];
   
}

- (void)close {
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
