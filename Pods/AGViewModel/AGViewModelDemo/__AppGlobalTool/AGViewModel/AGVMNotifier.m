//
//  AGVMNotifier.m
//  Architecture
//
//  Created by JohnnyB0Y on 2017/9/7.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import "AGVMNotifier.h"
#import "AGViewModel.h"

@interface AGVMNotifier ()

/** viewModel */
@property (nonatomic, weak) AGViewModel *viewModel;

/** observers dict */
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMapTable *> *observerDM;

/** readd observer map table */
@property (nonatomic, strong) NSMapTable<NSString *, id> *readdObserverMT;

@end

@implementation AGVMNotifier

#pragma mark - ----------- Life Cycle ----------
- (instancetype)initWithViewModel:(AGViewModel *)vm
{
    self = [super init];
    if ( self ) {
        _viewModel = vm;
    }
    return self;
}

- (void)dealloc
{
    [self ag_removeAllObservers];
}

#pragma mark - readd observer
- (void) ag_readdObserver:(NSObject *)observer
                   forKey:(NSString *)key
               usingBlock:(AGVMNotificationBlock)block
{
    [self ag_readdObserver:observer
                    forKey:key
                   options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
                usingBlock:block];
}

- (void) ag_readdObserver:(NSObject *)observer
                  forKeys:(NSArray<NSString *> *)keys
               usingBlock:(AGVMNotificationBlock)block
{
    for (NSString *key in keys) {
        [self ag_readdObserver:observer forKey:key usingBlock:block];
    }
}

- (void) ag_readdObserver:(NSObject *)observer
                   forKey:(NSString *)key
                  options:(NSKeyValueObservingOptions)options
               usingBlock:(AGVMNotificationBlock)block
{
    [self _addObserver:observer
                forKey:key
               options:options
            usingBlock:block
                 readd:YES];
}

- (void)ag_readdObserver:(NSObject *)observer
                 forKeys:(NSArray<NSString *> *)keys
                 options:(NSKeyValueObservingOptions)options
              usingBlock:(AGVMNotificationBlock)block
{
    for (NSString *key in keys) {
        [self ag_readdObserver:observer forKey:key options:options usingBlock:block];
    }
}

#pragma mark - add observer
- (void) ag_addObserver:(NSObject *)observer
                 forKey:(NSString *)key
             usingBlock:(AGVMNotificationBlock)block
{
    [self ag_addObserver:observer
                  forKey:key
                 options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
              usingBlock:block];
}

- (void) ag_addObserver:(NSObject *)observer
                forKeys:(NSArray<NSString *> *)keys
             usingBlock:(AGVMNotificationBlock)block
{
    for (NSString *key in keys) {
        [self ag_addObserver:observer forKey:key usingBlock:block];
    }
}

- (void) ag_addObserver:(NSObject *)observer
                 forKey:(NSString *)key
                options:(NSKeyValueObservingOptions)options
             usingBlock:(AGVMNotificationBlock)block
{
    [self _addObserver:observer
                forKey:key
               options:options
            usingBlock:block
                 readd:NO];
}

- (void) ag_addObserver:(NSObject *)observer
                forKeys:(NSArray<NSString *> *)keys
                options:(NSKeyValueObservingOptions)options
             usingBlock:(AGVMNotificationBlock)block
{
    for (NSString *key in keys) {
        [self ag_addObserver:observer forKey:key options:options usingBlock:block];
    }
}

#pragma mark - notify observer
- (BOOL) ag_notifyForKey:(NSString *)key change:(NSDictionary<NSKeyValueChangeKey,id> *)change
{
    BOOL isNotify = NO;
    NSParameterAssert(key);
    if ( ! key ) return isNotify;
    
    // observer - block
    NSMapTable *o_bMT = [_observerDM objectForKey:key];
    
    if ( o_bMT.count > 0 ) {
        // enumerating
        NSEnumerator *objEnu = o_bMT.objectEnumerator;
        AGVMNotificationBlock block;
        while ( (block = objEnu.nextObject) ) {
            // notify observer
            block(_viewModel, key, change);
            
            isNotify = YES;
        }
        
    }
    else if ( o_bMT ) {
        // remove observers with key
        [self _removeObserversForKey:key];
    }
    
    return isNotify;
}

