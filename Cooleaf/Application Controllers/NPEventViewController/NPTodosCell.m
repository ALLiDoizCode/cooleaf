//
//  NPTodosCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPTodosCell.h"
@interface NPTodosCell ()

@property (weak, nonatomic) IBOutlet UILabel *todosLabel;
@end

@implementation NPTodosCell

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
    self.separatorInset = UIEdgeInsetsMake(0, 320, 0, 0);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTodosCount:(NSUInteger)todosCount
{
    _todosCount = todosCount;
    if (_todosCount > 1)
        _todosLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld todo’s", nil), todosCount];
    else if (_todosCount == 0)
        _todosLabel.text = NSLocalizedString(@"No todo’s", nil);
    else
        _todosLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld todo", nil), todosCount];
}
@end
