//
//  NPProfile.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "NPPicture.h"
#import "NPSettings.h"

@interface NPProfile : MTLModel<MTLJSONSerializing>

@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NPPicture *picture;
@property (nonatomic, copy) NPSettings *settings;

@end
