//
//  NSBundle+AGSupportCocoapods.m
//
//
//  Created by JohnnyB0Y on 2018/12/6.
//  Copyright © 2018 JohnnyB0Y. All rights reserved.
//

#import "NSBundle+AGSupportCocoapods.h"

@implementation NSBundle (AGSupportCocoapods)

+ (NSBundle *) ag_cocoapodsBundleForClass:(Class)aClass
{
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    NSURL *url = [bundle URLForResource:@"MyLibrary" withExtension:@"bundle"];
    if ( url == nil ) {
        url = [bundle URLForResource:@"ResourceFramework" withExtension:@"bundle"];
    }
    if ( url ) {
        bundle = [NSBundle bundleWithURL:url];
    }
    return bundle;
}

+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name
{
    return [self ag_bundleForClass:aClass
                      withResource:name
                     withExtension:@"bundle"];
}

+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name
                   withExtension:(NSString *)ext
{
    return [self ag_bundleForClass:aClass
                      withResource:name
                     withExtension:ext
                             error:nil];
}

+ (NSBundle *) ag_bundleForClass:(Class)aClass
                    withResource:(NSString *)name
                   withExtension:(NSString *)ext
                           error:(NSError **)error
{
    NSBundle *bundle = [NSBundle bundleForClass:aClass];
    
    if ( bundle == nil ) {
        NSString *msg = [NSString stringWithFormat:@"Bundle for %@ not found.", NSStringFromClass(aClass)];
        *error = [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":msg}];
        return bundle;
    }
    
    NSURL *url = [bundle URLForResource:name withExtension:ext];
    
    if ( url ) {
        bundle = [NSBundle bundleWithURL:url];
    }
    else {
        NSString *msg = [NSString stringWithFormat:@"%@.%@ not found.", name, ext];
        *error = [NSError errorWithDomain:NSCocoaErrorDomain code:404 userInfo:@{@"msg":msg}];
    }
    
    return bundle;
}

@end
