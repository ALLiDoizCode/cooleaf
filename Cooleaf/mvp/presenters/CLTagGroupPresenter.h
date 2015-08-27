//
//  CLTagGroupPresenter.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TagGroup;

@interface CLTagGroupPresenter : NSObject
@property(nonatomic, strong) id<TagGroup> tagGroup;

-(CLTagGroupPresenter *)initWithAddUserInfo:(id <TagGroup>)tagGroup;

-(void)setTagGroupId:(NSUInteger *)tagGroupID;
-(void)setTagGroupName:(NSString *)tagGroupName;
-(void)setIsPrimary:(BOOL)isPrimary;
-(void)setIsRequired:(BOOL)isRequired;
-(void)setTags:(NSArray *)tags;
-(void)setTagsByName:(NSDictionary *)tagsByName;

@end
