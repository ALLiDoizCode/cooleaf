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

static const int movementDistance = 250; // tweak as needed
static const float movementDuration = 0.3f; // tweak as needed

@interface CLCommentController ()

@end

@implementation CLCommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.delegate = self;
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    // Initialize Comments UI
    [self setupView];
    [self setupButtons];
    [self setupBorders];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - setupView

- (void)setupView {
    // Comments header label for CLCommentViewController
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(250, 10, 100, 18)];
    labelTitle.textAlignment = NSTextAlignmentLeft;
    labelTitle.text = @"Comments";
    labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    labelTitle.backgroundColor = [UIColor clearColor];
    labelTitle.textColor = [UIColor offBlack];
    [labelTitle sizeToFit];
    labelTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    // Set the background color and edge corner radius of the tableview for comments
    _tableView.backgroundColor = [UIColor offWhite];
    _mainView.backgroundColor = [UIColor offWhite];
    _mainView.layer.cornerRadius = 3;
    
    // Add label view
    [_mainView addSubview:labelTitle];
}

# pragma mark - setupButtons

- (void)setupButtons {
    
  /*  //Send
    UIButton *sendBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    sendBtn.frame = CGRectMake(220, 500, 100, 18);
    [sendBtn setTitle:@"Send" forState:UIControlStateNormal];
    //[sendBtn addTarget:self action:@selector() forControlEvents:UIControlEventTouchUpInside];*/
    
   
    [_addImage addTarget:self action:@selector(getPicture) forControlEvents:UIControlEventTouchUpInside];
    
    //Cancel
    UIButton *cancelBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(-10, 10, 100, 18);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(closeCommentController) forControlEvents:UIControlEventTouchUpInside];
    
    //[_mainView addSubview:sendBtn];
    [_mainView addSubview:cancelBtn];
    //[_mainView addSubview:addImageBtn];
}

# pragma mark - setupBorders

- (void)setupBorders {
    // Add a small black border below header
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 300, 0.5)];
    topBorder.backgroundColor = [UIColor offBlack];
    
    // Add to main view
    [_mainView addSubview:topBorder];
}

# pragma mark - closeCommentController

// Needs to be added to the Navigation Class
- (void)closeCommentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - TextField Delegate Methods

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self animateTextField: textField up: YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self animateTextField: textField up: NO];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_textField endEditing:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)animateTextField:(UITextField*)textField up:(BOOL)up {
    
    // If moving up raise textfield up by movementDistance else lower it by movement distance with a defined duration
    int movement = up ? -movementDistance : movementDistance;
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (void)viewDidLayoutSubviews {
    // Set height between textfield and tableview
    CGRect frm = _bottomBordrer.frame;
    frm.size.height = 0.5;
   _bottomBordrer.frame = frm;
}

# pragma mark - TableView Data Source

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

# pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - getPicture

-(void)getPicture {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

# pragma mark - UIImagePickerController Delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
    UIImage *chosenImage  = [editInfo objectForKey:@"UIImagePickerControllerOriginalImage"];
    _imgToUpload = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
