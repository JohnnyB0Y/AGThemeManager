//
//  AGVMCommand.m
//
//
//  Created by JohnnyB0Y on 2019/7/26.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGVMCommand.h"

@interface AGVMCommand ()

@end

@implementation AGVMCommand {
    AGVMCommandBlock _executeBlock;
    AGVMCommandBlock _undoBlock;
}

+ (AGVMCommand *)defaultInstance
{
    return [[self alloc] init];
}

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

- (AGVMCommand * _Nonnull (^)(AGVMCommandBlock _Nonnull))setExecuteBlock
{
    return ^AGVMCommand * _Nonnull(AGVMCommandBlock  _Nonnull block) {
        self->_executeBlock = [block copy];
        return self;
    };
}

- (AGVMCommand * _Nonnull (^)(AGVMCommandBlock _Nonnull))setUndoBlock
{
    return ^AGVMCommand * _Nonnull(AGVMCommandBlock  _Nonnull block) {
        self->_undoBlock = [block copy];
        return self;
    };
}

- (AGVMCommand * _Nonnull (^)(AGVMCommand * _Nonnull))setPrevCommand
{
    return ^AGVMCommand * _Nonnull(AGVMCommand * _Nonnull command) {
        self->_prev = command;
        return self;
    };
}

- (AGVMCommand * _Nonnull (^)(AGVMCommand * _Nonnull))setNextCommand
{
    return ^AGVMCommand * _Nonnull(AGVMCommand * _Nonnull command) {
        self->_next = command;
        return self;
    };
}

- (AGVMCommand * _Nonnull (^)(BOOL))setExecutable
{
    return ^AGVMCommand * _Nonnull(BOOL executable) {
        self->_executable = executable;
        return self;
    };
}

- (AGVMCommand * _Nonnull (^)(BOOL))setUndoable
{
    return ^AGVMCommand * _Nonnull(BOOL undoable) {
        self->_undoable = undoable;
        return self;
    };
}

@end
