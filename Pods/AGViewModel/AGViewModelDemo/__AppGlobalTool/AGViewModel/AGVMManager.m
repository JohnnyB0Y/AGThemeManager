//
//  AGVMManager.m
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  

#import "AGVMManager.h"
#import "AGVMFunction.h"

@interface AGVMManager ()

@property (nonatomic, strong) NSMutableArray<AGVMSection *> *sectionArrM;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *archivedDictM;
@property (nonatomic, strong) NSMutableDictionary<NSString *, id> *serializationDictM; ///< 序列化字典

@end


@implementation AGVMManager {
    NSInteger _capacity;
}

#pragma mark - ----------- Life Cycle ----------
+ (AGVMManager *)defaultInstance
{
    return [self newWithSectionCapacity:6];
}

/**
 Quickly create vmm
 
 @param capacity itemArr 的 capacity
 @return vmm
 */
+ (instancetype) newWithSectionCapacity:(NSInteger)capacity
{
    return [[self alloc] initWithSectionCapacity:capacity];
}

- (instancetype)initWithSectionCapacity:(NSInteger)capacity
{
    AGAssertIndexRange(0, capacity, NSIntegerMax);
    if ( capacity <= 0 ) {
        return nil;
    }
    self = [super init];
    if ( self ) {
        self->_capacity = capacity;
        self->_sectionArrM = ag_newNSMutableArray(capacity);
    }
    return self;
}

#pragma mark - ---------- Public Methods ----------
- (AGViewModel *)ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package
{
    return [self ag_packageCommonData:package capacity:6];
}

- (AGViewModel *)ag_packageCommonData:(NS_NOESCAPE AGVMPackageDataBlock)package
                             capacity:(NSInteger)capacity
{
    _cvm = [ag_sharedVMPackager() ag_packageData:package capacity:capacity];
    return _cvm;
}

#pragma mark -
/** 拼装 section 数据 capacity */
- (AGVMSection *) ag_packageSection:(NS_NOESCAPE AGVMPackageSectionBlock)block capacity:(NSInteger)capacity
{
    AGAssertIndexRange(0, capacity, NSIntegerMax);
    AGVMSection *vms = ag_newAGVMSection(capacity);
    if ( block ) block(vms);
    [self.sectionArrM addObject:vms];
    return vms;
}

- (AGVMSection *)ag_packageSection:(NS_NOESCAPE AGVMPackageSectionBlock)block
{
    return [self ag_packageSection:block capacity:15];
}

- (AGVMSection *)ag_packageSectionItems:(NSArray *)items packager:(id<AGVMPackagable>)packager forObject:(id)obj
{
	return [self ag_packageSection:^(AGVMSection * _Nonnull vms) {
		[vms ag_packageItems:items packager:packager forObject:obj];
	} capacity:items.count];
}

- (AGVMManager *) ag_packageSections:(NSArray *)sections
							 inBlock:(NS_NOESCAPE AGVMPackageSectionsBlock)block
{
	return [self ag_packageSections:sections inBlock:block capacity:15];
}

- (AGVMManager *) ag_packageSections:(NSArray *)sections
							 inBlock:(NS_NOESCAPE AGVMPackageSectionsBlock)block
							capacity:(NSInteger)capacity
{
    AGAssertIndexRange(0, capacity, NSIntegerMax);
	[sections enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		[self ag_packageSection:^(AGVMSection * _Nonnull vms) {
			block ? block(vms, obj, idx) : nil;
		} capacity:capacity];
	}];
	return self;
}

#pragma mark - NSCopying
- (id)copyWithZone:(nullable NSZone *)zone
{
    AGVMManager *vmm = [[self.class allocWithZone:zone] initWithSectionCapacity:_capacity];
    vmm->_cvm = [_cvm copy];
    [self ag_enumerateSectionsUsingBlock:^(AGVMSection * _Nonnull vms, NSUInteger idx, BOOL * _Nonnull stop) {
        [vmm ag_addSection:[vms copy]];
    }];
    return vmm;
}

- (id)mutableCopyWithZone:(NSZone *)zone
{
    AGVMManager *vmm = [[self.class allocWithZone:zone] initWithSectionCapacity:_capacity];
    vmm->_cvm = [_cvm mutableCopy];
    [self ag_enumerateSectionsUsingBlock:^(AGVMSection * _Nonnull vms, NSUInteger idx, BOOL * _Nonnull stop) {
        [vmm ag_addSection:[vms mutableCopy]];
    }];
    return vmm;
}

