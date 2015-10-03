//
//  CLLoadedInterests.h
//  Cooleaf
//
//  Created by Haider Khan on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedInterests : NSObject

@property (nonatomic) NSMutableArray *interests;

- (id)initWithInterests:(NSMutableArray *)interests;

@end
