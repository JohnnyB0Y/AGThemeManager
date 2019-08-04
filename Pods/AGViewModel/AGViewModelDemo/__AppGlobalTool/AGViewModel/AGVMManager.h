//
//  AGVMManager.h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  

#import "AGVMProtocol.h"
#import "AGVMSection.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - interface
@interface AGVMManager : NSObject
<NSCopying, NSMutableCopying, NSSecureCoding, AGVMJSONTransformable>

@property (nonatomic, strong, readonly) NSMutableArray<AGVMSection *> *sectionArrM;
@property (nonatomic, assign, readonly) NSInteger count;

@property (nonatomic, strong, nullable) AGViewModel *cvm; ///< common viewModel
@property (nonatomic, weak, readonly, nullable) AGVMSection *fs; ///< first section
@property (nonatomic, weak, readonly, nullable) AGVMSection *ls; ///< last section

#pragma mark - Quickly create vmm
/**
 Quickly create vmm

 @param capacity sectionArrM 每次增量拷贝的内存大小
 @return vmm
 */
+ (instancetype) newWithSectionCapacity:(NSInteger)capacity;
- (instancetype) initWithSectionCapacity:(NSInteger)capacity NS_DESIGNATED_INITIALIZER;

#pragma mark - 自己拼装数据 （不用担心循环引用问题）
/**
 拼装 section 数据
 
 @param block 传递 section 的 block
 @param capacity section 中 itemArr 每次增量拷贝的内存大小
 @return section对象
 */
- (AGVMSection *) ag_packageSection:(NS_NOESCAPE AGVMPackageSectionBlock)block
						   capacity:(NSInteger)capacity;

/**
 拼装 section 数据
 
 @param block 传递 section 的 block
 @return section对象
 */
- (AGVMSection *) ag_packageSection:(NS_NOESCAPE AGVMPackageSectionBlock)block;

/**
 通过 packager 拼装 section 数据
 
 @param items 一组数据
 @param packager 遵守AGVMPackagable的对象
 @param obj 传入的对象
 @return section对象
 */
- (AGVMSection *) ag_packageSectionItems:(NSArray *)items
								packager:(id<AGVMPackagable>)packager
							   forObject:(nullable id)obj;

/**
 拼装多条 section 数据 （每条 section 中 itemArr 每次增量拷贝的内存大小为15）
 
 @param sections 多组数据
 @param block 拼装block
 @return manager对象
 */
- (AGVMManager *) ag_packageSections:(NSArray *)sections
							 inBlock:(NS_NOESCAPE AGVMPackageSectionsBlock)block;


/**
 拼装多条 section 数据
 
 @param sections 多组数据
 @param block 拼装block
 @param capacity 每条 section 中 itemArr 每次增量拷贝的内存大小
 @return manager对象
 */
- (AGVMManager *) ag_packageSections:(NSArray *)sections
							 inBlock:(NS_NOESCAPE AGVMPackageSectionsBlock)block
							capacity:(NSInteger)capacity;

/**
 打包公共数据
 
 @param package 打包block
 @param capacity 字典每次增量拷贝的内存大小
 @return 打包好的 View Model
 */
- (AGViewModel *) ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package
							  capacity:(NSInteger)capacity;

/**
 打包公共数据
 
 @param package 打包block
 @return 打包好的 View Model
 */
- (AGViewModel *) ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package;


#pragma mark - 修改数据
#pragma mark 添加
- (void) ag_addSection:(AGVMSection *)section;
- (void) ag_addSectionsFromManager:(AGVMManager *)vmm;
- (void) ag_addSectionsFromArray:(NSArray<AGVMSection *> *)sections;

#pragma mark 插入
- (void) ag_insertSection:(AGVMSection *)section
                  atIndex:(NSInteger)index;

- (void) ag_insertSectionsFromManager:(AGVMManager *)vmm
                              atIndex:(NSInteger)index;

- (void) ag_insertSectionsFromArray:(NSArray<AGVMSection *> *)vmsArr
                            atIndex:(NSInteger)index;

