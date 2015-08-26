//
//  NPClient.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "OVCHTTPRequestOperationManager.h"
#import "CLEvent.h"
#import "CLUser.h"
#import "CLInterest.h"

@interface CLClient : OVCHTTPRequestOperationManager

+ (CLClient *)getInstance;

@end

