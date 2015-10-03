//
//  CLParticipantPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IParticipantInteractor.h"

@interface CLParticipantPresenter : NSObject

@property (nonatomic, assign) id<IParticipantInteractor> participantInfo;

- (id)initWithInteractor:(id<IParticipantInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadEventParticipants:(NSInteger)eventId;

@end
