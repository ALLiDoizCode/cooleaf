//
//  CLPostViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLPostView.h"

@interface CLPostViewController : UIViewController <UITextViewDelegate,UIImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (weak, nonatomic) UIImage *imgToUpload;

@property (weak, nonatomic) IBOutlet CLPostView *postView;

@end
