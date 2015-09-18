//
//  CLBaseNotificationRegistry.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLBaseNotificationRegistry.h"
#import "CLBaseSubscriber.h"
#import "CLAuthenticationSubscriber.h"
#import "CLInterestSubscriber.h"
#import "CLEventSubscriber.h"
#import "CLUserSubscriber.h"
#import "CLSearchSubscriber.h"
#import "CLGroupSubscriber.h"

@implementation CLBaseNotificationRegistry

# pragma mark - init

- (id)init {
    _eventBus = [CLBus sharedInstance];
    _defaultNotificationSubscribers = [NSMutableArray array];
    _notificationSubscribers = [[NSMapTable alloc] init];
    _notificationSubscribers = [NSMapTable mapTableWithKeyOptions:NSMapTableStrongMemory
                                                     valueOptions:NSMapTableWeakMemory];
    return self;
}

# pragma mark - Singleton

+ (CLBaseNotificationRegistry *)getInstance {
    static CLBaseNotificationRegistry *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

# pragma mark - registerDefaultSubscribers

- (void)registerDefaultSubscribers {
    [_defaultNotificationSubscribers removeAllObjects];
    [_defaultNotificationSubscribers addObjectsFromArray:[self createDefaultSubscribers]];
    for (id<CLNotificationSubscriber> subscriber in _defaultNotificationSubscribers) {
        [self registerSubscriber:subscriber];
    }
}

# pragma mark - unregisterDefaultSubscribers

- (void)unregisterDefaultSubscribers {
    for (CLBaseSubscriber *subscriber in _defaultNotificationSubscribers) {
        [subscriber unregisterOnBus:_eventBus];
    }
    [_notificationSubscribers removeAllObjects];
}

# pragma mark - registerSubscriber

- (void)registerSubscriber:(id<CLNotificationSubscriber>)subscriber {
    if ([_notificationSubscribers objectForKey:subscriber]) {
        return;
    }
    NSObject *registeredSubscriber = [subscriber registerOnBus:_eventBus];
    [_notificationSubscribers setObject:registeredSubscriber forKey:subscriber];
}

# pragma mark - unregisterSubscriber

- (void)unregisterSubscriber:(NSObject *)subscriber {
    if (![_notificationSubscribers objectForKey:subscriber])
        return;
    CLBaseSubscriber *visitor = [_notificationSubscribers objectForKey:subscriber];
    [visitor unregisterOnBus:_eventBus];
    [_notificationSubscribers removeObjectForKey:subscriber];
}

# pragma mark - createDefaultSubscribers

- (NSMutableArray *)createDefaultSubscribers {
    NSMutableArray *defaultSubscribers = [NSMutableArray array];
    CLAuthenticationSubscriber *authenticationSubcriber = [[CLAuthenticationSubscriber alloc] init];
    CLInterestSubscriber *interestSubscriber = [[CLInterestSubscriber alloc] init];
    CLEventSubscriber *eventSubscriber = [[CLEventSubscriber alloc] init];
    CLUserSubscriber *userSubscriber = [[CLUserSubscriber alloc] init];
    CLSearchSubscriber *searchSubscriber = [[CLSearchSubscriber alloc] init];
    CLGroupSubscriber *groupSubscriber = [[CLGroupSubscriber alloc] init];
    [defaultSubscribers addObject:authenticationSubcriber];
    [defaultSubscribers addObject:interestSubscriber];
    [defaultSubscribers addObject:eventSubscriber];
    [defaultSubscribers addObject:userSubscriber];
    [defaultSubscribers addObject:searchSubscriber];
    [defaultSubscribers addObject:groupSubscriber];
    return defaultSubscribers;
}

@end