#pragma mark - NSSecureCoding
+ (BOOL)supportsSecureCoding
{
    return YES;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    if ( _archivedDictM.count < 0 ) {
        NSLog(@"Please add the keys that need to be archived.");
        return;
    }
    
    NSString *archiveCommonVMKey = self.archivedDictM[kAGVMCommonVM];
    NSString *archiveSectionArrMKey = self.archivedDictM[kAGVMArray];
    [aCoder encodeObject:self.archivedDictM forKey:kAGVMDictionary];
    
    if ( self->_cvm && archiveCommonVMKey )
        [aCoder encodeObject:self->_cvm forKey:archiveCommonVMKey];
    
    if ( self->_sectionArrM.count > 0 && archiveSectionArrMKey )
        [aCoder encodeObject:self->_sectionArrM forKey:archiveSectionArrMKey];
    
    [aCoder encodeObject:@(_capacity) forKey:kAGVMCapacity];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    Class selfCls = self.class;
    NSNumber *capacity = [aDecoder decodeObjectOfClass:selfCls forKey:kAGVMCapacity];
    self = [self initWithSectionCapacity:capacity.integerValue];
    if ( self == nil ) return nil;
    
    NSDictionary *archiveKeyDict = [aDecoder decodeObjectOfClass:selfCls forKey:kAGVMDictionary];
    NSString *archiveSectionArrMKey = archiveKeyDict[kAGVMArray];
    if ( archiveSectionArrMKey ) {
        NSArray *sectionArr = [aDecoder decodeObjectOfClass:selfCls forKey:archiveSectionArrMKey];
        [self ag_addSectionsFromArray:sectionArr];
    }
    
    NSString *archiveCommonVMKey = archiveKeyDict[kAGVMCommonVM];
    
    if ( archiveCommonVMKey )
        self->_cvm = [aDecoder decodeObjectOfClass:selfCls forKey:archiveCommonVMKey];
    
    if ( archiveKeyDict )
        self->_archivedDictM = [archiveKeyDict mutableCopy];
    
    return self;
}

#pragma mark - 修改数据
#pragma mark 添加
- (void) ag_addSection:(AGVMSection *)section
{
    section ? [self.sectionArrM addObject:section] : nil;
}

- (void) ag_addSectionsFromArray:(NSArray<AGVMSection *> *)sections
{
    sections.count > 0 ? [self.sectionArrM addObjectsFromArray:sections] : nil;
}

- (void) ag_addSectionsFromManager:(AGVMManager *)vmm
{
    [self ag_addSectionsFromArray:vmm.sectionArrM];
}

#pragma mark 插入
- (void) ag_insertSectionsFromManager:(AGVMManager *)vmm
                              atIndex:(NSInteger)index
{
    [self ag_insertSectionsFromArray:vmm.sectionArrM atIndex:index];
}

- (void) ag_insertSectionsFromArray:(NSArray<AGVMSection *> *)vmsArr
                            atIndex:(NSInteger)index
{
    AGAssertIndexRange(-1, index, self.count+1);
    if ( vmsArr && AGIsIndexInRange(-1, index, self.count+1) ) {
        NSIndexSet *indexSet =
        [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(index, vmsArr.count)];
        [self.sectionArrM insertObjects:vmsArr atIndexes:indexSet];
    }
}

- (void) ag_insertSection:(AGVMSection *)section
                  atIndex:(NSInteger)index
{
    AGAssertIndexRange(-1, index, self.count+1);
    if ( section && AGIsIndexInRange(-1, index, self.count+1) ) {
        [self.sectionArrM insertObject:section atIndex:index];
    }
    
}

- (void) ag_insertSectionPackage:(NS_NOESCAPE AGVMPackageSectionBlock)package
                         atIndex:(NSInteger)index
{
    [self ag_insertSectionPackage:package atIndex:index capacity:6];
}

- (void) ag_insertSectionPackage:(NS_NOESCAPE AGVMPackageSectionBlock)package
                         atIndex:(NSInteger)index
                        capacity:(NSInteger)capacity
{
    if ( package ) {
        AGVMSection *vms = ag_newAGVMSection(capacity);
        package(vms);
        [self ag_insertSection:vms atIndex:index];
    }
}

#pragma mark 移除
- (void) ag_removeAllSections
{
    [self.sectionArrM removeAllObjects];
}

- (void) ag_removeLastSection
{
    [self.sectionArrM removeLastObject];
}

- (void) ag_removeSectionAtIndex:(NSInteger)index
{
    AGAssertIndexRange(-1, index, self.count);
    if ( AGIsIndexInRange(-1, index, self.count) ) {
        [self.sectionArrM removeObjectAtIndex:index];
    }
}

