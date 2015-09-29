//
//  CLLoadedEventComments.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedEventComments : NSObject

@property (nonatomic, assign) NSMutableArray *comments;

- (id)initWithComments:(NSMutableArray *)comments;

@end
