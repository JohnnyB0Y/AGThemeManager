//
//  NSFileManager+AGFolderPath.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2019/1/23.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSFileManager+AGFolderPath.h"

@implementation NSFileManager (AGFolderPath)

- (NSString *) ag_dirPathOfDocument
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *) ag_dirPathOfPreferences
{
    NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
    return [libraryPath stringByAppendingPathComponent:@"Preferences"];
}

- (NSString *) ag_dirPathOfCaches
{
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *) ag_dirPathOfLibrary
{
    return [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
}

- (NSString *) ag_dirPathOfTemporary
{
    return NSTemporaryDirectory();
}

@end