- (void)ag_removeSectionsUsingBlock:(BOOL (NS_NOESCAPE ^)(AGVMSection * _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if ( self.sectionArrM.count <= 0 ) return;
    if ( nil == block ) return;
    
    NSMutableIndexSet *idxSetM = [NSMutableIndexSet indexSet];
    [self.sectionArrM enumerateObjectsUsingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ( block(obj, idx, stop) ) {
            [idxSetM addIndex:idx];
        }
    }];
    
    [self.sectionArrM removeObjectsAtIndexes:idxSetM];
}

- (void)ag_removeSectionItemsUsingBlock:(BOOL (NS_NOESCAPE ^)(AGViewModel * _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if ( self.sectionArrM.count <= 0 ) return;
    if ( nil == block ) return;
    
    [self.sectionArrM enumerateObjectsUsingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj ag_removeItemsUsingBlock:block];
    }];
}

- (void)ag_removeSectionItemsWithOptions:(NSEnumerationOptions)opts usingBlock:(nonnull BOOL (NS_NOESCAPE ^)(AGViewModel * _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if ( self.sectionArrM.count <= 0 ) return;
    if ( nil == block ) return;
    
    [self.sectionArrM enumerateObjectsWithOptions:opts usingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSIndexSet *idxSet = [obj.itemArrM indexesOfObjectsWithOptions:opts passingTest:block];
        [obj.itemArrM removeObjectsAtIndexes:idxSet];
    }];
}

#pragma mark 合并
/** 合并 commonVM、sectionArrM */
- (void) ag_mergeFromManager:(AGVMManager *)vmm
{
	if (vmm == nil) return;
	
    if ( vmm.cvm ) {
        _cvm = _cvm ?: ag_newAGViewModel(nil);
    }
    [self.cvm ag_mergeModelFromViewModel:vmm.cvm];
    [self ag_addSectionsFromArray:vmm.sectionArrM];
}

#pragma mark 更新
- (void) ag_makeSectionsItemsRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeItemsRefreshUIByUpdateModelInBlock:) withObject:block];
}
- (void) ag_makeSectionsHeaderFooterRefreshUIByUpdateModelInBlock:(NS_NOESCAPE AGVMUpdateModelBlock)block
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeHeaderFooterRefreshUIByUpdateModelInBlock:) withObject:block];
}

- (void) ag_makeSectionsItemsSetNeedsCachedBindingViewSize
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeItemsSetNeedsCachedBindingViewSize)];
}
- (void) ag_makeSectionsHeaderFooterSetNeedsCachedBindingViewSize
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeHeaderFooterSetNeedsCachedBindingViewSize)];
}

- (void) ag_makeSectionsItemsSetNeedsRefreshUI
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeItemsSetNeedsRefreshUI)];
}
- (void) ag_makeSectionsHeaderFooterSetNeedsRefreshUI
{
    [self.sectionArrM makeObjectsPerformSelector:@selector(ag_makeHeaderFooterSetNeedsRefreshUI)];
}

- (void) ag_makeSectionsPerformSelector:(SEL)aSelector
{
    [_sectionArrM makeObjectsPerformSelector:aSelector];
}
- (void) ag_makeSectionsPerformSelector:(SEL)aSelector withObject:(id)argument
{
    [_sectionArrM makeObjectsPerformSelector:aSelector withObject:argument];
}

- (void) ag_makeSectionsIfInRange:(NSRange)range performSelector:(SEL)aSelector
{
    [self ag_makeSectionsIfInRange:range performSelector:aSelector withObject:nil];
}
- (void) ag_makeSectionsIfInRange:(NSRange)range performSelector:(SEL)aSelector withObject:(id)argument
{
    // loc=5 len=5
    // count = 5 idx = 0 ~ 4
    if ( range.location >= self.count ) return;
    
    if ( range.length > self.count - range.location ) {
        range.length = self.count - range.location;
    }
    NSArray *subArr = [_sectionArrM subarrayWithRange:range];
    [subArr makeObjectsPerformSelector:aSelector withObject:argument];
}

- (void)setObject:(AGVMSection *)vms atIndexedSubscript:(NSInteger)idx
{
    AGAssertIndexRange(-1, idx, self.count);
    if ( vms && AGIsIndexInRange(-1, idx, self.count) ) {
        [self.sectionArrM setObject:vms atIndexedSubscript:idx];
    }
}

