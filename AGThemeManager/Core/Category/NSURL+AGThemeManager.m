//
//  NSURL+AGThemeManager.m
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSURL+AGThemeManager.h"
#import "AGThemeKit.h"

@implementation NSURL (AGThemeManager)

+ (NSURL *)ag_themeForKey:(NSString *)key
{
    NSURL *url = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    if ( [url isKindOfClass:[NSURL class]] ) {
        return url;
    }
    else if ( [url isKindOfClass:[NSString class]] ) {
        return [NSURL URLWithString:(NSString *)url];
    }
    
    return nil;
}

/// 获取当前主题URLStr
/// @param key 键
+ (nullable NSString *)ag_themeURLStrForKey:(NSString *)key
{
    NSURL *url = AGThemeManager.sharedInstance.themeCollection.currentPack[key];
    if ( [url isKindOfClass:[NSURL class]] ) {
        return url.absoluteString;
    }
    else if ( [url isKindOfClass:[NSString class]] ) {
        return (id)url;
    }
    
    return nil;
}

@end
