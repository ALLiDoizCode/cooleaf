//
//  CLInterestPresenter.m
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestPresenter.h"


@implementation CLInterestPresenter {
    
@private
    id <IntrestInfo> _intrestInfo;
    
}

@synthesize intrestInfo = _intrestInfo;

-(CLInterestPresenter *)initWithIntrestInfo:(id <IntrestInfo>)intrestInfo {
    
    if (self = [super init]) {
        
        _intrestInfo = intrestInfo;
    }
    
    return self;
}

///Protocols

#pragma setIntrestId

-(void)setIntrestId:(NSInteger *)intrestId {
    
}

#pragma setParentId

-(void)setParentId:(NSInteger *)parentId {
    
}

#pragma setParentType

-(void)setParentType:(NSString *)parentType {
    
}

#pragma setIntrestName

-(void)setIntrestName:(NSString *)intrestName {
    
}

#pragma setIsActive

-(void)setIsActive:(BOOL)isActive {
    
}

#pragma setIsMember

-(void)setIsMember:(BOOL)isMember {
    
}

#pragma setIsDefault

-(void)setIsDefault:(BOOL)isDefault {
    
}

#pragma setImagePath

-(void)setImagePath:(NSString *)imagePath {
    
}

#pragma setImageURL

-(void)setImageURL:(NSString *)imageURL {
    
}

#pragma setThumbnailPath

-(void)setThumbnailPath:(NSString *)thumbnail {
    
}

#pragma setThumbnailURL

-(void)setThumbnailURL:(NSString *)thumbnailURL {
    
}

#pragma setSlug

-(void)setSlug:(NSString *)slug {
    
}

#pragma setType

-(void)setType:(NSString *)intrestType {
    
}

#pragma setUserCount

-(void)setUserCount:(NSInteger *)userCount {
    
}


@end
