//
//  AGVMSection.h
//  
//
//  Created by JohnnyB0Y on 2017/7/10.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  一组 View Model 数据

#import "AGVMProtocol.h"
#import "AGViewModel.h"
#import "AGVMSharedPackager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGVMSection : NSObject
<NSCopying, NSMutableCopying, NSSecureCoding, AGVMJSONTransformable>

@property (nonatomic, strong, nullable) AGViewModel *headerVM;
@property (nonatomic, strong, nullable) AGViewModel *footerVM;

/** 将合并到 itemArr中的每个vm 中 */
@property (nonatomic, strong, nullable) AGViewModel *itemMergeVM;
@property (nonatomic, strong, readonly) NSMutableArray<AGViewModel *> *itemArrM;
@property (nonatomic, assign, readonly) NSInteger count;

@property (nonatomic, strong, nullable) AGViewModel *cvm; ///< common viewModel
@property (nonatomic, weak, readonly, nullable) AGViewModel *fvm; ///< first item viewModel
@property (nonatomic, weak, readonly, nullable) AGViewModel *lvm; ///< last item viewModel

/**
 Quickly create vms
 
 @param capacity itemArrM 每次增量拷贝的内存大小
 @return vms
 */
+ (instancetype) newWithItemCapacity:(NSInteger)capacity;
- (instancetype) initWithItemCapacity:(NSInteger)capacity NS_DESIGNATED_INITIALIZER;

#pragma mark - 通过 packager 拼装数据
/**
 通过 packager 拼装组头数据
 
 @param data 数据
 @param packager 遵守AGVMPackagable的对象
 @param obj 传入的对象
 @return headerVM
 */
- (AGViewModel *) ag_packageHeaderData:(NSDictionary *)data
							  packager:(id<AGVMPackagable>)packager
							 forObject:(nullable id)obj;

/**
 通过 packager 拼装 item 数据
 
 @param data 数据
 @param packager 遵守AGVMPackagable的对象
 @param obj 传入的对象
 @return viewModle对象
 */
- (AGViewModel *) ag_packageItemData:(NSDictionary *)data
							packager:(id<AGVMPackagable>)packager
						   forObject:(nullable id)obj;

/**
 通过 packager 拼装 一组item 数据
 
 @param items 一组数据
 @param packager 遵守AGVMPackagable的对象
 @param obj 传入的对象
 @return section对象
 */
- (AGVMSection *) ag_packageItems:(NSArray *)items
						 packager:(id<AGVMPackagable>)packager
						forObject:(nullable id)obj;

/**
 通过 packager 拼装组尾数据
 
 @param data 数据
 @param packager 遵守AGVMPackagable的对象
 @param obj 传入的对象
 @return footerVM
 */
- (AGViewModel *) ag_packageFooterData:(NSDictionary *)data
							  packager:(id<AGVMPackagable>)packager
							 forObject:(nullable id)obj;


#pragma mark - 自己拼装数据 （不用担心循环引用问题）
/**
 拼装组头数据
 
 @param package 存放数据的字典 Block
 @param capacity 数据字典每次增量拷贝的内存大小
 @return headerVM
 */
- (AGViewModel *) ag_packageHeaderData:(NS_NOESCAPE AGVMPackageDataBlock)package
							  capacity:(NSInteger)capacity;

/**
 拼装组头数据（数据字典每次增量拷贝的内存大小为6）
 
 @param package 存放数据的字典 Block
 @return headerVM
 */
- (AGViewModel *) ag_packageHeaderData:(NS_NOESCAPE AGVMPackageDataBlock)package;

/**
 拼装 item 数据
 
 @param package 存放数据的字典 Block
 @param capacity 数据字典每次增量拷贝的内存大小
 @return viewModel对象
 */
- (AGViewModel *) ag_packageItemData:(NS_NOESCAPE AGVMPackageDataBlock)package
							capacity:(NSInteger)capacity;

