//
//  NPCooleafClient.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

extern NSString * const kNPCooleafClientRefreshNotification;
extern NSString * const kNPCooleafClientRUDIDHarvestedNotification;
extern NSString * const kNPCooleafClientSignOut;

@interface NPCooleafClient : AFHTTPRequestOperationManager

@property (nonatomic, readonly) NSDictionary *userData;
@property (nonatomic, setter = setNotificationUDID:) NSString *notificationUDID;

+ (NPCooleafClient *)sharedClient;

- (AFHTTPRequestOperation *)loginWithUsername:(NSString *)username password:(NSString *)password  completion:(void(^)(NSError *error))completion;

- (AFHTTPRequestOperation *)joinEventWithId:(NSNumber *)eventId completion:(void(^)(NSError *error))completion;

- (AFHTTPRequestOperation *)leaveEventWithId:(NSNumber *)eventId completion:(void(^)(NSError *error))completion;

- (AFHTTPRequestOperation *)fetchEventWithId:(NSNumber *)eventId completion:(void(^)(NSDictionary *eventDetails))completion;

- (AFHTTPRequestOperation *)fetchParticipantsForEventWithId:(NSNumber *)eventId completion:(void(^)(NSArray *participants))completion;

- (AFHTTPRequestOperation *)addTodoForWidget:(NSNumber *)widgetId name:(NSString *)name completion:(void(^)(NSError *error))completion;

- (AFHTTPRequestOperation *)markTodo:(NSNumber *)todoId asDone:(BOOL)done completion:(void(^)(NSError *error))completion;

- (void)logout;

- (void)fetchEventList:(void(^)(NSArray *events))completion;

- (void)fetchInterestList:(void(^)(NSArray *events))completion;

- (void)fetchImage:(NSString *)imagePath completion:(void(^)(NSString *imagePath, UIImage *image))completion;

- (void)checkEndpoints;
@end
