//
//  NSFileManager+AGFolderPath.h
//  AGCategories
//
//  Created by JohnnyB0Y on 2019/1/23.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (AGFolderPath)

/** iTunes 备份与恢复 */
- (NSString *) ag_dirPathOfDocument;

/** iTunes 备份与恢复，存用户偏好设置 */
- (NSString *) ag_dirPathOfPreferences;

/** iTunes 不会备份，存缓存文件 */
- (NSString *) ag_dirPathOfCaches;

/** Preferences 和 Caches 的父目录 */
- (NSString *) ag_dirPathOfLibrary;

/** iTunes 不会备份，存临时文件，操作系统会自动清空回收 */
- (NSString *) ag_dirPathOfTemporary;

@end

NS_ASSUME_NONNULL_END
