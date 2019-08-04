//
//  NSFileManager+AGFolderOperation.m
//  AGCategories
//
//  Created by JohnnyB0Y on 2019/1/23.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSFileManager+AGFolderOperation.h"

@implementation NSFileManager (AGFolderOperation)

#pragma mark 统计文件夹大小，指定忽略的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger) ag_sizeOfBitWithFolderPath :(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfByteWithFolderPath:path ignore:extensions error:error] * 8;
}
- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    NSString *filePath;
    NSDictionary *fileDict;
    BOOL isExist = NO;
    BOOL isDirectory = NO;
    BOOL isIgnore = NO;
    NSUInteger byteSize = 0;
    
    for ( NSString *subPath in [self subpathsAtPath:path] ) {
        
        // 忽略某些扩展名的文件
        for ( NSString *igonreExtension in extensions ) {
            isIgnore = [subPath hasSuffix:igonreExtension];
            if ( isIgnore ) break; // 找到-跳出
        }
        if ( isIgnore ) continue; // 略过
        
        // 继续
        filePath = [path stringByAppendingPathComponent:subPath];
        isExist = [self fileExistsAtPath:filePath isDirectory:&isDirectory];
        if ( isExist && isDirectory == NO ) {
            
            fileDict = [self attributesOfItemAtPath:filePath error:error];
            if ( nil == error ) {
                byteSize += [[fileDict objectForKey:NSFileSize] unsignedIntegerValue];
            }
        }
    }
    return byteSize;
}
- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}
- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfKiloByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}
- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path ignore:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfMegaByteWithFolderPath:path ignore:extensions error:error] / 1000.f;
}


#pragma mark 统计文件夹大小，指定包含的文件扩展名，extensions = @[@"txt", @"mp4"]
- (NSUInteger) ag_sizeOfBitWithFolderPath :(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfByteWithFolderPath:path contain:extensions error:error] * 8;
}
- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    NSString *filePath;
    NSDictionary *fileDict;
    BOOL isExist = NO;
    BOOL isDirectory = NO;
    BOOL isIgnore = YES;
    NSUInteger byteSize = 0;
    
    for ( NSString *subPath in [self subpathsAtPath:path] ) {
        
        // 统计指定扩展名的文件
        for ( NSString *containExtension in extensions ) {
            isIgnore = ! [subPath hasSuffix:containExtension];
            if ( NO == isIgnore ) break; // 找到-跳出
        }
        if ( isIgnore ) continue; // 略过
        
        // 继续
        filePath = [path stringByAppendingPathComponent:subPath];
        isExist = [self fileExistsAtPath:filePath isDirectory:&isDirectory];
        if ( isExist && isDirectory == NO ) {
            
            fileDict = [self attributesOfItemAtPath:filePath error:error];
            if ( nil == error ) {
                byteSize += [[fileDict objectForKey:NSFileSize] unsignedIntegerValue];
            }
        }
    }
    return byteSize;
}
- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}
- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfKiloByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}
- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path contain:(NSArray<NSString *> *)extensions error:(NSError **)error
{
    return [self ag_sizeOfMegaByteWithFolderPath:path contain:extensions error:error] / 1000.f;
}


#pragma mark 统计文件夹大小
- (NSUInteger) ag_sizeOfBitWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self ag_sizeOfBitWithFolderPath:path ignore:nil error:error];
}
- (NSUInteger) ag_sizeOfByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self ag_sizeOfByteWithFolderPath:path ignore:nil error:error];
}
- (double) ag_sizeOfKiloByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self ag_sizeOfKiloByteWithFolderPath:path ignore:nil error:error];
}
- (double) ag_sizeOfMegaByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self ag_sizeOfMegaByteWithFolderPath:path ignore:nil error:error];
}
- (double) ag_sizeOfGigaByteWithFolderPath:(NSString *)path error:(NSError **)error
{
    return [self ag_sizeOfGigaByteWithFolderPath:path ignore:nil error:error];
}


#pragma mark 删除文件夹
- (void) ag_clearFolderWithPath:(NSString *)path error:(NSError **)error
{
    NSString *dirPath;
    BOOL success = YES;
    
    NSArray *dirs = [self contentsOfDirectoryAtPath:path error:error];
    if ( error ) return;
    
    for ( NSString *dir in dirs ) {
        dirPath = [path stringByAppendingPathComponent:dir];
        success = [self removeItemAtPath:dirPath error:error];
        if ( success == NO || error ) return;
    }
}

@end
