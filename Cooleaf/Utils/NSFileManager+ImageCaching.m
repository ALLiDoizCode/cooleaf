//
//  NSFileManager+ImageCaching.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 16.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NSFileManager+ImageCaching.h"

@implementation NSFileManager (ImageCaching)

- (NSURL *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                        inDomain:(NSSearchPathDomainMask)domainMask
             appendPathComponent:(NSString *)appendComponent
                           error:(NSError **)errorOut
{
    // Search for the path
    NSArray* paths = NSSearchPathForDirectoriesInDomains(
                                                         searchPathDirectory,
                                                         domainMask,
                                                         YES);
    if ([paths count] == 0)
    {
        // *** creation and return of error object omitted for space
        return nil;
    }
    
    // Normally only need the first path
    NSString *resolvedPath = [paths objectAtIndex:0];
    
    if (appendComponent)
    {
        resolvedPath = [resolvedPath
                        stringByAppendingPathComponent:appendComponent];
    }
    
    // Create the path if it doesn't exist
    NSError *error;
    BOOL success = [self
                    createDirectoryAtPath:resolvedPath
                    withIntermediateDirectories:YES
                    attributes:nil
                    error:&error];
    if (!success)
    {
        if (errorOut)
        {
            *errorOut = error;
        }
        return nil;
    }
    
    // If we've made it this far, we have a success
    if (errorOut)
    {
        *errorOut = nil;
    }
    return [NSURL fileURLWithPath:resolvedPath];
}

- (NSURL *)cacheDirectory
{
    NSString *executableName =
    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    NSError *error;
    NSURL *result =
    [self
     findOrCreateDirectory:NSCachesDirectory
     inDomain:NSUserDomainMask
     appendPathComponent:executableName
     error:&error];
    if (error)
    {
        NSLog(@"Unable to find or create application support directory:\n%@", error);
    }
    return result;
}

- (NSString *)temporaryFilenameWithExtension:(NSString *)extension
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    NSString *filename = [NSString stringWithFormat:@"%@.%@", (__bridge NSString *)string, extension];
    CFRelease(string);
    return filename;
}

@end
