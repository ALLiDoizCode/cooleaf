//
//  CLInterestPresenter.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IntrestInfo;

@interface CLInterestPresenter : NSObject
@property(nonatomic, strong) id<IntrestInfo> intrestInfo;

-(CLInterestPresenter *)initWithIntrestInfo:(id <IntrestInfo>)intrestInfo;

-(void)setIntrestId:(NSInteger *)intrestId;
-(void)setParentId:(NSInteger *)parentId;
-(void)setParentType:(NSString *)parentType;
-(void)setIntrestName:(NSString *)intrestName;
-(void)setIsActive:(BOOL)isActive;
-(void)setIsMember:(BOOL)isMember;
-(void)setIsDefault:(BOOL)isDefault;
-(void)setImagePath:(NSString *)imagePath;
-(void)setImageURL:(NSString *)imageURL;
-(void)setThumbnailPath:(NSString *)thumbnail;
-(void)setThumbnailURL:(NSString *)thumbnailURL;
-(void)setSlug:(NSString *)slug;
-(void)setType:(NSString *)intrestType;
-(void)setUserCount:(NSInteger *)userCount;

@end
