//
//  NPEventCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPEventCell.h"
#import "NPCooleafClient.h"

#define AVATAR_TAG 1001

static UITextView *_tV;

@interface NPEventCell ()
{
    NSDateFormatter *_dateFormatter;
    NSDateFormatter *_dateFormatter2;
    CGPoint _startingPoint;
    BOOL _showsActionButton;
}
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UITextView *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UITextView *eventTags;
@property (weak, nonatomic) IBOutlet UIView *slideBarContent;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;
@property (weak, nonatomic) IBOutlet UIImageView *attendeeIcon;
@property (weak, nonatomic) IBOutlet UILabel *attendeeLabel;
@property (weak, nonatomic) IBOutlet UIView *sliderBarView;
@property (weak, nonatomic) IBOutlet UIView *selectionView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;

- (IBAction)joinTapped:(id)sender;
- (void)panned:(UIPanGestureRecognizer *)rec;
@end

@implementation NPEventCell

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
    UIPanGestureRecognizer *rec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panned:)];
    rec.cancelsTouchesInView = YES;
    rec.delegate = self;
    [_sliderBarView addGestureRecognizer:rec];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    if (!animated)
    {
        _selectionView.alpha = 1.0;
        _selectionView.hidden = !selected;
        
        if (selected)
        {
            _sliderBarView.transform = CGAffineTransformIdentity;
            _showsActionButton = NO;
        }
    }
    else
    {
        _selectionView.alpha = (selected) ? 0 : 1;
        _selectionView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _selectionView.alpha = (selected) ? 1 : 0;
            if (selected)
            {
                _sliderBarView.transform = CGAffineTransformIdentity;
                _showsActionButton = NO;
            }
            
        } completion:^(BOOL finished) {
            if (finished)
            {
                _selectionView.hidden = !selected;
            }
        }];
    }
}

- (void)prepareForReuse
{
    [self setEvent:nil];
    [self setLoading:NO];
}

- (UIView *)avatarForUser:(NSDictionary *)user offset:(CGFloat)offset
{
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(12 + 30*offset, 45, 26, 26)];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.layer.cornerRadius = 13.0;
    avatar.clipsToBounds = YES;
    avatar.alpha = 0.6;
    avatar.tag = AVATAR_TAG;
    
    if (user)
    {
        if ([(NSString *)user[@"profile"][@"gender"] isEqualToString:@"m"])
            avatar.image = [UIImage imageNamed:@"AvatarPlaceholderMaleSmall"];
        else
            avatar.image = [UIImage imageNamed:@"AvatarPlaceholderFemaleSmall"];
        
        if (user[@"profile"][@"picture"][@"original"])
        {
            NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:user[@"profile"][@"picture"][@"versions"][@"small"]];
            [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
                if (image && [imagePath isEqual:avatarURL.absoluteString])
                {
                    avatar.image = image;
                }
            }];
        }
        else
        {
            avatar.alpha = 1.0;
        }
    }
    else
    {
        avatar.image = [UIImage imageNamed:@"AvatarMore"];
        avatar.alpha = 1.0;
    }
    return avatar;
}

