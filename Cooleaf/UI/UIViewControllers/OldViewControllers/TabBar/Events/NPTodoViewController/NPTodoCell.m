//
//  NPTodoCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPTodoCell.h"
#import "NPCooleafClient.h"
#import "UIFont+ApplicationFont.h"

static UITextView *_tV = nil;

@interface NPTodoCell ()

@property (weak, nonatomic) IBOutlet UIButton *checkbox;
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;
@property (weak, nonatomic) IBOutlet UILabel *ownershipLabel;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *takeCareButton;
@property (weak, nonatomic) IBOutlet UIImageView *checkboxProgress;

- (IBAction)takeCareTapped:(id)sender;

- (IBAction)checkboxTapped:(id)sender;
@end

@implementation NPTodoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    CGRect f;
    f = _topSeparator.frame;
    f.size.height = 0.5;
    _topSeparator.frame = f;
    
    f = _bottomSeparator.frame;
    f.size.height = 0.5;
    f.origin.y += 0.5;
    _bottomSeparator.frame = f;
    
    _takeCareButton.layer.borderColor = _takeCareButton.titleLabel.textColor.CGColor;
    _takeCareButton.layer.borderWidth = 1.0;
    _takeCareButton.layer.cornerRadius = 2.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTodo:(NSDictionary *)todo
{
    _todo = todo;
    _titleView.text = todo[@"name"];
    CGRect f = _titleView.frame;
    [_titleView sizeToFit];
    f.size.height = _titleView.frame.size.height;
    _titleView.frame = f;
    _progress = NO;
    CGFloat shift = f.size.height - 31;
    
    _checkboxProgress.hidden = YES;
    _bottomSeparator.transform = CGAffineTransformMakeTranslation(0, shift + 10);
    _activityIndicator.transform = CGAffineTransformMakeTranslation(0, shift);
    _ownershipLabel.transform = CGAffineTransformMakeTranslation(0, shift);
    _avatarView.transform = CGAffineTransformMakeTranslation(0, shift);
    _takeCareButton.transform = CGAffineTransformMakeTranslation(0, shift);
    NSMutableAttributedString *ownershipString = nil;
    if ([todo[@"done"] boolValue])
    {
        if ([todo[@"user"][@"id"] compare:[NPCooleafClient sharedClient].userData[@"id"]] == NSOrderedSame)
        {
            _checkbox.enabled = YES;
            _checkbox.selected = YES;
            ownershipString = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"You’re taking care of this.", nil)
                                                                     attributes:@{NSFontAttributeName: [UIFont mediumApplicationFontOfSize:11]}];
            _ownershipLabel.attributedText = ownershipString;
            UIImage *avatarPlaceholder = nil;
            NSDictionary *uD = [NPCooleafClient sharedClient].userData;
            if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
                avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceholderFemaleSmall"];
            else
                avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceholderMaleSmall"];
            
            _avatarView.image = avatarPlaceholder;
            if (uD[@"profile"][@"picture"][@"original"])
            {
                NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"small"]];
                [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
                    if (image && [imagePath isEqual:avatarURL.absoluteString])
                    {
                        _avatarView.image = image;
                    }
                }];
            }
            _avatarView.alpha = 1.0;
            _avatarView.hidden = NO;
            _ownershipLabel.hidden = NO;
            _takeCareButton.hidden = YES;
            
        }
        else
        {
            
            ownershipString = [[NSMutableAttributedString alloc] initWithString:todo[@"user"][@"name"]
                                                                     attributes:@{NSFontAttributeName: [UIFont mediumApplicationFontOfSize:11]}];
            [ownershipString appendAttributedString:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"\nis taking care of this.", nil)
                                                                                    attributes:@{NSFontAttributeName: [UIFont applicationFontOfSize:11]}]];
            
            _ownershipLabel.attributedText = ownershipString;
            
            UIImage *avatarPlaceholder = nil;
            NSDictionary *uD = todo[@"user"];
            if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
                avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceholderFemaleSmall"];
            else
                avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceholderMaleSmall"];
            
            _avatarView.image = avatarPlaceholder;
            if (uD[@"profile"][@"picture"][@"versions"][@"medium"])
            {
                NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"small"]];
                [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
                    if (image && [imagePath isEqual:avatarURL.absoluteString])
                    {
                        _avatarView.image = image;
                    }
                }];
            }

            
            _checkbox.enabled = NO;
            _checkbox.selected = NO;
            
            _avatarView.alpha = 0.6;
            _avatarView.hidden = NO;
            _ownershipLabel.hidden = NO;
            _takeCareButton.hidden = YES;

        }
    }
    else
    {
        _checkbox.enabled = YES;
        _checkbox.selected = NO;

        
        _avatarView.hidden = YES;
        _ownershipLabel.hidden = YES;
        _takeCareButton.hidden = NO;

    }
}

- (void)setProgress:(BOOL)progress
{
    _progress = progress;
    
    _checkboxProgress.hidden = !progress;
    if (_progress)
    {
        _avatarView.hidden = YES;
        _takeCareButton.hidden = YES;
        [_activityIndicator startAnimating];
        _ownershipLabel.attributedText = [[NSAttributedString alloc] initWithString:NSLocalizedString(@"Saving...", nil)
                                                                         attributes:@{NSFontAttributeName: [UIFont mediumApplicationFontOfSize:11]}];
        _ownershipLabel.hidden = NO;
    }
    else
    {
        self.todo = _todo;
    }
}

- (IBAction)takeCareTapped:(id)sender
{
    if (_progress)
        return;
    self.progress = YES;
    if (self.careActionBlock)
        self.careActionBlock(_todo, YES);
    
}

- (IBAction)checkboxTapped:(id)sender
{
    if (_progress)
        return;
    
    if (_checkbox.selected)
    {
        self.progress = YES;
        if (self.careActionBlock)
            self.careActionBlock(_todo, NO);
    }
    else
    {
        self.progress = YES;
        if (self.careActionBlock)
            self.careActionBlock(_todo, YES);
        
    }
}


+ (CGFloat)cellHeightForTodo:(NSDictionary *)todo
{
    if (!_tV)
        _tV =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 270, 20)];
    else
        _tV.frame = CGRectMake(0, 0, 270, 20);
    
    _tV.font = [UIFont boldSystemFontOfSize:16];
    _tV.text = todo[@"name"];
    [_tV sizeToFit];
    
    return 80 + _tV.frame.size.height;
}

@end