- (void) ag_insertSectionPackage:(NS_NOESCAPE AGVMPackageSectionBlock)package
                         atIndex:(NSInteger)index;

- (void) ag_insertSectionPackage:(NS_NOESCAPE AGVMPackageSectionBlock)package
                         atIndex:(NSInteger)index
                        capacity:(NSInteger)capacity;

#pragma mark 移除
- (void) ag_removeLastSection;
- (void) ag_removeAllSections;
- (void) ag_removeSectionAtIndex:(NSInteger)index;
- (void) ag_removeSectionsUsingBlock:(BOOL(NS_NOESCAPE^)(AGVMSection *vm, NSUInteger idx, BOOL *stop))block;
- (void) ag_removeSectionItemsUsingBlock:(BOOL(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;
- (void) ag_removeSectionItemsWithOptions:(NSEnumerationOptions)opts usingBlock:(BOOL(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;

#pragma mark 合并
/** 合并 commonVM、sectionArrM */
- (void) ag_mergeFromManager:(AGVMManager *)vmm;

#pragma mark 更新
- (void) setObject:(AGVMSection *)vms atIndexedSubscript:(NSInteger)idx;

- (void) ag_makeSectionsItemsRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;
- (void) ag_makeSectionsHeaderFooterRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;

- (void) ag_makeSectionsItemsSetNeedsCachedBindingViewSize;
- (void) ag_makeSectionsHeaderFooterSetNeedsCachedBindingViewSize;

- (void) ag_makeSectionsItemsSetNeedsRefreshUI;
- (void) ag_makeSectionsHeaderFooterSetNeedsRefreshUI;

- (void) ag_makeSectionsPerformSelector:(SEL)aSelector;
- (void) ag_makeSectionsPerformSelector:(SEL)aSelector withObject:(nullable id)argument;

- (void) ag_makeSectionsIfInRange:(NSRange)range performSelector:(SEL)aSelector;
- (void) ag_makeSectionsIfInRange:(NSRange)range performSelector:(SEL)aSelector withObject:(nullable id)argument;

#pragma mark 取出
- (nullable AGVMSection *) objectAtIndexedSubscript:(NSInteger)idx;

#pragma mark 交换
- (void) ag_exchangeSectionAtIndex:(NSInteger)idx1 withSectionAtIndex:(NSInteger)idx2;

#pragma mark 替换
- (void) ag_replaceSectionAtIndex:(NSInteger)index withSection:(AGVMSection *)section;

#pragma mark 遍历
/** 遍历所有 section */
- (void) ag_enumerateSectionsUsingBlock:(void(NS_NOESCAPE^)(AGVMSection *vms, NSUInteger idx, BOOL *stop))block;

/** 遍历 Range内的所有section */
- (void) ag_enumerateSectionsIfInRange:(NSRange)range usingBlock:(void(NS_NOESCAPE^)(AGVMSection *vms, NSUInteger idx, BOOL *stop))block;

/** 遍历所有 section 的 item */
- (void) ag_enumerateSectionsItemUsingBlock:(void(NS_NOESCAPE^)(AGViewModel *vm, NSIndexPath *indexPath, BOOL *stop))block;

/** 遍历所有 section 的 header、footer vm */
- (void) ag_enumerateSectionsHeaderFooterUsingBlock:(void(NS_NOESCAPE^)(AGViewModel *vm, NSIndexPath *indexPath, BOOL *stop))block;


#pragma mark 归档持久化相关
/** 添加到支持 归档(NSKeyedArchiver)、转Json字符串当中的 Key。*/
- (void) ag_addArchivedCommonVMKey:(NSString *)key;
- (void) ag_addArchivedSectionArrMKey:(NSString *)key;

/** 添加到支持 归档(NSKeyedArchiver)、转Json字符串当中的 Key，使用类内置的key */
- (void) ag_addAllArchivedObjectUseDefaultKeys;

/** 移除要归档和转字符串的 keys */
- (void) ag_removeArchivedCommonVMKey;
- (void) ag_removeArchivedSectionArrMKey;
- (void) ag_removeAllArchivedObjectKeys;


// ...
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
