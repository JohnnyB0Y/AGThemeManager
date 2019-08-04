#import "AGVMFunction.h"
#import "AGViewModel.h"
#import "AGVMSection.h"
#import "AGVMManager.h"



/** 能否转换 */
BOOL ag_canJSONTransformStringWithObject(id obj);
/** 开始转换 */
NSString * ag_JSONTransformStringWithObject(id obj, AGVMJSONTransformBlock block, AGViewModel *vm, BOOL *isString);




#pragma mark - Fast Funtion
/** Quickly create AGViewModel instance */
AGViewModel * ag_newAGViewModel(NSDictionary *bindingModel)
{
    return [AGViewModel newWithModel:bindingModel];
}

/** Quickly create AGVMSection instance */
AGVMSection * ag_newAGVMSection(NSInteger capacity)
{
    return [AGVMSection newWithItemCapacity:capacity];
}

/** Quickly create AGVMManager instance */
AGVMManager * ag_newAGVMManager(NSInteger capacity)
{
    return [AGVMManager newWithSectionCapacity:capacity];
}

/** Quickly create mutableDictionary */
NSMutableDictionary * ag_newNSMutableDictionary(NSInteger capacity)
{
    return [[NSMutableDictionary alloc] initWithCapacity:capacity];
}

/** Quickly create mutableArray */
NSMutableArray * ag_newNSMutableArray(NSInteger capacity)
{
    return [[NSMutableArray alloc] initWithCapacity:capacity];
}

NSMutableArray * ag_newNSMutableArrayWithNSNull(NSInteger capacity)
{
    NSMutableArray *arrM = ag_newNSMutableArray(capacity);
    for (NSInteger i = 0; i < capacity; i++) {
        [arrM addObject:[NSNull null]];
    }
    return arrM;
}

/** Quickly create block */
AGVMTargetVCBlock ag_viewModelCopyTargetVCBlock(AGVMTargetVCBlock block)
{
    return [block copy];
}


/** 获取 vmm 中 item 的 indexPath */
NSIndexPath * ag_indexPathForTableView(AGVMManager *vmm, AGViewModel *item)
{
    __block NSIndexPath *indexPath;
    [vmm.sectionArrM enumerateObjectsUsingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentIdx = [obj.itemArrM indexOfObjectIdenticalTo:item];
        if ( currentIdx < obj.itemArrM.count && idx >= 0 ) {
            *stop = YES;
            indexPath = [NSIndexPath indexPathForRow:currentIdx inSection:idx];
        }
    }];
    return indexPath;
}

/** 获取 vmm 中 item 的 indexPath */
NSIndexPath * ag_indexPathForCollectionView(AGVMManager *vmm, AGViewModel *item)
{
    __block NSIndexPath *indexPath;
    [vmm.sectionArrM enumerateObjectsUsingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger currentIdx = [obj.itemArrM indexOfObjectIdenticalTo:item];
        if ( currentIdx < obj.itemArrM.count && idx >= 0 ) {
            *stop = YES;
            indexPath = [NSIndexPath indexPathForItem:currentIdx inSection:idx];
        }
    }];
    return indexPath;
}


#pragma mark - Safe Convert
id ag_safeObj(id obj, Class objClass)
{
    if ( [obj isKindOfClass:objClass] ) {
        return obj;
    }
    return nil;
}

#pragma mark 字典、数组
/** 验证是否为NSDictionary对象；是：返回原对象；否：返回nil */
NSDictionary * ag_safeDictionary(id obj)
{
    return ag_safeObj(obj, [NSDictionary class]);
}

/** 验证是否为NSMutableDictionary对象；是：返回原对象；否：返回nil */
NSMutableDictionary * ag_safeMutableDictionary(id obj)
{
    return ag_safeObj(obj, [NSMutableDictionary class]);
}

/** 验证是否为NSArray对象；是：返回原对象；否：返回nil */
NSArray * ag_safeArray(id obj)
{
    return ag_safeObj(obj, [NSArray class]);
}

/** 验证是否为NSMutableArray对象；是：返回原对象；否：返回nil */
NSMutableArray * ag_safeMutableArray(id obj)
{
    return ag_safeObj(obj, [NSMutableArray class]);
}

#pragma mark 字符串、数字
/** 验证是否为NSString对象；是：返回原对象；否：返回nil */
NSString * ag_safeString(id obj)
{
    return ag_safeObj(obj, [NSString class]);
}

/** 验证是否能转换为 NSString 对象；能转：返回 NSString 对象；不能：返回 nil */
NSString * ag_newNSStringWithObj(id obj)
{
    NSString *newStr;
    if ( [obj isKindOfClass:[NSString class]] ) {
        newStr = obj;
    }
    else if ( [obj isKindOfClass:[NSNumber class]] ) {
        NSNumber *newObj = obj;
        newStr = newObj.stringValue;
    }
    else if ( [obj isKindOfClass:[NSURL class]] ) {
        NSURL *newObj = obj;
        newStr = [newObj absoluteString];
    }
    
    if ( newStr ) {
        return [NSString stringWithString:newStr];
    }
    
    return nil;
}

