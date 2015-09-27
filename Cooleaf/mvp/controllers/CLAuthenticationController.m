//
//  CLAuthenticationController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationController.h"

@implementation CLAuthenticationController

# pragma authenticate

- (void)authenticate:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] POST:@"v2/authorize.json" parameters:params completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}

# pragma deauthenticate

- (void)deauthenticate:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    [[CLClient getInstance] POST:@"v2/deauthorize.json" parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        NSLog(@"%@", operation);
        NSLog(@"%@", response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Valid JSON is not returned therefore it throws an error, however status code is 200
        NSInteger statusCode = [[operation response] statusCode];
        if (statusCode == 200) {
            success(operation);
        } else {
            // Something else went wrong with network
            NSLog(@"%@", error);
            failure(error);
        }
    }];
}

@end
