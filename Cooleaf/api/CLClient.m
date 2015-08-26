//
//  NPClient.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLClient.h"

static NSString *const API_URL = @"http://testorg.staging.do.cooleaf.monterail.eu/api";

@implementation CLClient

#pragma Initialization

- (id)initWithBaseURL:(NSURL *)url {
    //NSURL *apiUrl = [NSURL URLWithString:API_URL];
    self = [super initWithBaseURL:[NSURL URLWithString:API_URL]];
    if (!self)
        return nil;
    
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    
    return self;
}


# pragma Singleton

+ (CLClient *)getInstance {
    static CLClient *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] initWithBaseURL:[NSURL URLWithString:API_URL]];
    });
    return _sharedInstance;
}


# pragma modelClassesByResourcePath

+ (NSDictionary *)modelClassesByResourcePath {
    return @{
             @"events/*": [CLEvent class],
             @"users/*": [CLUser class],
             @"interests/*": [CLInterest class]
             };
}


# pragma responseClassesByResourcePath

+ (NSDictionary *)responseClassesByResourcePath {
    return @{
             
             };
}

@end

