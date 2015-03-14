//
//  NPInterest.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.13.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPInterest : NSObject

@property (readonly,  nonatomic, assign) NSInteger objectId;
@property (readonly,  nonatomic, assign) NSInteger parentId;
@property (readonly,  nonatomic, retain) NSString *parentType;
@property (readonly,  nonatomic, retain) NSString *name;
@property (readwrite, nonatomic, assign) BOOL isActive;
@property (readonly,  nonatomic, assign) BOOL isDefault;
@property (readonly,  nonatomic, retain) NSString *imagePath;
@property (readonly,  nonatomic, retain) NSString *imageUrl;
@property (readonly,  nonatomic, retain) NSString *thumbnailPath;
@property (readonly,  nonatomic, retain) NSString *thumbnailUrl;
@property (readonly,  nonatomic, retain) NSString *slug;
@property (readonly,  nonatomic, retain) NSString *type;
@property (readonly,  nonatomic, assign) NSInteger userCount;

/**
 *
 * {
 *   active = 1;
 *   default = 1;
 *   id = 391;
 *   image =         {
 *     path = "/categories/adventure/adventure01-{{SIZE}}.jpg";
 *     url = "//d1hwvdpdzshhes.cloudfront.net/categories/adventure/adventure01-{{SIZE}}.jpg";
 *   };
 *   "image_thumb" =         {
 *     path = "/categories/adventure/adventure01-{{SIZE}}.jpg";
 *     url = "//d1hwvdpdzshhes.cloudfront.net/categories/adventure/adventure01-{{SIZE}}.jpg";
 *   };
 *   name = Adventure;
 *   "parent_id" = 1;
 *   "parent_type" = Category;
 *   slug = adventure;
 *   type = interest;
 *   "users_count" = 14;
 * }
 *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

/**
 *
 */
- (void)image:(void (^)(UIImage*))completion;
- (void)thumbnail:(void (^)(UIImage*))completion;

@end
