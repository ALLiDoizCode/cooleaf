//
//  NPDetailsCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPDetailsCell.h"

static UITextView *_tV = nil;

@interface NPDetailsCell ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation NPDetailsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetailsText:(NSString *)detailsText
{
    _detailsText = detailsText;
    _textView.text = detailsText;
    
    CGRect f = _textView.frame;
    [_textView sizeToFit];
    f.size.height = _textView.frame.size.height;
    _textView.frame = f;
    
}

+ (CGFloat)cellHeightForText:(NSString *)detailsText
{
    if (!_tV)
        _tV =[[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    else
        _tV.frame = CGRectMake(0, 0, 320, 20);
    
    _tV.font = [UIFont systemFontOfSize:15.0];
    _tV.text = detailsText;
    [_tV sizeToFit];
    
    return 50 + _tV.frame.size.height;
}

@end
