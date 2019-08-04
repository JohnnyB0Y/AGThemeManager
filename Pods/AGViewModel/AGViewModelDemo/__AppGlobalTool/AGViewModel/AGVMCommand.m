//
//  AGVMCommand.m
//
//
//  Created by JohnnyB0Y on 2019/7/26.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGVMCommand.h"

@interface AGVMCommand ()

@property (nonatomic, copy) AGVMCommandBlock executeBlock;
@property (nonatomic, copy) AGVMCommandBlock undoBlock;

@end

@implementation AGVMCommand
- (instancetype)initWithExecuteBlock:(AGVMCommandBlock)execute undoBlock:(AGVMCommandBlock)undo
{
    self = [self init];
    
    if ( self ) {
        _executable = YES;
        _undoable = YES;
        _executeBlock = [execute copy];
        _undoBlock = [undo copy];
    }
    
    return self;
}

+ (instancetype)newWithExecuteBlock:(AGVMCommandBlock)execute undoBlock:(AGVMCommandBlock)undo
{
    return [[self alloc] initWithExecuteBlock:execute undoBlock:undo];
}

- (id)ag_execute:(id)obj
{
    if ( _executable ) {
        return _executeBlock ? _executeBlock(self, obj) : nil;
    }
    return nil;
}

- (id)ag_undo:(id)obj
{
    if ( _undoable ) {
        return _undoBlock ? _undoBlock(self, obj) : nil;
    }
    return nil;
}

- (id)ag_executeNext:(id)obj
{
    return _next ? [_next ag_execute:obj] : nil;
}

- (id)ag_undoPrev:(id)obj
{
    return _prev ? [_prev ag_undo:obj] : nil;
}

@end
