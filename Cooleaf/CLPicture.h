//
//  NPPicture.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLVersions.h"

@interface CLPicture : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *originalUrl;
@property (nonatomic, copy) CLVersions *versions;

@end
