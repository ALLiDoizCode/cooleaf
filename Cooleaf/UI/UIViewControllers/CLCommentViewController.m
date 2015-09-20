//
//  CLCommentController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLCommentViewController.h"
#import "UIColor+CustomColors.h"
#import "CLCommentCell.h"
#import "CLCommentPresenter.h"
#import "CLComment.h"
#import "CLClient.h"

static const int movementDistance = 250; // tweak as needed
static const float movementDuration = 0.3f; // tweak as needed

@interface CLCommentViewController()

@property (nonatomic, strong) CLCommentPresenter *commentPresenter;
@property (nonatomic, strong) NSMutableArray *comments;

@end

@implementation CLCommentViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _textField.delegate = self;
    
    self.view.frame = [UIScreen mainScreen].bounds;
    
    // Initialize Comments UI
    [self setupView];
    [self setupButtons];
    [self setupBorders];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupCommentPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_commentPresenter)
        [_commentPresenter unregisterOnBus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
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
    
    // Send comment button
    [_send addTarget:self action:@selector(sendEventComment) forControlEvents:UIControlEventTouchUpInside];
    
    // Add image button
    [_addImage addTarget:self action:@selector(getPicture) forControlEvents:UIControlEventTouchUpInside];
    
    // Cancel button
    UIButton *cancelBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    cancelBtn.frame = CGRectMake(-10, 10, 100, 18);
    [cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(closeCommentController) forControlEvents:UIControlEventTouchUpInside];
    
    [_mainView addSubview:cancelBtn];
}

# pragma mark - setupBorders

- (void)setupBorders {
    // Add a small black border below header
    UIView *topBorder = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 300, 0.5)];
    topBorder.backgroundColor = [UIColor offBlack];
    
    // Add to main view
    [_mainView addSubview:topBorder];
}

# pragma mark - setupCommentPresenter

- (void)setupCommentPresenter {
    _commentPresenter = [[CLCommentPresenter alloc] initWithInteractor:self];
    [_commentPresenter registerOnBus];
    [_commentPresenter loadEventComments:[[_event eventId] intValue]];
}

# pragma mark - sendEventComment

- (void)sendEventComment {
    // Call textfield delegate to send comment on send button touch
    [self textFieldShouldReturn:self.textField];
}

# pragma mark - closeCommentController

// Needs to be added to the Navigation Class
- (void)closeCommentController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - ICommentInteractor Methods

- (void)initEventComments:(NSMutableArray *)comments {
    _comments = [[NSMutableArray alloc] initWithArray:comments];
    [self.tableView reloadData];
}

- (void)addEventComment:(CLComment *)comment {
    
    // Add new comment to comment array
    [_comments addObject:comment];
    
    // Get the path to the last row
    NSInteger lastSectionIndex = [self.tableView numberOfSections] - 1;
    NSInteger lastRowIndex = [self.tableView numberOfRowsInSection:lastSectionIndex];
    NSIndexPath *pathToLastRow = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
    
    // Add the new comment with animation to the tableview
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[pathToLastRow] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView reloadData];
    [self.tableView endUpdates];
    
    // Scroll to the bottom of the tableview
    [self.tableView scrollToRowAtIndexPath:pathToLastRow atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

# pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentCell"];
    
    // Get the comment
    NSDictionary *commentDict = [_comments objectAtIndex:[indexPath row]];
    
    // Set the user name
    cell.nameLabel.text = commentDict[@"user_name"];
    
    // Set the content
    cell.postLabel.text = commentDict[@"content"];
    
    // TODO - Set the time
    cell.timeLabel.text = @"1h";
    
    // Set the path and load the image
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], commentDict[@"user_picture"][@"versions"][@"icon"]];
    [cell.cellImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    
    return cell;
}

# pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Do some stuff when the row is selected
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
    
    // Get text and send to API only if the textfield is not empty
    if (![textField.text isEqualToString:@""]) {
        NSString *content = textField.text;
        [_commentPresenter addEventComment:[[_event eventId] intValue] content:content];
        textField.text = @"";
    }
    
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