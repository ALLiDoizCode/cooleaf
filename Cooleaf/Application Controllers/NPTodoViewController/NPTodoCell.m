//
//  NPTodoCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPTodoCell.h"
#import "NPCooleafClient.h"

@interface NPTodoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *checkbox;
@property (weak, nonatomic) IBOutlet UITextView *titleView;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;
@property (weak, nonatomic) IBOutlet UIView *topSeparator;

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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTodo:(NSDictionary *)todo
{
    _titleView.text = todo[@"name"];
    
    if ([todo[@"done"] boolValue])
    {
        if ([todo[@"user"][@"id"] compare:[NPCooleafClient sharedClient].userData[@"id"]] == NSOrderedSame)
        {
            _checkbox.image = [UIImage imageNamed:@"CheckboxChecked"];
        }
        else
        {
            _checkbox.image = [UIImage imageNamed:@"CheckboxCheckedDisabled"];
        }
    }
    else
    {
        _checkbox.image = [UIImage imageNamed:@"CheckboxUnchecked"];
    }
}


+ (CGFloat)cellHeightForTodo:(NSDictionary *)todo
{
    return 102;
}
@end
