//
//  NSFileManager+AGFolderOperation.h
//  AGCategories
//
//  Created by JohnnyB0Y on 2019/1/23.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSFileManager (AGFolderOperation)

#pragma mark 统计文件夹大小，指定忽略的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger) ag_sizeOfBitWithFolderPath :(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // bit

- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // byte

- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // KB

- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // MB

- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path
                                    ignore:(nullable NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // GB


#pragma mark 统计文件夹大小，指定包含的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger) ag_sizeOfBitWithFolderPath :(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // bit

- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // byte

- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // KB

- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // MB

- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path
                                   contain:(NSArray<NSString *> *)extensions
                                     error:(NSError **)error; // GB


#pragma mark 统计文件夹大小
- (NSUInteger) ag_sizeOfBitWithFolderPath :(NSString *)path error:(NSError **)error; // bit
- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path error:(NSError **)error; // byte
- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path error:(NSError **)error; // KB
- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path error:(NSError **)error; // MB
- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path error:(NSError **)error; // GB


#pragma mark 删除文件夹
- (void) ag_clearFolderWithPath:(NSString *)path error:(NSError **)error;

@end

NS_ASSUME_NONNULL_END
