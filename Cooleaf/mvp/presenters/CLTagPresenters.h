//
//  CLTagPresenters.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Tag;

@interface CLTagPresenters : NSObject
@property(nonatomic, strong) id<Tag> tag;

-(CLTagPresenters *)initWithAddUserInfo:(id <Tag>)tag;

-(void)setTagId:(NSUInteger *)tagId;
-(void)setISDefault:(BOOL)isDefault;
-(void)setISActive:(BOOL)isActive;
-(void)setTagName:(NSString *)name;
-(void)setParentId:(NSUInteger *)parentId;
-(void)setParentType:(NSString *)parentType;
-(void)setType:(NSString *)tagType;

@end
