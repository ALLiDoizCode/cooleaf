//
//  NPRole.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLBranch.h"
#import "CLOrganization.h"
#import "CLDepartment.h"


@interface CLRole : MTLModel <MTLJSONSerializing>

@property (nonatomic, assign) BOOL isActive;
@property (nonatomic) NSString *rights;
@property (nonatomic) CLOrganization *organization;
@property (nonatomic) CLBranch *branch;
@property (nonatomic) CLDepartment *department;
@property (nonatomic, copy) NSMutableArray *structureTags;
@property (nonatomic, copy) NSDictionary *structures;

@end
