//
//  CLTagGroupPresenter.m
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLTagGroupPresenter.h"

@implementation CLTagGroupPresenter {
    
@private
    id <TagGroup> _tagGroup;
    
}

@synthesize tagGroup = _tagGroup;

-(CLTagGroupPresenter *)initWithTagGroup:(id <TagGroup>)tagGroup {
    
    if (self = [super init]) {
        
        _tagGroup = tagGroup;
    }
    
    return self;
}

///Protocols

#pragma setTagGroupId

-(void)setTagGroupId:(NSUInteger *)tagGroupID {
    
}

#pragma setTagGroupName

-(void)setTagGroupName:(NSString *)tagGroupName {
    
}

#pragma setIsPrimary

-(void)setIsPrimary:(BOOL)isPrimary {
    
}

#pragma setIsRequired

-(void)setIsRequired:(BOOL)isRequired {
    
}

#pragma setTags

-(void)setTags:(NSArray *)tags {
    
}

#pragma setTagsByName

-(void)setTagsByName:(NSDictionary *)tagsByName {
    
}


@end