- (void)setEvent:(NSDictionary *)event
{
    _event = event;
    
    if (!event)
    {
        _eventImage.image = [UIImage imageNamed:@"CoverPhotoPlaceholder"];
        // Delete all avatars
        for (UIView *v in _sliderBarView.subviews)
        {
            if (v.tag == AVATAR_TAG)
                [v removeFromSuperview];
        }
        return;
    }
    
    CGFloat shift = 0;
    CGFloat shift2 = 0;
    _eventTitle.text = _event[@"name"];
    CGRect f;
    f = _eventTitle.frame;
    [_eventTitle sizeToFit];
    _eventTitle.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, _eventTitle.frame.size.height);
    shift = _eventTitle.frame.size.height - 47.0;
    
    if (!_dateFormatter)
    {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy'-'MM'-'dd' 'HH':'mm':'ss' 'z";
    }
    NSDate *eventTime = [_dateFormatter dateFromString:_event[@"start_time"]];

    if (!_dateFormatter2)
    {
        _dateFormatter2 = [NSDateFormatter new];
        _dateFormatter2.dateStyle = NSDateFormatterLongStyle;
        _dateFormatter2.timeStyle = NSDateFormatterNoStyle;
    }
    
    _eventDate.text = [_dateFormatter2 stringFromDate:eventTime];
    
    NSMutableString *hashes = [NSMutableString string];
    for (NSString *hash in _event[@"categories_names"])
    {
        if (hashes.length > 0)
            [hashes appendFormat:@" #%@", hash];
        else
            [hashes appendFormat:@"#%@", hash];
    }
    
    // Now - let's set proper colors for attendees
    if ([_event[@"participants"] count] > 0)
    {
        _attendeeIcon.image = [UIImage imageNamed:@"AttendeeIcon"];
        _attendeeLabel.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
        _attendeeLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)[_event[@"participants"] count]];
        
        f = _slideBarContent.frame;
        f.size.height = 95;
        _slideBarContent.frame = f;
        f = _sliderBarView.frame;
        f.size.height = 95;
        _sliderBarView.frame = f;
        
        f = _joinButton.frame;
        f.size.height = 90;
        _joinButton.frame = f;
        
        // Now we can add participants
        int avatarCount = 0;
        UIView *avatar = nil;
        // If we are participating - let's add us first
        if ([_event[@"attending"] boolValue])
        {
            avatar = [self avatarForUser:[NPCooleafClient sharedClient].userData offset:0];
            avatar.alpha = 1.0;
            [_sliderBarView addSubview:avatar];
            avatarCount = 1;
            _slideBarContent.backgroundColor = [UIColor colorWithRed:1 green:56.0/255.0 blue:36.0/255.0 alpha:1];
            [_joinButton setTitle:NSLocalizedString(@"I’m out", @"Leaving event button title") forState:UIControlStateNormal];
        }
        else
        {
            _slideBarContent.backgroundColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];
            [_joinButton setTitle:NSLocalizedString(@"I’m in!", @"Joining event button title") forState:UIControlStateNormal];
        }
        
        // Now all the rest
        for (int i = 0; i < [_event[@"participants"] count]; i++)
        {
            // Skip ourselves
            if ([_event[@"participants"][i][@"id"] compare:[NPCooleafClient sharedClient].userData[@"id"]] == NSOrderedSame)
                continue;
            
            avatar = [self avatarForUser:_event[@"participants"][i] offset:avatarCount];
            [_sliderBarView addSubview:avatar];
            avatarCount++;
            
            if (avatarCount > 8)
            {
                avatar = [self avatarForUser:nil offset:avatarCount];
                [_sliderBarView addSubview:avatar];
                break;
            }
        }
        shift2 = 45;
        _loadingIndicator.transform = CGAffineTransformMakeTranslation(0, 25);
    }
    else
    {
        shift2 -= 9;
        _slideBarContent.backgroundColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];
        [_joinButton setTitle:NSLocalizedString(@"I’m in!", @"Joining event button title") forState:UIControlStateNormal];
        _attendeeIcon.image = [UIImage imageNamed:@"AttendeeActiveIcon"];
        _attendeeLabel.textColor = [UIColor colorWithRed:0 green:122.0/255.0 blue:1 alpha:1];
        _attendeeLabel.text = NSLocalizedString(@"Be the first", @"No attendees label for event");

        f = _slideBarContent.frame;
        f.size.height = 40;
        _slideBarContent.frame = f;
        f = _sliderBarView.frame;
        f.size.height = 40;
        _sliderBarView.frame = f;
        
        f = _joinButton.frame;
        f.size.height = 45;
        _joinButton.frame = f;
        _loadingIndicator.transform = CGAffineTransformIdentity;
        
    }
    
    f = _bottomSeparator.frame;
    f.size.height = 0.5;
    f.origin.y = 167.0+shift+shift2+0.5;
    _bottomSeparator.frame = f;
    f = _topSeparator.frame;
    f.size.height = 0.5;
    _topSeparator.frame = f;
    
    _eventTags.text = [hashes uppercaseString];
    _eventTags.transform = CGAffineTransformMakeTranslation(0, shift);
