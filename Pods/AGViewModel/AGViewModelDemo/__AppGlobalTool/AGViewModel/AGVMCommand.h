//
//  AGVMCommand.h
//  
//
//  Created by JohnnyB0Y on 2019/7/26.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AGVMProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGVMCommand : NSObject
<
AGVMCommandExecutable,
AGVMCommandUndoable,
AGVMCommandNextExecutable,
AGVMCommandPrevUndoable
>

@property (class, readonly) AGVMCommand *defaultInstance;

@property (nonatomic, assign, getter=isExecutable) BOOL executable; ///< 可执行？
@property (nonatomic, assign, getter=isUndoable) BOOL undoable; ///< 可回滚？


@property (nonatomic, strong) AGVMCommand *prev; ///< 上一个命令
@property (nonatomic, strong) AGVMCommand *next; ///< 下一个命令


@property (readonly) AGVMCommand *(^setExecuteBlock)(AGVMCommandBlock block);
@property (readonly) AGVMCommand *(^setUndoBlock)(AGVMCommandBlock block);


@property (readonly) AGVMCommand *(^setPrevCommand)(AGVMCommand *command);
@property (readonly) AGVMCommand *(^setNextCommand)(AGVMCommand *command);


@property (readonly) AGVMCommand *(^setExecutable)(BOOL executable);
@property (readonly) AGVMCommand *(^setUndoable)(BOOL undoable);


- (instancetype)initWithExecuteBlock:(nullable AGVMCommandBlock)execute undoBlock:(nullable AGVMCommandBlock)undo;
+ (instancetype)newWithExecuteBlock:(nullable AGVMCommandBlock)execute undoBlock:(nullable AGVMCommandBlock)undo;


@end

NS_ASSUME_NONNULL_END
