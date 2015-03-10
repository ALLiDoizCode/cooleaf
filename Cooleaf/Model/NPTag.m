//
//  NPTag.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.09.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPTag.h"

@implementation NPTag

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	
	if (self) {
		_objectId = ((NSNumber *)dictionary[@"id"]).integerValue;
		_name = dictionary[@"name"];
		_isActive = ((NSNumber *)dictionary[@"active"]).boolValue;
		_isDefault = ((NSNumber *)dictionary[@"default"]).boolValue;
		_parentId = ((NSNumber *)dictionary[@"parent_id"]).integerValue;
		_parentType = dictionary[@"parent_type"];
		_type = dictionary[@"type"];
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@<%p>::{ objectId=%d, name=%@, isActive=%@, isDefault=%@, parentId=%d, parentType=%@, type=%@ }",
					NSStringFromClass(self.class), self,
					(int)_objectId, _name, NSStringFromBool(_isActive), NSStringFromBool(_isDefault), (int)_parentId, _parentType, _type];
}

@end
