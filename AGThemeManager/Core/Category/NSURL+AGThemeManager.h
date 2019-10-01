//
//  NSURL+AGThemeManager.h
//  AGThemeManager
//
//  Created by JohnnyB0Y on 2019/9/30.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSURL (AGThemeManager)


/// 获取当前主题URL
/// @param key 键
+ (nullable NSURL *)ag_themeForKey:(NSString *)key;


/// 获取当前主题URLStr
/// @param key 键
+ (nullable NSString *)ag_themeURLStrForKey:(NSString *)key;


@end

NS_ASSUME_NONNULL_END
