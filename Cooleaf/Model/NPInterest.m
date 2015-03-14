//
//  NPInterest.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.13.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterest.h"
#import "NPCooleafClient.h"

@implementation NPInterest

- (id)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	
	if (self) {
		_objectId = ((NSNumber *)dictionary[@"id"]).integerValue;
		_parentId = ((NSNumber *)dictionary[@"parent_id"]).integerValue;
		_parentType = dictionary[@"parent_type"];
		_name = dictionary[@"name"];
		_isActive = ((NSNumber *)dictionary[@"active"]).boolValue;
		_isDefault = ((NSNumber *)dictionary[@"default"]).boolValue;
		_imagePath = dictionary[@"image"][@"path"];
		_imageUrl = dictionary[@"image"][@"url"];
		_thumbnailPath = dictionary[@"image_thumb"][@"path"];
		_thumbnailUrl = dictionary[@"image_thumb"][@"url"];
		_slug = dictionary[@"slug"];
		_type = dictionary[@"type"];
		_userCount = ((NSNumber *)dictionary[@"users_count"]).integerValue;
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@<%p>::{ objectId=%d, parentId=%d, parentType=%@, name=%@, isActive=%@, isDefault=%@, imagePath=%@, imageUrl=%@, thumbPath=%@, thumbUrl=%@, slug=%@, type=%@, userCount=%d }",
					NSStringFromClass(self.class), self,
					(int)_objectId, (int)_parentId, _parentType, _name, NSStringFromBool(_isActive), NSStringFromBool(_isDefault),
					_imagePath, _imageUrl, _thumbnailPath, _thumbnailUrl, _slug, _type, (int)_userCount];
}

- (void)image:(void (^)(UIImage*))completion
{
	NSString *urlString = [[@"http:" stringByAppendingString:_imageUrl] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"164x164"];
	
	[[NPCooleafClient sharedClient] fetchImage:urlString completion:^ (NSString *imagePath, UIImage *image) {
		completion(image);
	}];
}

- (void)thumbnail:(void (^)(UIImage*))completion
{
	
}

@end
