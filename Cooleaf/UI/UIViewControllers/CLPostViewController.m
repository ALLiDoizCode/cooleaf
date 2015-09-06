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
    UIView *postView;
    UIColor *offWhite;
    UIColor *offBlack;
    UITextView *postTextView;
    UIImageView *imageView;
}

@end

@implementation CLPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    postTextView.delegate = self;
    postTextView.editable = YES;

    [self buildView];
    [self buildTextView];
    [self buildLabel];
    [self buildButtons];
    [self buildImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buildView {
    postView = [[UIView alloc] initWithFrame:CGRectMake(10, 35, 300, 285)];
    postView.backgroundColor = [UIColor offWhite];
    postView.layer.cornerRadius = 3;
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, postView.frame.size.height - 235, 300, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //Border2
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, postView.frame.size.height - 55, 300, 0.5)];
    border2.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:postView];
    [postView addSubview:border];
    [postView addSubview:border2];
}

-(void)buildTextView {
    
    //TextView
    postTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 51, postView.bounds.size.width/1.5, 180)];
    postTextView.backgroundColor = [UIColor clearColor];
    postTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    CGPoint scrollPoint = postTextView.contentOffset;
    scrollPoint.y= scrollPoint.y+40;
    [postTextView setContentOffset:scrollPoint animated:YES];
    [postView addSubview:postTextView];
}

-(void)buildLabel {
    
    //Title
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 20, 0, 0)];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.text = @"Create a Post";
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor offBlack];
    [labelTitle sizeToFit];
    labelTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [postView addSubview:labelTitle];

}

-(void)buildButtons {
    
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
    [addImageBtn addTarget:self action:@selector(addImage) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    [postView addSubview:postBtn];
    [postView addSubview:cancelBtn];
    [postView addSubview:cameraBtn];
    [postView addSubview:addImageBtn];
}

-(void)buildImage {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(200, 60, 95, 95)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.image = [UIImage imageNamed:@"TestImage"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
    imageView.hidden = true;
    
    [postView addSubview:imageView];
}

////This function is here to demostrate closing the postview controller but needs to be added to the navigation class once the group branch is merged with master
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

//This function demostrates adding a image to teh users post but needs to be placed in a seprate class the handles adding an image from the devices gallery.
-(void)addImage {
    imageView.hidden = false;
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