/**
 拼装 item 数据（数据字典每次增量拷贝的内存大小为6）
 
 @param package 存放数据的字典 Block
 @return viewModel对象
 */
- (AGViewModel *) ag_packageItemData:(NS_NOESCAPE AGVMPackageDataBlock)package;

/**
 拼装多条 item 数据
 
 @param items 一组数据
 @param block 存放数据的字典 Block
 @param capacity 每条 item 中 数据字典每次增量拷贝的内存大小
 @return section对象
 */
- (AGVMSection *) ag_packageItems:(NSArray *)items
						  inBlock:(NS_NOESCAPE AGVMPackageDatasBlock)block
						 capacity:(NSInteger)capacity;

/**
 拼装多条 item 数据（每条 item 中 数据字典每次增量拷贝的内存大小为6）
 
 @param items 一组数据
 @param block 存放数据的字典 Block
 @return section对象
 */
- (AGVMSection *) ag_packageItems:(NSArray *)items
						  inBlock:(NS_NOESCAPE AGVMPackageDatasBlock)block;

/**
 拼装组尾数据
 
 @param package 存放数据的字典 Block
 @param capacity 数据字典每次增量拷贝的内存大小
 @return footerVM
 */
- (AGViewModel *) ag_packageFooterData:(NS_NOESCAPE AGVMPackageDataBlock)package
							  capacity:(NSInteger)capacity;

/**
 拼装组尾数据（数据字典每次增量拷贝的内存大小为6）
 
 @param package 存放数据的字典 Block
 @return footerVM
 */
- (AGViewModel *) ag_packageFooterData:(NS_NOESCAPE AGVMPackageDataBlock)package;

/**
 拼装公共数据
 
 @param package 存放数据的字典 Block
 @param capacity 数据字典每次增量拷贝的内存大小
 @return commonVM
 */
- (AGViewModel *) ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package
							  capacity:(NSInteger)capacity;

/**
 拼装公共数据（数据字典每次增量拷贝的内存大小为6）
 
 @param package 存放数据的字典 Block
 @return commonVM
 */
- (AGViewModel *) ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package;

/**
 拼装 itemArr 中每个 viewModel 的合并数据模型
 
 @param package 存放数据的字典 Block
 @param capacity 数据字典每次增量拷贝的内存大小
 @return itemMergeVM
 */
- (AGViewModel *) ag_packageItemMergeData:(NS_NOESCAPE AGVMPackageDataBlock)package
								 capacity:(NSInteger)capacity;

/**
 拼装 itemArr 中每个 viewModel 的合并数据模型（数据字典每次增量拷贝的内存大小为6）
 
 @param package 存放数据的字典 Block
 @return itemMergeVM
 */
- (AGViewModel *) ag_packageItemMergeData:(NS_NOESCAPE AGVMPackageDataBlock)package;


#pragma mark - 增删改查
#pragma mark 新增
- (void) ag_addItem:(AGViewModel *)item;
- (void) ag_addItemsFromSection:(AGVMSection *)vms;
- (void) ag_addItemsFromArray:(NSArray<AGViewModel *> *)vmArr;

#pragma mark 插入
- (void) ag_insertItem:(AGViewModel *)item
               atIndex:(NSInteger)index;

- (void) ag_insertItemsFromSection:(AGVMSection *)vms
                           atIndex:(NSInteger)index;

- (void) ag_insertItemsFromArray:(NSArray<AGViewModel *> *)vmArr
                         atIndex:(NSInteger)index;

- (void) ag_insertItemPackage:(NS_NOESCAPE AGVMPackageDataBlock)package
                      atIndex:(NSInteger)index;

- (void) ag_insertItemPackage:(NS_NOESCAPE AGVMPackageDataBlock)package
                      atIndex:(NSInteger)index
                     capacity:(NSInteger)capacity;

