//
//  AGVerifyManager.m
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/3.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import "AGVerifyManager.h"
#import <objc/runtime.h>

NSString * const kAGVerifyManagerVerifyingBlock = @"kAGVerifyManagerVerifyingBlock";
NSString * const kAGVerifyManagerCompletionBlock = @"kAGVerifyManagerCompletionBlock";

@interface AGVerifyManager ()
<AGVerifyManagerVerifying>

/** first error */
@property (nonatomic, strong) AGVerifyError *firstError;

/** 错误数组 */
@property (nonatomic, strong) NSMutableArray<AGVerifyError *> *errorsM;

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableDictionary *> *executeDictM;

/** lock */
@property (nonatomic, strong) NSLock *lock;

@end

@implementation AGVerifyManager

- (instancetype)init
{
    self = [super init];
    if ( ! self ) return nil;
    
    _lock = [NSLock new];
    
    return self;
}

#pragma mark - ---------- AGVerifyManagerVerifying ----------
- (AGVerifyManagerVerifyDataBlock)verifyData
{
	return ^AGVerifyManager *(id<AGVerifyManagerVerifiable> verifier, id data) {
		return self.verifyDataWithMsgWithContext(verifier, data, nil, nil);
	};
}

- (AGVerifyManagerVerifyDataWithContextBlock)verifyDataWithContext
{
    return ^AGVerifyManager *(id<AGVerifyManagerVerifiable> verifier, id data, id context) {
        return self.verifyDataWithMsgWithContext(verifier, data, nil, context);
    };
}

- (AGVerifyManagerVerifyDataWithMsgBlock)verifyDataWithMsg
{
	return ^AGVerifyManager *(id<AGVerifyManagerVerifiable> verifier, id data, NSString *msg) {
		return self.verifyDataWithMsgWithContext(verifier, data, msg, nil);
	};
}

- (AGVerifyManagerVerifyDataWithMsgWithContextBlock)verifyDataWithMsgWithContext
{
    return ^AGVerifyManager *(id<AGVerifyManagerVerifiable> verifier, id data, NSString *msg, id context) {
        // 判断错误
        AGVerifyError *error;
        if ( [verifier respondsToSelector:@selector(ag_verifyData:)] )
            error = [verifier ag_verifyData:data];
        
        if ( error ) {
            // 有错
            error.context = context;
            error.msg = msg ?: error.msg;
            self.firstError = self.firstError ?: error;
            
            // 打包错误
            [self.errorsM addObject:error];
        }
        return self;
    };
}

#pragma mark - ---------- Public Methods ----------
- (void)ag_executeVerifying:(NS_NOESCAPE AGVerifyManagerVerifyingBlock)verifyingBlock
                 completion:(NS_NOESCAPE AGVerifyManagerCompletionBlock)completionBlock
{
    AGVerifyManager *manager = [NSThread isMainThread] ? self : ag_newAGVerifyManager();
    [AGVerifyManager performVerifyManager:manager verifying:verifyingBlock completion:completionBlock];
}

- (void)ag_addVerifyForKey:(NSString *)key
                 verifying:(AGVerifyManagerVerifyingBlock)verifyingBlock
                completion:(AGVerifyManagerCompletionBlock)completionBlock
{
    NSParameterAssert(key);
    NSParameterAssert(verifyingBlock);
    NSParameterAssert(completionBlock);
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithCapacity:2];
    dictM[kAGVerifyManagerVerifyingBlock] = [verifyingBlock copy];
    dictM[kAGVerifyManagerCompletionBlock] = [completionBlock copy];
    
    [self.lock lock];
    [self.executeDictM setObject:dictM forKey:key];
    [self.lock unlock];
}