NSURL * ag_safeURL(id obj)
{
    if ( [obj isKindOfClass:[NSURL class]] ) {
        return obj;
    }
    if ( [obj isKindOfClass:[NSString class]] ) {
        return [NSURL URLWithString:obj];
    }
    return nil;
}

/** 验证是否为NSNumber对象；是：返回原对象；否：返回nil */
NSNumber * ag_safeNumber(id obj)
{
    return ag_safeObj(obj, [NSNumber class]);
}

#pragma mark JSON Transform
/**
 数组转成字符串 - 可替换自定义key - 可自行处理特殊类型（NSString、NSNumber、NSURL、实现NSFastEnumeration或AGVMJSONTransformable协议对象、{其他类型自行处理}）
 
 @param array 待转换的数组
 @param exchangeKeyVM 需要替换key的VM，格式 {原Key:新Key}
 @param block 自行处理Block（通过写入 useDefault 来控制采用 返回处理结果 还是 默认处理结果）
 @return JSON字符串
 */
NSString * ag_newJSONStringWithArray(NSArray *array, AGViewModel *exchangeKeyVM, AGVMJSONTransformBlock block)
{
    if ([array isKindOfClass:[NSArray class]] ) {
        // 开 {
        NSMutableString *strM = [NSMutableString stringWithString:@"["];
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BOOL isString = NO;
            NSString *newStr = ag_JSONTransformStringWithObject(obj, block, exchangeKeyVM, &isString);
            if ( newStr && (strM.length <= 1) ) {
                isString ? [strM appendFormat:@"\"%@\"", newStr] : [strM appendString:newStr];
            }
            else {
                isString ? [strM appendFormat:@",\"%@\"", newStr] : [strM appendFormat:@",%@", newStr];
            }
        }];
        // 闭 }
        [strM appendString:@"]"];
        return [strM copy];
    }
    NSCAssert(array == nil, @"传入的array 不是 NSArray对象.");
    return nil;
}

/**
 字典转成字符串 - 可替换自定义key - 可自行处理特殊类型（NSString、NSNumber、NSURL、实现NSFastEnumeration或AGVMJSONTransformable协议对象、{其他类型自行处理}）
 @desction
 @param dict 待转换的字典
 @param exchangeKeyVM 需要替换key的VM，格式 {原Key:新Key}
 @param block 自行处理Block（通过写入 useDefault 来控制采用 返回处理结果 还是 默认处理结果）
 @return JSON字符串
 */
NSString * ag_newJSONStringWithDictionary(NSDictionary *dict, AGViewModel *exchangeKeyVM, AGVMJSONTransformBlock block)
{
    if ([dict isKindOfClass:[NSDictionary class]] ) {
        // 开 {
        NSMutableString *strM = [NSMutableString stringWithString:@"{"];
        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            BOOL isString = NO;
            NSString *keyStr = ag_JSONTransformStringWithObject(key, block, exchangeKeyVM, nil);
            NSString *objStr = ag_JSONTransformStringWithObject(obj, block, exchangeKeyVM, &isString);
            if ( keyStr && objStr ) {
                // 是否需要替换 自定义key
                if ( [exchangeKeyVM isKindOfClass:[AGViewModel class]] ) {
                    NSString *newKey = exchangeKeyVM[keyStr];
                    if ( [newKey isKindOfClass:[NSString class]] ) {
                        keyStr = newKey;
                    }
                    else if ( newKey != nil ) {
                        NSCAssert(NO, @"exchangeKeyVM 取出的自定义key不是 NSString对象.");
                    }
                }
                else if ( exchangeKeyVM != nil ) {
                    NSCAssert(NO, @"传入的exchangeKeyVM 不是 AGViewModel对象.");
                }
                // 拼接字典字符串
                if ( strM.length <= 1 ) {
                    isString ? [strM appendFormat:@"\"%@\":\"%@\"", keyStr, objStr] : [strM appendFormat:@"\"%@\":%@", keyStr, objStr];
                }
                else {
                    isString ? [strM appendFormat:@",\"%@\":\"%@\"", keyStr, objStr] : [strM appendFormat:@",\"%@\":%@", keyStr, objStr];
                }
            }
        }];
        
        // 闭 }
        [strM appendString:@"}"];
        return [strM copy];
    }
    NSCAssert(NO, @"传入的dict 不是 NSDictionary对象.");
    return nil;
}

