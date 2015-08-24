//
//  NPRole.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "NPBranch.h"
#import "NPOrganization.h"
#import "NPDepartment.h"

@interface NPRole : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL *isActive;
@property (nonatomic, copy) NSString *rights;
@property (nonatomic, copy) NPOrganization *organization;
@property (nonatomic, copy) NPBranch *branch;
@property (nonatomic, copy) NPDepartment *department;
@property (nonatomic, copy) NSMutableArray *structureTags;
@property (nonatomic, copy) NSDictionary *structures;

@end