- (void) ag_setVerifyForKey:(NSString *)key
                  verifying:(AGVerifyManagerVerifyingBlock)verifyingBlock
{
    NSParameterAssert(key);
    NSParameterAssert(verifyingBlock);
    [self.lock lock];
    NSMutableDictionary *dictM = [self.executeDictM objectForKey:key];
    if ( dictM == nil ) {
        dictM = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    dictM[kAGVerifyManagerVerifyingBlock] = [verifyingBlock copy];
    [self.lock unlock];
}

- (void) ag_setVerifyForKey:(NSString *)key
                 completion:(AGVerifyManagerCompletionBlock)completionBlock
{
    NSParameterAssert(key);
    NSParameterAssert(completionBlock);
    [self.lock lock];
    NSMutableDictionary *dictM = [self.executeDictM objectForKey:key];
    if ( dictM == nil ) {
        dictM = [NSMutableDictionary dictionaryWithCapacity:2];
    }
    dictM[kAGVerifyManagerCompletionBlock] = [completionBlock copy];
    [self.lock unlock];
}

- (void)ag_removeVerifyBlockForKey:(NSString *)key
{
    NSParameterAssert(key);
    [self.lock lock];
    [self.executeDictM removeObjectForKey:key];
    [self.lock unlock];
}

- (void)ag_removeAllVerifyBlocks
{
    [self.lock lock];
    [self.executeDictM removeAllObjects];
    [self.lock unlock];
}

- (void)ag_executeVerifyBlockForKey:(NSString *)key
{
    NSParameterAssert(key);
    NSMutableDictionary *dictM = [self.executeDictM objectForKey:key];
    AGVerifyManagerVerifyingBlock verifyingBlock = dictM[kAGVerifyManagerVerifyingBlock];
    AGVerifyManagerCompletionBlock completionBlock = dictM[kAGVerifyManagerCompletionBlock];
    
    AGVerifyManager *manager = [NSThread isMainThread] ? self : ag_newAGVerifyManager();
    [AGVerifyManager performVerifyManager:manager verifying:verifyingBlock completion:completionBlock];
}

- (void) ag_executeAllVerifyBlocks
{
    for (NSString *key in self.executeDictM.allKeys) {
        [self ag_executeVerifyBlockForKey:key];
    }
}

- (void) ag_executeVerifyBlockInBackgroundForKey:(NSString *)key
{
    NSParameterAssert(key);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @autoreleasepool {
            [self ag_executeVerifyBlockForKey:key];
        }
    });
}

- (void) ag_executeAllVerifyBlocksInBackground
{
    for (NSString *key in self.executeDictM.allKeys) {
        [self ag_executeVerifyBlockInBackgroundForKey:key];
    }
}

#pragma mark - ---------- Private Methods ----------
+ (void) performVerifyManager:(AGVerifyManager *)manager
                    verifying:(NS_NOESCAPE AGVerifyManagerVerifyingBlock)verifyingBlock
                   completion:(NS_NOESCAPE AGVerifyManagerCompletionBlock)completionBlock
{
    verifyingBlock ? verifyingBlock(manager) : nil;
    dispatch_async(dispatch_get_main_queue(), ^{
        completionBlock ? completionBlock(manager->_firstError, manager->_errorsM) : nil;
        // 清空数据
        manager->_firstError = nil;
        [manager->_errorsM removeAllObjects];
    });
}

#pragma mark - ----------- Getter Methods ----------
- (NSMutableArray *)errorsM
{
    if (_errorsM == nil) {
        _errorsM = [NSMutableArray arrayWithCapacity:5];
    }
    return _errorsM;
}

- (NSMutableDictionary<NSString *,NSMutableDictionary *> *)executeDictM
{
    if (_executeDictM == nil) {
        _executeDictM = [NSMutableDictionary dictionaryWithCapacity:5];
    }
    return _executeDictM;
}

@end


#pragma mark -
@implementation AGVerifyError

#pragma mark - ----------- Override Methods ----------
- (NSString *) debugDescription
{
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    NSMutableDictionary *dictM = [NSMutableDictionary dictionaryWithCapacity:count];
    for (int i = 0; i<count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name] ?: @"nil";
        [dictM setObject:value forKey:name];
    }
    
    free(properties);
    
    return [NSString stringWithFormat:@"<%@: %p> -- %@", [self class] , self, dictM];
}

@end

AGVerifyManager * ag_newAGVerifyManager(void)
{
    return [AGVerifyManager new];
}

AGVerifyManagerVerifyingBlock ag_verifyManagerCopyVerifyingBlock(AGVerifyManagerVerifyingBlock block)
{
    return [block copy];
}

AGVerifyManagerCompletionBlock ag_verifyManagerCopyCompletionBlock(AGVerifyManagerCompletionBlock block)
{
    return [block copy];
}
