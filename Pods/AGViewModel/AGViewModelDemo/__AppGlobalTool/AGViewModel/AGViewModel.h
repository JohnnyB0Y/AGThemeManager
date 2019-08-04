//
//  AGViewModel.h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/4/23.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  视图-模型 绑定

#import "AGVMKeys.h"
#import "AGVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - interface
@interface AGViewModel : NSObject
<NSCopying, NSMutableCopying, NSSecureCoding, AGVMJSONTransformable>

@property (nonatomic, weak,   readonly, nullable) UIView<AGVMResponsive> *bindingView;
@property (nonatomic, strong, readonly) NSMutableDictionary *bindingModel; ///< 不要直接@我，谢谢！

@property (nonatomic, weak, nullable) id<AGVMDelegate> delegate;
@property (nonatomic, copy, nullable) NSIndexPath *indexPath;


#pragma mark 绑定视图可以计算自己的Size，并提供给外界使用。
/** 获取 bindingView 的 size，从缓存中取。如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (CGSize) ag_sizeOfBindingView;

/** 直接传进去计算并返回视图Size，如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (CGSize) ag_sizeForBindingView:(UIView<AGVMResponsive> *)bv;

/** 计算并缓存绑定视图的Size */
- (CGSize) ag_cachedSizeByBindingView:(UIView<AGVMResponsive> *)bv;

/** 对“需要缓存的视图Size”进行标记；当调用获取视图Size的方法时，从视图中取。*/
- (void) ag_setNeedsCachedBindingViewSize;

/** 如果有“需要缓存的视图Size”的标记，重新计算并缓存。*/
- (void) ag_cachedBindingViewSizeIfNeeded;


#pragma mark 通知 delegate 根据信息或类型做某事（ 让 view 传递信息给 controller ）
- (void) ag_makeDelegateHandleAction:(nullable SEL)action;
- (void) ag_makeDelegateHandleAction:(nullable SEL)action info:(nullable AGViewModel *)info;


#pragma mark 更新数据、刷新视图
/** 取数据，下标方法：id obj = vm[key]; */
- (nullable id) objectForKeyedSubscript:(NSString *)key;

/** 更新数据，下标方法：vm[key] = obj; */
- (void) setObject:(nullable id)obj forKeyedSubscript:(NSString *)key;

/** 删除数据 */
- (void) ag_removeObjectForKey:(NSString *)key;

/** 删除所有数据 */
- (void) ag_removeAllObjects;

/** 马上更新数据 并 刷新视图 */
- (void) ag_refreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;

/** 更新数据，并对“需要刷新UI”进行标记；当调用ag_refreshUIIfNeeded时，刷新UI界面。*/
- (void) ag_setNeedsRefreshUIModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block;

/** 对“需要刷新UI”进行标记；当调用ag_refreshUIIfNeeded时，刷新UI界面。*/
- (void) ag_setNeedsRefreshUI;

/** 刷新UI界面。*/
- (void) ag_refreshUI;

/** 如果有“需要刷新UI”的标记，马上刷新界面。 */
- (void) ag_refreshUIIfNeeded;


#pragma mark 归档持久化相关
/** 添加到支持 归档(NSKeyedArchiver)、转Json字符串当中。*/
- (void) ag_addArchivedObjectKey:(NSString *)key;

/** 从支持 归档(NSKeyedArchiver)、转Json字符串当中 移除。*/
- (void) ag_removeArchivedObjectKey:(NSString *)key;

/** 清空需要 归档(NSKeyedArchiver)、转Json字符串 的keys。*/
- (void) ag_removeAllArchivedObjectKeys;

/** 转成字符串（NSString、NSNumber、NSURL、实现 NSFastEnumeration 或 AGVMJSONTransformable 协议对象、{其他类型自行处理}）*/
- (nullable NSString *) ag_toJSONString;


#pragma mark 数据合并相关
/**
 合并包含 keys 的模型数据

 @param dict 待合并的字典
 @param keys 要合并数据的keys
 */
- (void) ag_mergeModelFromDictionary:(NSDictionary *)dict forKeys:(NSArray<NSString *> *)keys;
- (void) ag_mergeModelFromViewModel:(AGViewModel *)vm forKeys:(NSArray<NSString *> *)keys;

- (void) ag_mergeModelFromViewModel:(AGViewModel *)vm;
- (void) ag_mergeModelFromDictionary:(NSDictionary *)dict;


#pragma mark 快速初始化实例
/**
 通过 capacity 创建内部数据字典
 然后合并传入的数据字典快速初始化 viewModel 实例
 
 @param bindingModel 数据字典
 @param capacity 数据字典每次增量拷贝的内存大小
 @return viewModel 对象
 */
