//
//  NSFileManager+ImageCaching.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 16.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (ImageCaching)

- (NSURL *)cacheDirectory;
- (NSString *)temporaryFilenameWithExtension:(NSString *)extension;

@end
