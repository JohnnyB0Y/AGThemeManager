//
//  AGVMSharedPackager.h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/9.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  View Model 包装者

#import "AGViewModel.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - @interface
@interface AGVMSharedPackager : NSObject

@property (class, readonly) AGVMSharedPackager *sharedInstance;

- (NSArray<AGViewModel *> *) ag_packageDatas:(nullable NSArray *)datas
                                     mergeVM:(nullable AGViewModel *)mergeVM
                                     inBlock:(nullable NS_NOESCAPE AGVMPackageDatasBlock)block
                                    capacity:(NSInteger)capacity;

/**
 组装 ViewModel
 
 @param package 赋值数据的 Block
 @param mergeVM 打包的共同数据模型
 @param capacity 字典每次增量拷贝的内存大小
 @return ViewModel
 */
- (AGViewModel *) ag_packageData:(nullable NS_NOESCAPE AGVMPackageDataBlock)package
                         mergeVM:(nullable AGViewModel *)mergeVM
                        capacity:(NSInteger)capacity;

/**
 组装 ViewModel

 @param package 赋值数据的 Block
 @param capacity 字典每次增量拷贝的内存大小
 @return ViewModel
 */
- (AGViewModel *) ag_packageData:(nullable NS_NOESCAPE AGVMPackageDataBlock)package
                        capacity:(NSInteger)capacity;

/**
 组装 ViewModel, 字典每次增量拷贝的内存大小为 6.
 
 @param package 赋值数据的 Block
 @return ViewModel
 */
- (AGViewModel *) ag_packageData:(nullable NS_NOESCAPE AGVMPackageDataBlock)package;

/**
 分解打印 JSON 为常量。（嵌套支持）
 
 @param object 待分解的字典或数组
 @param moduleName 模块的名称
 */
- (void) ag_resolveStaticKeyFromObject:(id)object
                            moduleName:(NSString *)moduleName;


// ...
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
