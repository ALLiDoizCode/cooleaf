//
//  CLTagPresenters.m
//  Cooleaf
//
//  Created by Jonathan Green on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLTagPresenters.h"

@implementation CLTagPresenters {
    
@private
    id <Tag> _tag;
    
}

@synthesize tag = _tag;

-(CLTagPresenters *)initWithTag:(id <Tag>)tag {
    
    if (self = [super init]) {
        
        _tag = tag;
    }
    
    return self;

}

///Protocols

#pragma setTagId

-(void)setTagId:(NSUInteger *)tagId {
    
}

#pragma setISDefault

-(void)setISDefault:(BOOL)isDefault {
    
}

#pragma setISActive

-(void)setISActive:(BOOL)isActive {
    
}

#pragma setTagName

-(void)setTagName:(NSString *)name{
    
}

#pragma setParentId

-(void)setParentId:(NSUInteger *)parentId{
    
}

#pragma setParentType

-(void)setParentType:(NSString *)parentType{
    
}

#pragma setType

-(void)setType:(NSString *)tagType{
    
}

@end
