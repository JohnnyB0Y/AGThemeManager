//
//  AGVMFunction.h
//
//
//  Created by JohnnyB0Y on 2017/12/24.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGVMProtocol.h"
@class AGVMSharedPackager, AGViewModel, AGVMSection, AGVMManager;

#ifndef AGVMFunction_h
#define AGVMFunction_h


NS_ASSUME_NONNULL_BEGIN

#pragma mark - Fast Funtion
FOUNDATION_EXPORT AGVMManager * ag_newAGVMManager(NSInteger capacity);
FOUNDATION_EXPORT AGVMSection * ag_newAGVMSection(NSInteger capacity);
FOUNDATION_EXPORT AGViewModel * ag_newAGViewModel(NSDictionary * _Nullable bindingModel);
FOUNDATION_EXPORT AGVMSharedPackager * ag_sharedVMPackager(void);


FOUNDATION_EXPORT NSMutableDictionary * ag_newNSMutableDictionary(NSInteger capacity);
FOUNDATION_EXPORT NSMutableArray * ag_newNSMutableArray(NSInteger capacity);
FOUNDATION_EXPORT NSMutableArray * ag_newNSMutableArrayWithNSNull(NSInteger capacity);


FOUNDATION_EXPORT AGVMTargetVCBlock ag_viewModelCopyTargetVCBlock(AGVMTargetVCBlock block);


/** 获取 vmm 中 item 的 indexPath */
FOUNDATION_EXPORT NSIndexPath * _Nullable ag_indexPathForTableView(AGVMManager *vmm, AGViewModel *item);
/** 获取 vmm 中 item 的 indexPath */
FOUNDATION_EXPORT NSIndexPath * _Nullable ag_indexPathForCollectionView(AGVMManager *vmm, AGViewModel *item);


#pragma mark - Safe Convert
/**
 验证传入对象是否某类型
 
 @param obj 传入对象
 @param objClass 对象类型
 @return 是：返回原对象；否：返回 nil；
 */
FOUNDATION_EXPORT id _Nullable ag_safeObj(id obj, Class objClass);

#pragma mark 字典、数组
FOUNDATION_EXPORT NSDictionary * _Nullable ag_safeDictionary(id obj);
FOUNDATION_EXPORT NSMutableDictionary * _Nullable ag_safeMutableDictionary(id obj);
FOUNDATION_EXPORT NSArray * _Nullable ag_safeArray(id obj);
FOUNDATION_EXPORT NSMutableArray * _Nullable ag_safeMutableArray(id obj);

#pragma mark 字符串、数字
FOUNDATION_EXPORT NSString * _Nullable ag_safeString(id obj);
FOUNDATION_EXPORT NSNumber * _Nullable ag_safeNumber(id obj);
FOUNDATION_EXPORT NSString * _Nullable ag_newNSStringWithObj(id obj);

#pragma mark URL
FOUNDATION_EXPORT NSURL * _Nullable ag_safeURL(id obj);


#pragma mark - JSON Transform
/**
 数组转成字符串 - 可替换自定义key - 可自行处理特殊类型（NSString、NSNumber、NSURL、实现NSFastEnumeration或AGVMJSONTransformable协议对象、{其他类型自行处理}）
 
 @param array 待转换的数组
 @param exchangeKeyVM 需要替换key的VM，格式 {原Key:新Key}
 @param block 自行处理Block（通过写入 useDefault 来控制采用 返回处理结果 还是 默认处理结果）
 @return JSON字符串
 */
FOUNDATION_EXPORT NSString * _Nullable ag_newJSONStringWithArray(NSArray *array,
                                                                 AGViewModel * _Nullable exchangeKeyVM,
                                                                 AGVMJSONTransformBlock _Nullable NS_NOESCAPE block);

/**
 字典转成字符串 - 可替换自定义key - 可自行处理特殊类型（NSString、NSNumber、NSURL、实现NSFastEnumeration或AGVMJSONTransformable协议对象、{其他类型自行处理}）
 
 @param dict 待转换的字典
 @param exchangeKeyVM 需要替换key的VM，格式 {原Key:新Key}
 @param block 自行处理Block（通过写入 useDefault 来控制采用 返回处理结果 还是 默认处理结果）
 @return JSON字符串
 */
FOUNDATION_EXPORT NSString * _Nullable ag_newJSONStringWithDictionary(NSDictionary *dict,
                                                                      AGViewModel * _Nullable exchangeKeyVM,
                                                                      AGVMJSONTransformBlock _Nullable NS_NOESCAPE block);

/** 字符串转成数组对象 */
FOUNDATION_EXPORT NSArray * _Nullable ag_newNSArrayWithJSONString(NSString *json, NSError **error);

/** 字符串转成字典对象 */
FOUNDATION_EXPORT NSDictionary * _Nullable ag_newNSDictionaryWithJSONString(NSString *json, NSError **error);

/** 清洗字符串，去除首尾空白字符串，并替换制表符字符串。 */
FOUNDATION_EXPORT NSString * _Nullable ag_newJSONStringByWashString(NSString *json);

NS_ASSUME_NONNULL_END

#endif /* AGVMFunction_h */
