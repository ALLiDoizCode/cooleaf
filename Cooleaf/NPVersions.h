//
//  NPVersions.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface NPVersions : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *thumbUrl;
@property (nonatomic, copy) NSString *iconUrl;
@property (nonatomic, copy) NSString *smallUrl;
@property (nonatomic, copy) NSString *mediumUrl;
@property (nonatomic, copy) NSString *largeUrl;
@property (nonatomic, copy) NSString *bigUrl;
@property (nonatomic, copy) NSString *mainUrl;
@property (nonatomic, copy) NSString *coverUrl;

@end