#pragma mark 取出
- (AGVMSection *)objectAtIndexedSubscript:(NSInteger)idx
{
    if ( AGIsIndexInRange(-1, idx, self.count) ) {
        return [self.sectionArrM objectAtIndexedSubscript:idx];
    }
    return nil;
}

#pragma mark 交换
- (void) ag_exchangeSectionAtIndex:(NSInteger)idx1 withSectionAtIndex:(NSInteger)idx2
{
    AGAssertIndexRange(-1, idx1, self.count);
    AGAssertIndexRange(-1, idx2, self.count);
    if ( AGIsIndexInRange(-1, idx1, self.count) && AGIsIndexInRange(-1, idx2, self.count) )
        [self.sectionArrM exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

#pragma mark 替换
- (void) ag_replaceSectionAtIndex:(NSInteger)index withSection:(AGVMSection *)section
{
    AGAssertParameter(section);
    AGAssertIndexRange(-1, index, self.count);
	if (section == nil) return;
    if ( AGIsIndexInRange(-1, index, self.count) ) {
        [self.sectionArrM replaceObjectAtIndex:index withObject:section];
    }
}

#pragma mark 遍历
- (void) ag_enumerateSectionsUsingBlock:(void (NS_NOESCAPE ^)(AGVMSection * _Nonnull, NSUInteger, BOOL * _Nonnull))block
{
    if ( ! block ) return;
    [self.sectionArrM enumerateObjectsUsingBlock:block];
}

- (void) ag_enumerateSectionsIfInRange:(NSRange)range usingBlock:(void(NS_NOESCAPE^)(AGVMSection *vms, NSUInteger idx, BOOL *stop))block
{
    if ( ! block ) return;
    if ( range.location >= self.count ) return;
    
    if ( range.length > self.count - range.location ) {
        range.length = self.count - range.location;
    }
    NSArray *subArr = [_sectionArrM subarrayWithRange:range];
    [subArr enumerateObjectsUsingBlock:block];
}

- (void) ag_enumerateSectionsItemUsingBlock:(void (NS_NOESCAPE ^)(AGViewModel * _Nonnull, NSIndexPath * _Nonnull, BOOL * _Nonnull))block
{
    if ( ! block ) return;
    
    __block BOOL _stop = NO;
    [self ag_enumerateSectionsUsingBlock:^(AGVMSection * _Nonnull vms, NSUInteger section, BOOL * _Nonnull stop) {
        [vms ag_enumerateItemsUsingBlock:^(AGViewModel * _Nonnull vm, NSUInteger item, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            block(vm, indexPath, &_stop);
            if ( _stop ) *stop = _stop;
        }];
        if ( _stop ) *stop = _stop;
    }];
}

/** 遍历所有 section 的 header、footer vm */
- (void) ag_enumerateSectionsHeaderFooterUsingBlock:(void (NS_NOESCAPE ^)(AGViewModel * _Nonnull, NSIndexPath * _Nonnull, BOOL * _Nonnull))block
{
    if ( ! block ) return;
    
    __block BOOL _stop = NO;
    [self ag_enumerateSectionsUsingBlock:^(AGVMSection * _Nonnull vms, NSUInteger section, BOOL * _Nonnull stop) {
        [vms ag_enumerateHeaderFooterUsingBlock:^(AGViewModel * _Nonnull vm, NSUInteger item, BOOL * _Nonnull stop) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            block(vm, indexPath, &_stop);
            if ( _stop ) *stop = _stop;
        }];
        if ( _stop ) *stop = _stop;
    }];
}

#pragma mark - ----------- Getter Methods ----------
- (NSInteger) count
{
    return self.sectionArrM.count;
}

- (AGVMSection *)fs
{
    return [self.sectionArrM firstObject];
}

- (AGVMSection *)ls
{
    return [self.sectionArrM lastObject];
}

- (NSMutableDictionary<NSString *,id> *)archivedDictM
{
    if (_archivedDictM == nil) {
        _archivedDictM = ag_newNSMutableDictionary(2);
    }
    return _archivedDictM;
}

- (NSMutableDictionary<NSString *,id> *)serializationDictM
{
    if ( nil == _serializationDictM ) {
        _serializationDictM = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    return _serializationDictM;
}

#pragma mark - ----------- Override Methods ----------
- (NSString *)debugDescription
{
    return [self _debugStringIncludeDetail:NO];
}

- (id)debugQuickLookObject
{
    return [self _debugStringIncludeDetail:YES];
}

- (NSString *) _debugStringIncludeDetail:(BOOL)yesOrNo
{
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"  _cvm     (strong) : %@, \n", _cvm];
    
    if ( yesOrNo ) {
        NSMutableString *arrStrM = [NSMutableString stringWithString:@"(\n"];
        NSInteger maxIdx = self.count - 1;
        [_sectionArrM enumerateObjectsUsingBlock:^(AGVMSection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ( idx == maxIdx ) {
                [arrStrM appendFormat:@"🔷%@%@ \n", @(idx), [obj ag_debugString]];
            }
            else {
                [arrStrM appendFormat:@"🔷%@%@, \n", @(idx), [obj ag_debugString]];
            }
        }];
        
        [arrStrM appendFormat:@")"];
        
        [strM appendFormat:@"  _sectionArrM - Capacity:%@ - Count:%@ : %@", @(_capacity), @(self.count), arrStrM];
    }
    else {
        [strM appendFormat:@"  _sectionArrM - Capacity:%@ - Count:%@ : %@", @(_capacity), @(self.count), _sectionArrM];
    }
    
    return [NSString stringWithFormat:@"🔵 <%@: %p> 🔵 {\n%@\n}", [self class] , self, strM];
}

@end

#pragma mark - 归档持久化
@implementation AGVMManager (AGVMArchived)

- (void) ag_addArchivedKey:(NSString *)key forType:(AGVMManagerDataType)type
{
    NSParameterAssert(key);
    [self.archivedDictM setObject:key forKey:[self ag_keyForDataType:type]];
}
- (void) ag_removeArchivedKeyForType:(AGVMManagerDataType)type
{
    [_archivedDictM removeObjectForKey:[self ag_keyForDataType:type]];
}

- (void) ag_addAllArchivedObjectUseDefaultKeys
{
    [self.archivedDictM setObject:kAGVMCommonVM forKey:kAGVMCommonVM];
    [self.archivedDictM setObject:kAGVMArray forKey:kAGVMArray];
}
- (void) ag_removeAllArchivedKeys
{
    [_archivedDictM removeAllObjects];
}

- (NSString *) ag_keyForDataType:(AGVMManagerDataType)type
{
    switch (type) {
        case AGVMManagerDataTypeCommon: {
            return kAGVMCommonVM;
        } break;
        case AGVMManagerDataTypeSectionArr: {
            return kAGVMArray;
        } break;
        default: {
            return nil;
        } break;
    }
}

@end

#pragma mark - 序列化
@implementation AGVMManager (AGVMSerializable)

- (void) ag_addSerializableKey:(NSString *)key forType:(AGVMManagerDataType)type
{
    NSParameterAssert(key);
    [self.serializationDictM setObject:key forKey:[self ag_keyForDataType:type]];
}
- (void) ag_removeSerializableKeyForType:(AGVMManagerDataType)type
{
    [_serializationDictM removeObjectForKey:[self ag_keyForDataType:type]];
}

- (void) ag_addAllSerializableObjectUseDefaultKeys
{
    [self.serializationDictM setObject:kAGVMCommonVM forKey:kAGVMCommonVM];
    [self.serializationDictM setObject:kAGVMArray forKey:kAGVMArray];
}
- (void) ag_removeAllSerializableKeys
{
    [_serializationDictM removeAllObjects];
}

#pragma mark AGVMJSONTransformable
- (NSString *) ag_toJSONStringWithExchangeKey:(AGViewModel *)vm
                              customTransform:(NS_NOESCAPE AGVMJSONTransformBlock)block
{
    if ( _serializationDictM.count < 0 ) {
        NSLog(@"Please add the keys that need to transform json.");
        return nil;
    }
    
    NSString *archiveCommonVMKey = _serializationDictM[kAGVMCommonVM];
    NSString *archiveSectionArrMKey = _serializationDictM[kAGVMArray];
    
    NSMutableDictionary *dictM = ag_newNSMutableDictionary(_serializationDictM.count);
    
    if ( archiveCommonVMKey )
        dictM[archiveCommonVMKey] = _cvm ?: @"{}";
    
    if ( archiveSectionArrMKey )
        dictM[archiveSectionArrMKey] = _sectionArrM ?: @"[]";
    
    return ag_newJSONStringWithDictionary(dictM, vm, block);
}

- (NSString *)ag_toJSONStringWithCustomTransform:(NS_NOESCAPE AGVMJSONTransformBlock)block
{
    return [self ag_toJSONStringWithExchangeKey:nil customTransform:block];
}

- (NSString *)ag_toJSONString
{
    return [self ag_toJSONStringWithCustomTransform:nil];
}

@end
