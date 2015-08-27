//
//  CLTag.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

@protocol Tag <NSObject>

-(void)setTagId:(NSUInteger *)tagId;
-(void)setISDefault:(BOOL)isDefault;
-(void)setISActive:(BOOL)isActive;
-(void)setTagName:(NSString *)name;
-(void)setParentId:(NSUInteger *)parentId;
-(void)setParentType:(NSString *)parentType;
-(void)setType:(NSString *)tagType;

@end