//    _bottomSeparator.transform = CGAffineTransformMakeTranslation(0, shift+shift2+0.5);
    _slideBarContent.transform = CGAffineTransformMakeTranslation(0, shift);
    _selectionView.frame = CGRectMake(0, 15, 320, 145+shift+shift2);
    
    NSString *imageUrlString = [@"http:" stringByAppendingString:[_event[@"image"][@"url"] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"640x150"]];
    // Download image for event
    [[NPCooleafClient sharedClient] fetchImage:imageUrlString completion:^(NSString *imagePath, UIImage *image) {
       if ([imagePath compare:imageUrlString] == NSOrderedSame)
       {
           _eventImage.image = image;
       }
    }];
}

- (IBAction)joinTapped:(id)sender
{
    if (_actionTapped)
    {
        if ([_event[@"attending"] boolValue])
        {
            UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Do you really want to resign?", nil)
                                                            delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                              destructiveButtonTitle:NSLocalizedString(@"Yes, I want to resign", nil) otherButtonTitles:nil];
            [as showInView:[UIApplication sharedApplication].keyWindow];
        }
        else if (_actionTapped(_event[@"id"], ![_event[@"attending"] boolValue]))
        {
            self.loading = YES;
        }
    }
}

- (void)panned:(UIPanGestureRecognizer *)rec
{
    if (rec.state == UIGestureRecognizerStateBegan)
    {
        _startingPoint = [rec locationInView:self.contentView];
    }
    else
    {
        CGPoint newPos = [rec locationInView:self.contentView];
        if (newPos.x < _startingPoint.x)
            _sliderBarView.transform = CGAffineTransformMakeTranslation(newPos.x - _startingPoint.x, 0);
        if (rec.state == UIGestureRecognizerStateCancelled ||
            rec.state == UIGestureRecognizerStateEnded ||
            rec.state == UIGestureRecognizerStateFailed)
        {
            self.contentView.userInteractionEnabled = NO;
            [UIView animateWithDuration:0.3 animations:^{
                if (_startingPoint.x - newPos.x > 70)
                {
                    _sliderBarView.transform = CGAffineTransformMakeTranslation(-100, 0);
                    _showsActionButton = YES;
                }
                else
                {
                    _sliderBarView.transform = CGAffineTransformIdentity;
                    _showsActionButton = NO;
                }
            } completion:^(BOOL finished) {
                _startingPoint = CGPointZero;
                self.contentView.userInteractionEnabled = YES;
            }];
            
        }
    }
    
}

- (void)setLoading:(BOOL)loading
{
    if (_loading == loading)
        return;
    
    _loading = loading;
    _joinButton.hidden = loading;
    if (_loading)
    {
        if (!_showsActionButton)
        {
            _sliderBarView.transform = CGAffineTransformMakeTranslation(-100, 0);
            _showsActionButton = YES;            
        }
        [_loadingIndicator startAnimating];
    }
    else
    {
        [_loadingIndicator stopAnimating];
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
//    if ([otherGestureRecognizer isKindOfClass:[TISidebarGestureRecognizer class]] && (_startingPoint.x != 0 || _showsActionButton))
//        return NO;
    return YES; //otherGestureRecognizer is your custom pan gesture
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer*)gestureRecognizer translationInView:self.superview];
        if (translation.x > 2 || translation.x < -2 || _showsActionButton) {
            return YES;
        }
        
        return NO;
    }
    
    return YES;
}

- (void)closeDrawer
{
    self.contentView.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _sliderBarView.transform = CGAffineTransformIdentity;
        _showsActionButton = NO;
    } completion:^(BOOL finished) {
        _startingPoint = CGPointZero;
        self.contentView.userInteractionEnabled = YES;
    }];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        self.loading = YES;
        _actionTapped(_event[@"id"], NO);
    }
    else
    {
        [self closeDrawer];
    }
}

+ (CGFloat)cellHeightForEvent:(NSDictionary *)event
{
    if (!_tV)
        _tV =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    else
        _tV.frame = CGRectMake(0, 0, 320, 20);
    
    _tV.font = [UIFont boldSystemFontOfSize:22.0];
    _tV.text = event[@"name"];
    [_tV sizeToFit];
    
    CGFloat titleHeight = _tV.frame.size.height;
    CGFloat shift = ([event[@"participants"] count] > 0) ? 45 : -9;
    
    return 160 + (titleHeight-39) + shift;
}

@end