+ (instancetype) newWithModel:(nullable NSDictionary *)bindingModel
                     capacity:(NSInteger)capacity;

/**
 通过拷贝数据字典快速初始化 viewModel 实例
 如果 bindingModel 为 nil, 创建 capacity 为 6 的内部数据字典
 
 @param bindingModel 数据字典
 @return viewModel 对象
 */
+ (instancetype) newWithModel:(nullable NSDictionary *)bindingModel;
- (instancetype) initWithModel:(NSMutableDictionary *)bindingModel NS_DESIGNATED_INITIALIZER;

- (instancetype) init NS_UNAVAILABLE;
+ (instancetype) new NS_UNAVAILABLE;


#pragma mark debug 信息
- (NSString *) ag_debugString;

@end

#pragma mark - 安全存取
@interface AGViewModel (AGVMSafeAccessible) <AGVMSafeAccessible>
@end

#pragma mark - 键值观察
@interface AGViewModel (AGVMObserverRegistration) <AGVMObserverRegistration>
@end

#pragma mark - 弱引用存取
@interface AGViewModel (AGVMWeakly)
// 不想强引用对象的时候，可以使用。


/** 添加弱引用的对象 */
- (void) ag_setWeaklyObject:(nullable id)obj forKey:(NSString *)key;

/** 获取弱引用的对象 */
- (nullable id) ag_weaklyObjectForKey:(NSString *)key;

/** 移除弱引用的对象 */
- (void) ag_removeWeaklyObjectForKey:(NSString *)key;

@end

#pragma mark - 命令编程
@interface AGViewModel (AGVMCommandExecutable)
// 当需要根据几个变化属性，拿到结果时，可以使用命令编程。


- (void) ag_setCommand:(AGVMCommand *)command forKey:(NSString *)key; ///< 添加命令
- (void) ag_setCommandBlock:(AGVMCommandExecutableBlock)block forKey:(NSString *)key; ///< 添加命令Block
- (void) ag_removeCommandForKey:(NSString *)key; ///< 移除命令


- (nullable id) ag_executeCommandForKey:(NSString *)key; ///< 获取命令执行结果，直接执行
- (void) ag_setNeedsExecuteCommandForKey:(NSString *)key; ///< 标记命令待执行
- (nullable id) ag_executeCommandIfNeededForKey:(NSString *)key; ///< 获取命令执行结果，有标记才执行命令，否则直接从字典中取


@end

#pragma mark - 链式方法
@interface AGViewModel (AGVMMethodChaining)

// bindig model
@property (nonatomic, copy, readonly) AGVMSetObjectForKeyBlock setObjectForKey;
@property (nonatomic, copy, readonly) AGVMRemoveObjectForKeyBlock removeObjectForKey;

@property (nonatomic, copy, readonly) AGViewModel *(^mergeDictionary)(NSDictionary *dict);
@property (nonatomic, copy, readonly) AGViewModel *(^mergeDictionaryForKeys)(NSDictionary *dict, NSArray<NSString *> *keys);

@property (nonatomic, copy, readonly) AGViewModel *(^mergeViewModel)(AGViewModel *vm);
@property (nonatomic, copy, readonly) AGViewModel *(^mergeViewModelForKeys)(AGViewModel *vm, NSArray<NSString *> *keys);

// property
@property (nonatomic, copy, readonly) AGViewModel *(^setBindingView)(UIView<AGVMResponsive> * _Nullable bindingView);
@property (nonatomic, copy, readonly) AGViewModel *(^setBindingViewConfigDataBlock)(AGVMConfigDataBlock);
@property (nonatomic, copy, readonly) AGViewModel *(^setIndexPath)(NSIndexPath * _Nullable indexPath);
@property (nonatomic, copy, readonly) AGViewModel *(^setDelegate)(id<AGVMDelegate> _Nullable delegate);

// command
@property (nonatomic, copy, readonly) AGViewModel *(^setCommandForKey)(AGVMCommand *command, NSString *key);
@property (nonatomic, copy, readonly) AGViewModel *(^removeCommandForKey)(NSString *key);

// weakly
@property (nonatomic, copy, readonly) AGVMSetObjectForKeyBlock setWeaklyForKey;
@property (nonatomic, copy, readonly) AGVMRemoveObjectForKeyBlock removeWeaklyForKey;

// archived
@property (nonatomic, copy, readonly) AGViewModel *(^addArchivedKey)(NSString *key);
@property (nonatomic, copy, readonly) AGViewModel *(^removeArchivedKey)(NSString *key);

@end

NS_ASSUME_NONNULL_END
