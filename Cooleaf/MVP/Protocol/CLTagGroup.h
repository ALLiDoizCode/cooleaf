//
//  CLTagGroup.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

@protocol TagGroup <NSObject>

-(void)setTagGroupId:(NSUInteger *)tagGroupID;
-(void)setTagGroupName:(NSString *)tagGroupName;
-(void)setIsPrimary:(BOOL)isPrimary;
-(void)setIsRequired:(BOOL)isRequired;
-(void)setTags:(NSArray *)tags;
-(void)setTagsByName:(NSDictionary *)tagsByName;

@end