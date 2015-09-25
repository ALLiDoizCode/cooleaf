//
//  CLPostViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLPostViewController.h"
#import "UIColor+CustomColors.h"
#import "CLPostCell.h"
#include <AssetsLibrary/AssetsLibrary.h> 

@interface CLPostViewController () {
    @private
       
    ALAssetsLibrary *library;
    NSArray *imageArray;
    NSMutableArray *mutableArray;
}

@end

static int count=0;

@implementation CLPostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _postView.postTextView.delegate = self;
    
    [_postView.cameraBtn addTarget:self action:@selector(getCamera) forControlEvents:UIControlEventTouchUpInside];
    [_postView.addImageBtn addTarget:self action:@selector(getPicture) forControlEvents:UIControlEventTouchUpInside];
    [_postView.postBtn addTarget:self action:@selector(comments) forControlEvents:UIControlEventTouchUpInside];
    [_postView.cancelBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//This function is here to demostrate closing the postview controller but needs to be added to the navigation class once the group branch is merged with master
- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [ _postView.postTextView endEditing:YES];
    
}



# pragma mark - getPicture

-(void)getPicture {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
    //[self getAllPictures];
}

-(void)getCamera {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}


-(void)checkForCamera{
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
}

# pragma mark - UIImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenEditedImage  = info[UIImagePickerControllerEditedImage];
    
    _imgToUpload = chosenEditedImage;
    
    _postView.imageView.image = _imgToUpload;
     _postView.imageView.hidden = false;
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self animateTextView: YES];
    
    if ([_postView.postTextView.text isEqualToString:@"Enter your post..."])
        
    {
        
        _postView.postTextView.text = @"";
        
        _postView.postTextView.textColor = [UIColor offBlack];
        
    }
    
    [_postView.postTextView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self animateTextView:NO];
}

- (void) animateTextView:(BOOL) up {
    
    if ([[UIScreen mainScreen] bounds].size.height >= 568 || [[UIScreen mainScreen] bounds].size.width >= 568 ) {
        
        static const int movementDistance = 100; // tweak as needed
        static const int movementDistanceButton = 150; // tweak as needed
        static const float movementDuration = 0.3f; // tweak as needed
        
        // If moving up raise textfield up by movementDistance else lower it by movement distance with a defined duration
        int movement = up ? -movementDistance : movementDistance;
        int buttonMovement = up ? -movementDistanceButton : movementDistanceButton;
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        _postView.addImageBtn.frame = CGRectOffset( _postView.addImageBtn.frame, 0, buttonMovement);
        _postView.cameraBtn.frame = CGRectOffset(_postView.cameraBtn.frame, 0, buttonMovement);
        [UIView commitAnimations];


        
    } else {
        //device = DEVICE_TYPE_IPHONE4 ;
        static const int movementDistance = 100; // tweak as needed
        static const int movementDistanceButton = 120; // tweak as needed
        static const float movementDuration = 0.3f; // tweak as needed
        
        // If moving up raise textfield up by movementDistance else lower it by movement distance with a defined duration
        int movement = up ? -movementDistance : movementDistance;
        int buttonMovement = up ? -movementDistanceButton : movementDistanceButton;
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        
        self.view.frame = CGRectOffset(self.view.frame, 0, movement);
        _postView.addImageBtn.frame = CGRectOffset( _postView.addImageBtn.frame, 0, buttonMovement);
        _postView.cameraBtn.frame = CGRectOffset(_postView.cameraBtn.frame, 0, buttonMovement);
        [UIView commitAnimations];


    }
    
   
    
  }


-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        // Return FALSE so that the final '\n' character doesn't get added
        return NO;
    }
    // For any other character return TRUE so that the text gets added to the view
    return YES;
}


# pragma mark - Members CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [imageArray count];
}

# pragma mark - Members CollectionView Delegate

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    
    // load the images
    cell.images = [UIImage imageNamed:@"TestImage"];
   
    
    return cell;
}
/////Gets all assets
/*-(void)getAllPictures {
    
    imageArray=[[NSArray alloc] init];
    mutableArray =[[NSMutableArray alloc]init];
    NSMutableArray* assetURLDictionaries = [[NSMutableArray alloc] init];
    
    library = [[ALAssetsLibrary alloc] init];
    
    void (^assetEnumerator)( ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if(result != nil) {
            if([[result valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypePhoto]) {
                [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                
                NSURL *url= (NSURL*) [[result defaultRepresentation]url];
                
                [library assetForURL:url
                         resultBlock:^(ALAsset *asset) {
                             [mutableArray addObject:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]]];
                             
                             if ([mutableArray count]==count)
                             {
                                 imageArray=[[NSArray alloc] initWithArray:mutableArray];
                                 //[self allPhotosCollected:imageArray];
                                 
                                 self.imageCollectionView.reloadData;
                             }
                         }
                        failureBlock:^(NSError *error){ NSLog(@"operation was not successfull!"); } ];
                
            }
        }
    };
    
    NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
    
    void (^ assetGroupEnumerator) ( ALAssetsGroup *, BOOL *)= ^(ALAssetsGroup *group, BOOL *stop) {
        if(group != nil) {
            [group enumerateAssetsUsingBlock:assetEnumerator];
            [assetGroups addObject:group];
            count=[group numberOfAssets];
        }
    };
    
    assetGroups = [[NSMutableArray alloc] init];
    
    [library enumerateGroupsWithTypes:ALAssetsGroupAll
                           usingBlock:assetGroupEnumerator
                         failureBlock:^(NSError *error) {NSLog(@"There is an error");}];
}*/

/*-(void)allPhotosCollected:(NSArray*)imgArray
{
    //write your code here after getting all the photos from library...
    NSLog(@"all pictures are %@",imgArray);
}*/





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
