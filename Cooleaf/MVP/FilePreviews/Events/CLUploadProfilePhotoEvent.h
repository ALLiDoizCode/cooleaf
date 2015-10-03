//
//  CLUploadPhotoEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUploadProfilePhotoEvent : NSObject

@property (nonatomic, strong) NSData *data;

- (id)initWithData:(NSData *)data;

@end