NSString * ag_JSONTransformStringWithObject(id obj, AGVMJSONTransformBlock block, AGViewModel *vm, BOOL *isString)
{
    // 特殊处理
    if ( block ) {
        BOOL useDefault = NO;
        id result = block(obj, &useDefault);
        if ( useDefault == NO ) {
            // 用户拦截了
            BOOL canTransform = ag_canJSONTransformStringWithObject(result);
            NSCAssert(canTransform, @"自行处理Block，请返回 NSString、NSNumber、NSURL、NSDictionary、NSArray、NSSet、NSMapTable、NSHashTable、AGViewModel、AGVMSection、AGVMManager对象 或者 nil.");
            if ( canTransform ) {
                return ag_JSONTransformStringWithObject(result, nil, vm, isString);
            }
        }
    }
    
    // 默认处理
    if ( obj == nil ) { return nil; }
    else if ( [obj isKindOfClass:[NSString class]] ) {
        if ( isString ) { *isString = YES; }
        return obj;
    }
    else if ( [obj isKindOfClass:[NSNumber class]] ) {
        return [obj stringValue];
    }
    else if ( [obj isKindOfClass:[NSURL class]] ) {
        if ( isString ) { *isString = YES; }
        return [obj absoluteString];
    }
    else if ( [obj isKindOfClass:[NSDictionary class]] ) {
        return ag_newJSONStringWithDictionary(obj, vm, block);
    }
    else if ( [obj isKindOfClass:[NSArray class]] ) {
        return ag_newJSONStringWithArray([obj allObjects], vm, block);
    }
    else if ( [obj respondsToSelector:@selector(ag_toJSONStringWithExchangeKey:customTransform:)] ) {
        return [obj ag_toJSONStringWithExchangeKey:vm customTransform:block];
    }
    else if ( [obj respondsToSelector:@selector(ag_toJSONStringWithCustomTransform:)] ) {
        return [obj ag_toJSONStringWithCustomTransform:block];
    }
    else if ( [obj respondsToSelector:@selector(ag_toJSONString)] ) {
        return [obj ag_toJSONString];
    }
    else if ( [obj isKindOfClass:[NSSet class]] ) {
        return ag_newJSONStringWithArray([obj allObjects], vm, block);
    }
    else if ( [obj isKindOfClass:[NSMapTable class]] ) {
        return ag_newJSONStringWithDictionary([obj dictionaryRepresentation], vm, block);
    }
    else if ( [obj isKindOfClass:[NSHashTable class]] ) {
        return ag_newJSONStringWithArray([obj allObjects], vm, block);
    }
    return nil;
}

BOOL ag_canJSONTransformStringWithObject(id obj)
{
    if ( obj == nil ) { return YES; }
    else if ( [obj isKindOfClass:[NSString class]] )     { return YES; }
    else if ( [obj isKindOfClass:[NSNumber class]] )     { return YES; }
    else if ( [obj isKindOfClass:[NSURL class]] )        { return YES; }
    else if ( [obj isKindOfClass:[NSDictionary class]] ) { return YES; }
    else if ( [obj isKindOfClass:[NSArray class]] )      { return YES; }
    else if ( [obj isKindOfClass:[NSSet class]] )        { return YES; }
    else if ( [obj isKindOfClass:[NSMapTable class]] )   { return YES; }
    else if ( [obj isKindOfClass:[NSHashTable class]] )  { return YES; }
    else if ( [obj respondsToSelector:@selector(ag_toJSONStringWithExchangeKey:customTransform:)] ) { return YES; }
    else if ( [obj respondsToSelector:@selector(ag_toJSONStringWithCustomTransform:)] ) { return YES; }
    else if ( [obj respondsToSelector:@selector(ag_toJSONString)] ) { return YES; }
    return NO;
}

NSArray * ag_newNSArrayWithJSONString(NSString *json, NSError **error)
{
    json = ag_newJSONStringByWashString(json);
    if ( ! [json hasPrefix:@"["] && ! [json hasSuffix:@"]"] ) {
        *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                     code:24
                                 userInfo:@{NSLocalizedDescriptionKey: @"Cannot be converted to an NSArray."}];
        return nil;
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:error];
}

NSDictionary * ag_newNSDictionaryWithJSONString(NSString *json, NSError **error)
{
    json = ag_newJSONStringByWashString(json);
    if ( ! [json hasPrefix:@"{"] && ! [json hasSuffix:@"}"] ) {
        *error = [NSError errorWithDomain:NSCocoaErrorDomain
                                     code:24
                                 userInfo:@{NSLocalizedDescriptionKey: @"Cannot be converted to an NSDictionary."}];
        return nil;
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:error];
}

NSString * ag_newJSONStringByWashString(NSString *json)
{
    // 去掉首尾空白
    json = [json stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // 替换制表符
    json = [json stringByReplacingOccurrencesOfString:@"\t" withString:@"\\t"];
    json = [json stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    json = [json stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    json = [json stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    
    return json;
}

/** 全局 vm packager */
AGVMSharedPackager * ag_sharedVMPackager(void)
{
    return [AGVMSharedPackager sharedInstance];
}
