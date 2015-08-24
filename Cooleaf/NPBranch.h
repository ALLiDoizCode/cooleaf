//
//  NPBranch.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface NPBranch : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *branchName;
@property (nonatomic) BOOL *isDefault;

@end
