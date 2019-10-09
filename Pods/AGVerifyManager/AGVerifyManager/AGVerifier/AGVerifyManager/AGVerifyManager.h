//
//  AGVerifyManager.h
//  Architecture
//
//  Created by JohnnyB0Y on 2017/6/3.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//  GitHub: https://github.com/JohnnyB0Y/AGVerifyManager
//  简书:    http://www.jianshu.com/p/c1e49fcd4a15

#import <Foundation/Foundation.h>
@class AGVerifyError, AGVerifyManager;
@protocol AGVerifyManagerVerifiable, AGVerifyManagerVerifying;

NS_ASSUME_NONNULL_BEGIN


FOUNDATION_EXTERN NSString * const kAGVerifyManagerVerifyingBlock;
FOUNDATION_EXTERN NSString * const kAGVerifyManagerCompletionBlock;


typedef void(^AGVerifyManagerVerifyingBlock)(id<AGVerifyManagerVerifying> start);

typedef void(^AGVerifyManagerCompletionBlock)(AGVerifyError * _Nullable firstError,
                                              NSArray<AGVerifyError *> * _Nullable errors);


typedef id<AGVerifyManagerVerifying> _Nonnull (^AGVerifyManagerVerifyDataBlock)(id<AGVerifyManagerVerifiable> verifier,
                                                                                id data);

typedef id<AGVerifyManagerVerifying> _Nonnull (^AGVerifyManagerVerifyDataWithContextBlock)(id<AGVerifyManagerVerifiable> verifier,
                                                                                           id data,
                                                                                           id _Nullable context);

typedef id<AGVerifyManagerVerifying> _Nonnull (^AGVerifyManagerVerifyDataWithMsgBlock)(id<AGVerifyManagerVerifiable> verifier,
                                                                                       id data,
                                                                                       NSString * _Nullable msg);

typedef id<AGVerifyManagerVerifying> _Nonnull (^AGVerifyManagerVerifyDataWithMsgWithContextBlock)(id<AGVerifyManagerVerifiable> verifier,
                                                                                                  id data,
                                                                                                  NSString * _Nullable msg,
                                                                                                  id _Nullable context);

@interface AGVerifyManager : NSObject

@property (class, readonly) AGVerifyManager *defaultInstance;


#pragma mark 直接执行验证Block，不保留Block引用。
- (void) ag_executeVerifying:(NS_NOESCAPE AGVerifyManagerVerifyingBlock)verifyingBlock
                  completion:(NS_NOESCAPE AGVerifyManagerCompletionBlock)completionBlock;


#pragma mark 添加验证Block。
- (void) ag_addVerifyForKey:(NSString *)key
                  verifying:(AGVerifyManagerVerifyingBlock)verifyingBlock
                 completion:(AGVerifyManagerCompletionBlock)completionBlock;

#pragma mark 更改验证Block。
- (void) ag_setVerifyForKey:(NSString *)key
                  verifying:(AGVerifyManagerVerifyingBlock)verifyingBlock;

- (void) ag_setVerifyForKey:(NSString *)key
                 completion:(AGVerifyManagerCompletionBlock)completionBlock;

#pragma mark 移除验证Block。
- (void) ag_removeVerifyBlockForKey:(NSString *)key;
- (void) ag_removeAllVerifyBlocks;

#pragma mark 执行验证Block。
- (void) ag_executeVerifyBlockForKey:(NSString *)key;
- (void) ag_executeAllVerifyBlocks;

/** 多线程执行验证Block，verifyingBlock 在其他线程下执行；completionBlock 回到主线程执行。*/
- (void) ag_executeVerifyBlockInBackgroundForKey:(NSString *)key;
- (void) ag_executeAllVerifyBlocksInBackground;

@end


#pragma mark - AGVerifyManagerVerifying
@protocol AGVerifyManagerVerifying <NSObject>

/** 验证数据，传入验证器、数据 */
@property (readonly) AGVerifyManagerVerifyDataBlock verifyData;

/** 验证数据，传入验证器、数据、你想传递的对象（由AGVerifyError对象持有） */
@property (readonly) AGVerifyManagerVerifyDataWithContextBlock verifyDataWithContext;

/** 验证数据，直传入验证器、数据、错误提示信息 */
@property (readonly) AGVerifyManagerVerifyDataWithMsgBlock verifyDataWithMsg;

/** 验证数据，传入验证器、数据、错误提示信息、你想传递的对象（由AGVerifyError对象持有） */
@property (readonly) AGVerifyManagerVerifyDataWithMsgWithContextBlock verifyDataWithMsgWithContext;

@end


#pragma mark - AGVerifyManagerVerifiable
@protocol AGVerifyManagerVerifiable <NSObject>

/** 验证数据，数据直接参数传入 */
- (nullable AGVerifyError *) ag_verifyData:(id)data;

@end


#pragma mark - AGVerifyError
@interface AGVerifyError : NSObject

/** 错误信息 */
@property (nonatomic, copy, nullable) NSString *msg;

/** 打包的错误信息 */
@property (nonatomic, copy, nullable) NSDictionary *userInfo;

/** 错误代码 */
@property (nonatomic, assign) NSInteger code;

/** 由调用方传入的对象，起对象传递作用。*/
@property (nonatomic, strong, nullable) id context;

@property (class, readonly) AGVerifyError *defaultInstance;

@property (readonly) AGVerifyError *(^setMsg)(NSString *x);
@property (readonly) AGVerifyError *(^setCode)(NSInteger x);
@property (readonly) AGVerifyError *(^setUserInfo)(NSDictionary *x);
@property (readonly) AGVerifyError *(^setContext)(id x);

@end


// 快捷构建方法
FOUNDATION_EXTERN AGVerifyManager * ag_newAGVerifyManager(void);

FOUNDATION_EXTERN AGVerifyManagerVerifyingBlock ag_verifyManagerCopyVerifyingBlock(AGVerifyManagerVerifyingBlock block);

FOUNDATION_EXTERN AGVerifyManagerCompletionBlock ag_verifyManagerCopyCompletionBlock(AGVerifyManagerCompletionBlock block);

NS_ASSUME_NONNULL_END
