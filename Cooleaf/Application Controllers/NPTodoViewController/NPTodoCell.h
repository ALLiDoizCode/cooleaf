//
//  NPTodoCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPTodoCell : UITableViewCell

@property (nonatomic, setter = setTodo:) NSDictionary *todo;

+ (CGFloat)cellHeightForTodo:(NSDictionary *)todo;

@end
