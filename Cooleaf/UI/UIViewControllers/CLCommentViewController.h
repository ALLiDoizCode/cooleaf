//
//  CLCommentController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLCommentTableView.h"
#import "CLEvent.h"
#import "ICommentInteractor.h"

@interface CLCommentViewController : UIViewController <ICommentInteractor, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, assign) CLEvent *event;
@property (weak, nonatomic) IBOutlet CLCommentTableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *addImage;
@property (weak, nonatomic) IBOutlet UIButton *send;
@property (weak, nonatomic) IBOutlet UIView *bottomBordrer;
@property (weak, nonatomic) UIImage *imgToUpload;
@property (nonatomic, assign) UIImageView *backgroundImage;

@end
