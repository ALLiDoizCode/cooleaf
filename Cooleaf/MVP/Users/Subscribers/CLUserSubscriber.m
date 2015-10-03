//
//  CLUserSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLUserSubscriber.h"
#import "CLLoadUsersEvent.h"
#import "CLLoadedUsersEvent.h"
#import "CLLoadMeEvent.h"
#import "CLLoadedMeEvent.h"
#import "CLUser.h"
#import "CLSaveUserInterestsEvent.h"
#import "CLSavedUserInterestsEvent.h"

@interface CLUserSubscriber() {
    @private
    CLUserController *_userController;
}

@end

@implementation CLUserSubscriber

# pragma mark - init

- (id)init {
    _userController = [[CLUserController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLLoadMeEvent) {
    [_userController getMe:nil success:^(id JSON) {
        CLUser *user = [JSON result];
        CLLoadedMeEvent *loadedMeEvent = [[CLLoadedMeEvent alloc] initWithUser:user];
        PUBLISH(loadedMeEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadUsersEvent) {
    // Load params
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_userController getUsers:params success:^(id JSON) {
        NSMutableArray *users = [JSON result];
        CLLoadedUsersEvent *loadedUsersEvent = [[CLLoadedUsersEvent alloc] initWithUsers:users];
        PUBLISH(loadedUsersEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLSaveUserInterestsEvent) {
    // Get values
    NSDictionary *userDict = (NSDictionary *) event.user;
    NSMutableArray *activeInterests = event.activeInterests;
    NSString *fileCache = event.fileCache;
    
    // Set the params
    NSDictionary *params = @{
                             @"name": userDict[@"name"],
                             @"email": userDict[@"email"],
                             @"category_ids": activeInterests,
                             @"file_cache": fileCache,
                             @"role": userDict[@"role"],
                             @"profile": userDict[@"profile"]
                             };
    
    [_userController saveUserInterests:params success:^(id JSON) {
        CLUser *user = [JSON result];
        CLSavedUserInterestsEvent *savedUserInterestsEvent = [[CLSavedUserInterestsEvent alloc] initWithUser:user];
        PUBLISH(savedUserInterestsEvent);
    } failure:^(NSError *error) {
        NSString *errorMessage = [error localizedDescription];
        [self showUpdateProfileErrorAlert:errorMessage];
    }];
}

# pragma mark - Accessory Methods

- (void)showUpdateProfileErrorAlert:(NSString *)errorMessage {
    [[[UIAlertView alloc] initWithTitle:@"Update Failed" message:@"Something went wrong while updating your profile." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}


@end