#pragma mark 移除
- (void) ag_removeAllItems;
- (void) ag_removeLastItem;
- (void) ag_removeItem:(AGViewModel *)vm; //
- (void) ag_removeItemAtIndex:(NSInteger)index;
- (void) ag_removeItemsFromSection:(AGVMSection *)vms; //
- (void) ag_removeItemsFromArray:(NSArray<AGViewModel *> *)vmArr; //
- (void) ag_removeItemsUsingBlock:(BOOL(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;
- (void) ag_removeItemsWithOptions:(NSEnumerationOptions)opts usingBlock:(BOOL(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;

#pragma mark 更新
- (void) setObject:(AGViewModel *)vm atIndexedSubscript:(NSInteger)idx;

- (void) ag_makeItemsRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;
- (void) ag_makeHeaderFooterRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;

- (void) ag_makeItemsSetNeedsCachedBindingViewSize;
- (void) ag_makeHeaderFooterSetNeedsCachedBindingViewSize;

- (void) ag_makeItemsSetNeedsRefreshUI;
- (void) ag_makeHeaderFooterSetNeedsRefreshUI;

- (void) ag_makeItemsPerformSelector:(SEL)aSelector;
- (void) ag_makeItemsPerformSelector:(SEL)aSelector withObject:(nullable id)argument;

- (void) ag_makeItemsIfInRange:(NSRange)range performSelector:(SEL)aSelector;
- (void) ag_makeItemsIfInRange:(NSRange)range performSelector:(SEL)aSelector withObject:(nullable id)argument;

#pragma mark 取出
- (nullable AGViewModel *) objectAtIndexedSubscript:(NSInteger)idx;

#pragma mark 合并
/** 合并 headerVM、 footerVM、 commonVM、itemMergeVM、itemArr */
- (void) ag_mergeFromSection:(AGVMSection *)vms;

#pragma mark 交换
- (void) ag_exchangeItemAtIndex:(NSInteger)idx1 withItemAtIndex:(NSInteger)idx2;

#pragma mark 替换
- (void) ag_replaceItemAtIndex:(NSInteger)index withItem:(AGViewModel *)item;

#pragma mark 遍历
/** 遍历所有 item */
- (void) ag_enumerateItemsUsingBlock:(void(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;

/** 遍历 Range内的所有item */
- (void) ag_enumerateItemsIfInRange:(NSRange)range usingBlock:(void(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;

/** 遍历 header、footer vm */
- (void) ag_enumerateHeaderFooterUsingBlock:(void(NS_NOESCAPE^)(AGViewModel *vm, NSUInteger idx, BOOL *stop))block;


#pragma mark 归档持久化相关
/** 添加到支持 归档(NSKeyedArchiver)、转Json字符串当中的 Key。*/
- (void) ag_addArchivedCommonVMKey:(NSString *)key;
- (void) ag_addArchivedHeaderVMKey:(NSString *)key;
- (void) ag_addArchivedFooterVMKey:(NSString *)key;
- (void) ag_addArchivedItemArrMKey:(NSString *)key;

/** 添加到支持 归档(NSKeyedArchiver)、转Json字符串当中的 Key，使用类内置的key */
- (void) ag_addAllArchivedObjectUseDefaultKeys;

/** 移除要归档和转字符串的 keys */
- (void) ag_removeArchivedCommonVMKey;
- (void) ag_removeArchivedHeaderVMKey;
- (void) ag_removeArchivedFooterVMKey;
- (void) ag_removeArchivedItemArrMKey;
- (void) ag_removeAllArchivedObjectKeys;


#pragma mark - map、filter、reduce
- (AGVMSection *) map:(NS_NOESCAPE AGVMMapBlock)block;
- (AGVMSection *) filter:(NS_NOESCAPE AGVMFilterBlock)block;
- (void) reduce:(NS_NOESCAPE AGVMReduceBlock)block;


// ...
- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;
- (NSString *) ag_debugString;

@end

NS_ASSUME_NONNULL_END
