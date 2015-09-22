//
//  CLLoadedEventParticipants.h
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedEventParticipants : NSObject

@property (nonatomic, assign) NSMutableArray *participants;

- (id)initWithParticipants:(NSMutableArray *)participants;

@end
