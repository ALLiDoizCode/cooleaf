//
//  CLSearchSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchSubscriber.h"
#import "CLSearchController.h"
#import "CLLoadQueryEvent.h"
#import "CLLoadedQueryEvent.h"
#import "CLQuery.h"

@interface CLSearchSubscriber() {
    @private
    CLSearchController *_searchController;
}

@end

@implementation CLSearchSubscriber

# pragma mark - init

- (id)init {
    _searchController = [[CLSearchController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLLoadQueryEvent) {
    
    NSDictionary *params = nil;
    
    if ([event.scope isEqualToString:@""]) {
        params = @{
                   @"query": event.query,
                   @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                   @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                   };
    } else {
        params = @{
                   @"query": event.query,
                   @"scope": event.scope,
                   @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                   @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                   };
    }
    
    [_searchController executeQuery:params success:^(id JSON) {
        NSMutableArray *results = [JSON result];
        CLLoadedQueryEvent *loadedQuery = [[CLLoadedQueryEvent alloc] initWithResults:results];
        PUBLISH(loadedQuery);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
