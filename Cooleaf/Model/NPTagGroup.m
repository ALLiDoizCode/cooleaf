//
//  NPTagGroup.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.09.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPTagGroup.h"
#import "NPTag.h"

@interface NPTagGroup() {
	NSMutableArray *_tags;
	NSMutableDictionary *_tagsByName;
}
@end

@implementation NPTagGroup

- (id)initWithDictionary:(NSDictionary *)dictionary {
	self = [super init];
	
	if (self) {
		_objectId = ((NSNumber *)dictionary[@"id"]).integerValue;
		_name = dictionary[@"name"];
		_isPrimary = ((NSNumber *)dictionary[@"primary"]).boolValue;
		_isRequired = ((NSNumber *)dictionary[@"required"]).boolValue;
		
		_tags = [[NSMutableArray alloc] init];
		_tagsByName = [[NSMutableDictionary alloc] init];
		
		[(NSArray *)dictionary[@"tags"] enumerateObjectsUsingBlock:^ (NSDictionary *tag, NSUInteger index, BOOL *stop) {
			NPTag *nptag = [[NPTag alloc] initWithDictionary:tag];
			[_tags addObject:nptag];
			_tagsByName[nptag.name] = nptag;
		}];
	}
	
	return self;
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@<%p>::{ objectId=%d, name=%@, isPrimary=%@, isRequired=%@, tags.count=%d }",
					NSStringFromClass(self.class), self,
					(int)_objectId, _name, NSStringFromBool(_isPrimary), NSStringFromBool(_isRequired), (int)_tags.count];
}

@end