#pragma mark - remove observer
- (void) ag_removeObserver:(NSObject *)observer
                    forKey:(NSString *)key
{
    NSParameterAssert(key);
    NSParameterAssert(observer);
    if ( ! key || ! observer ) return;
    
    // observer - block
    NSMapTable *o_bMT = [_observerDM objectForKey:key];
    [o_bMT removeObjectForKey:observer];
    
    // observe ?
    if ( o_bMT && o_bMT.count <= 0 ) {
        // remove observers with key
        [self _removeObserversForKey:key];
    }
}

- (void) ag_removeObserver:(NSObject *)observer
                   forKeys:(NSArray<NSString *> *)keys
{
    for (NSString *key in keys) {
        [self ag_removeObserver:observer forKey:key];
    }
}

- (void) ag_removeObserver:(NSObject *)observer
{
    for ( NSString *key in _observerDM.allKeys ) {
        [self ag_removeObserver:observer forKey:key];
    }
}

- (void) ag_removeAllObservers
{
    for ( NSString *key in _observerDM.allKeys ) {
        // remove KVO
        [self.viewModel.bindingModel removeObserver:self forKeyPath:key];
    }
    
    // make empty
    _observerDM = nil;
    _readdObserverMT = nil;
}

#pragma mark - KVO Change
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context
{
    if ( context == (__bridge void *)(self) ) {
        [self ag_notifyForKey:keyPath change:change];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark - ---------- Private Methods ----------
- (void) _removeObserversForKey:(NSString *)key
{
    [_observerDM removeObjectForKey:key];
    [_readdObserverMT removeObjectForKey:key];
    [self.viewModel.bindingModel removeObserver:self forKeyPath:key];
}

- (void) _addObserver:(NSObject *)observer
               forKey:(NSString *)key
              options:(NSKeyValueObservingOptions)options
           usingBlock:(AGVMNotificationBlock)block
                readd:(BOOL)readd
{
    NSParameterAssert(key);
    NSParameterAssert(observer);
    NSParameterAssert(block);
    if ( ! key || ! observer ) return;
    
    // observer - block
    NSMapTable *o_bMT = [self.observerDM objectForKey:key];
    
    if ( o_bMT ) {
        // have
        if ( readd ) {
            // remove old
            id readdObserver = [self.readdObserverMT objectForKey:key];
            readdObserver ? [o_bMT removeObjectForKey:readdObserver] : nil;
        }
        // add new
        [o_bMT setObject:[block copy] forKey:observer];
    }
    else {
        // no have
        o_bMT = [NSMapTable weakToStrongObjectsMapTable];
        [o_bMT setObject:[block copy] forKey:observer];
        [self.observerDM setObject:o_bMT forKey:key];
        
        // KVO
        [self.viewModel.bindingModel addObserver:self
                                      forKeyPath:key
                                         options:options
                                         context:(__bridge void *)(self)];
    }
    
    if ( readd ) {
        // update readdObserverMT
        [self.readdObserverMT setObject:observer forKey:key];
    }
}

#pragma mark - ------------ Override Methods --------------
- (NSString *)debugDescription
{
    NSMutableString *strM = [NSMutableString string];
    [strM appendFormat:@"  _viewModel       [ weak ] : %@, \n", _viewModel];
    [strM appendFormat:@"  _observerDM      (strong) : %@, \n", _observerDM];
    [strM appendFormat:@"  _readdObserverMT (strong) : %@, \n", _readdObserverMT];
    [strM appendFormat:@"  _observationInfo: %@,", [_viewModel.bindingModel observationInfo]];
    return [NSString stringWithFormat:@"<%@: %p> --- {\n%@\n}", [self class] , self, strM];
}

#pragma mark - ----------- Getter Methods ----------
- (NSMutableDictionary<NSString *,NSMapTable *> *)observerDM
{
    if (_observerDM == nil) {
        _observerDM = [NSMutableDictionary dictionaryWithCapacity:6];
    }
    return _observerDM;
}

- (NSMapTable<NSString *,id> *)readdObserverMT
{
    if (_readdObserverMT == nil) {
        _readdObserverMT = [NSMapTable weakToWeakObjectsMapTable];
    }
    return _readdObserverMT;
}

@end
