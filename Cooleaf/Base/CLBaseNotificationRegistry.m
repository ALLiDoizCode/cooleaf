//
//  CLBaseNotificationRegistry.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLBaseNotificationRegistry.h"

@implementation CLBaseNotificationRegistry

# pragma init

- (id)init {
    _eventBus = [CLBus sharedInstance];
    _defaultNotificationSubscribers = [NSMutableArray array];
    _notificationSubscribers = [[NSMapTable alloc] init];
    _notificationSubscribers = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                                     valueOptions:NSMapTableWeakMemory];
    return self;
}


# pragma Singleton

+ (CLBaseNotificationRegistry *)getInstance {
    static CLBaseNotificationRegistry *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}


# pragma registerDefaultSubscribers

- (void)registerDefaultSubscribers {
    NSLog(@"initializing subscribers");
    [_defaultNotificationSubscribers removeAllObjects];
    [_defaultNotificationSubscribers addObjectsFromArray:[self createDefaultSubscribers]];
    for (id<CLNotificationSubscriber> subscriber in _defaultNotificationSubscribers) {
        [self registerSubscriber:subscriber];
    }
}


# pragma unregisterDefaultSubscribers

- (void)unregisterDefaultSubscribers {
    NSLog(@"unregistering all subscribers");
    for (CLBaseSubscriber *subscriber in _defaultNotificationSubscribers) {
        [subscriber unregisterOnBus:_eventBus];
    }
    [_notificationSubscribers removeAllObjects];
}


# pragma registerSubscriber

- (void)registerSubscriber:(id<CLNotificationSubscriber>)subscriber {
    NSLog(@"registering subscriber");
    if ([_notificationSubscribers objectForKey:subscriber]) {
        return;
    }
    NSObject *registeredSubscriber = [subscriber registerOnBus:_eventBus];
    [_notificationSubscribers setObject:registeredSubscriber forKey:subscriber];
}


# pragma unregisterSubscriber

- (void)unregisterSubscriber:(NSObject *)subscriber {
    if (![_notificationSubscribers objectForKey:subscriber])
        return;
    CLBaseSubscriber *visitor = [_notificationSubscribers objectForKey:subscriber];
    [visitor unregisterOnBus:_eventBus];
    [_notificationSubscribers removeObjectForKey:subscriber];
}


# pragma createDefaultSubscribers

- (NSMutableArray *)createDefaultSubscribers {
    NSMutableArray *defaultSubscribers = [NSMutableArray array];
    CLAuthenticationSubscriber *authenticationSubcriber = [[CLAuthenticationSubscriber alloc] init];
    CLInterestSubscriber *interestSubscriber = [[CLInterestSubscriber alloc] init];
    CLEventSubscriber *eventSubscriber = [[CLEventSubscriber alloc] init];
    CLUserSubscriber *userSubscriber = [[CLUserSubscriber alloc] init];
    [defaultSubscribers addObject:authenticationSubcriber];
    [defaultSubscribers addObject:interestSubscriber];
    [defaultSubscribers addObject:eventSubscriber];
    [defaultSubscribers addObject:userSubscriber];
    return defaultSubscribers;
}

@end