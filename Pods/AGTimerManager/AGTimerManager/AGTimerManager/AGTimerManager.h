//
//  AGTimerManager.h
//
//
//  Created by JohnnyB0Y on 2017/5/3.
//  Copyright © 2017年 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTimerManager;
NS_ASSUME_NONNULL_BEGIN

/**
 // 使用须知
 
 1. AGTimerManager 对象管理一组 Timer，当 AGTimerManager 对象销毁时，自动停止所有 Timer。
 
 2. 调用ag_stopAllTimers()方法停止所有 Timer。
 
 3. LLDB 打印所有 Timer信息，po timerManager。
 
 4. 一个 AGTimerManager 控制多个 Timer，一个 Timer 控制多个 Task。
 
 */


typedef BOOL(^AGTMCountdownBlock)(NSTimeInterval surplus);
typedef void(^AGTMCompletionBlock)(void);
typedef BOOL(^AGTMRepeatBlock)(void);
typedef BOOL(^AGTMDateCountdownBlock)(NSCalendar *calendar, NSDateComponents *comp);


@interface AGTimerManager : NSObject

#pragma mark 多任务定时器🍩

/**
 准备定时器

 @param timerKey 定时器的Key（传指针变量的指针地址获取）
 @param ti 时间间隔
 @param delay 开始定时器的延迟时间
 */
- (void) ag_prepareTaskTimer:(NSString **)timerKey
                    interval:(NSTimeInterval)ti
                       delay:(NSTimeInterval)delay;


/**
 添加任务到指定定时器

 @param timerKey 指定定时器的Key
 @param taskToken 任务令牌
 @param repeatBlock 任务代码块
 @param completionBlock 任务停止后的回调代码块
 */
- (void) ag_addTaskForTimer:(NSString *)timerKey
                  taskToken:(NSString *)taskToken
                     repeat:(AGTMRepeatBlock)repeatBlock
                 completion:(nullable AGTMCompletionBlock)completionBlock;


/**
 从指定定时器移除任务

 @param timerKey 指定定时器的Key
 @param taskToken 任务令牌
 */
- (void) ag_removeTaskForTimer:(NSString *)timerKey
                     taskToken:(NSString *)taskToken;


/**
 开始定时器

 @param timerKey 指定定时器的Key
 @param mode 运行循环的模式
 */
- (void) ag_startTaskTimer:(NSString *)timerKey
                   forMode:(NSRunLoopMode)mode;


#pragma mark 停止定时器⚠️

/**
 停止对应 timerKey的定时器；
 
 @param timerKey 定时器的Key
 */
- (void) ag_stopTimerForKey:(NSString *)timerKey;


/**
 停止所有定时器；
 */
- (void) ag_stopAllTimers;

@end



@interface AGTimerManager (AGRepeatTimer)

#pragma mark 定时器⏰
/**
 开始并马上重复调用 repeatBlock，直到返回 NO  (NSRunLoopCommonModes)
 
 @param ti 调用间隔
 @param repeatBlock 执行的block 返回 NO 停止，返回 YES 继续。
 @return timer key
 */
- (NSString *) ag_startRepeatTimer:(NSTimeInterval)ti
                            repeat:(AGTMRepeatBlock)repeatBlock;

/**
 开始重复调用 repeatBlock，直到返回 NO  (NSRunLoopCommonModes)
 
 @param ti 调用间隔
 @param delay 执行前的延迟时间
 @param repeatBlock 执行的block 返回 NO 停止，返回 YES 继续。
 @return timer key
 */
- (NSString *) ag_startRepeatTimer:(NSTimeInterval)ti
                             delay:(NSTimeInterval)delay
                            repeat:(AGTMRepeatBlock)repeatBlock;

/**
 开始并马上重复调用 repeatBlock，直到返回 NO  (自定义NSRunLoopMode)
 
 @param ti 调用间隔
 @param mode 运行循环模式
 @param repeatBlock 执行的block 返回 NO 停止，返回 YES 继续。
 @return timer key
 */
- (NSString *) ag_startRepeatTimer:(NSTimeInterval)ti
                           forMode:(NSRunLoopMode)mode
                            repeat:(AGTMRepeatBlock)repeatBlock;

/**
 开始重复调用 repeatBlock，直到返回 NO  (自定义NSRunLoopMode)
 
 @param ti 调用间隔
 @param delay 执行前的延迟时间
 @param mode 运行循环模式
 @param repeatBlock 执行的block 返回 NO 停止，返回 YES 继续。
 @return timer key
 */
- (NSString *) ag_startRepeatTimer:(NSTimeInterval)ti
                             delay:(NSTimeInterval)delay
                           forMode:(NSRunLoopMode)mode
                            repeat:(AGTMRepeatBlock)repeatBlock;

@end



@interface AGTimerManager (AGDateTimer)

#pragma mark 日期倒计时📆
/**
 开始日期倒计时 (NSRunLoopCommonModes)
 
 @param date 未来日期
 @param ti 计数间隔
 @param countdownBlock 日期倒计时回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 日期倒计时完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownDate:(NSDate *)date
                            interval:(NSTimeInterval)ti
                           countdown:(AGTMDateCountdownBlock)countdownBlock
                          completion:(nullable AGTMCompletionBlock)completionBlock;

/**
 开始日期倒计时 (NSRunLoopCommonModes，计数间隔为1秒)
 
 @param date 未来日期
 @param countdownBlock 日期倒计时回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 日期倒计时完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownDate:(NSDate *)date
                           countdown:(AGTMDateCountdownBlock)countdownBlock
                          completion:(nullable AGTMCompletionBlock)completionBlock;

/**
 开始日期倒计时 (NSRunLoopCommonModes，计数间隔为1秒)
 
 @param timeIntervalSinceNow 与[NSDate date]的间隔秒数
 @param countdownBlock 日期倒计时回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 日期倒计时完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownDateInterval:(NSTimeInterval)timeIntervalSinceNow
                                   countdown:(AGTMDateCountdownBlock)countdownBlock
                                  completion:(nullable AGTMCompletionBlock)completionBlock;

@end



@interface AGTimerManager (AGCountDownTimer)

#pragma mark 倒计时⏳
/**
 开始倒计时，间隔为1秒 (NSRunLoopCommonModes)
 
 @param duration 计数值
 @param countdownBlock 计数回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 计数完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownTimer:(NSTimeInterval)duration
                            countdown:(nullable AGTMCountdownBlock)countdownBlock
                           completion:(nullable AGTMCompletionBlock)completionBlock;


/**
 开始倒计时 (NSRunLoopCommonModes)
 
 @param duration 计数值
 @param ti 计数间隔
 @param countdownBlock 计数回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 计数完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownTimer:(NSTimeInterval)duration
                             interval:(NSTimeInterval)ti
                            countdown:(nullable AGTMCountdownBlock)countdownBlock
                           completion:(nullable AGTMCompletionBlock)completionBlock;

/**
 开始倒计时 (自定义NSRunLoopMode)
 
 @param duration 计数值
 @param ti 计数间隔
 @param mode 运行循环模式
 @param countdownBlock 计数回调 block 返回 NO 停止，返回 YES 继续。
 @param completionBlock 计数完成 block
 @return timer key
 */
- (NSString *) ag_startCountdownTimer:(NSTimeInterval)duration
                             interval:(NSTimeInterval)ti
                              forMode:(NSRunLoopMode)mode
                            countdown:(nullable AGTMCountdownBlock)countdownBlock
                           completion:(nullable AGTMCompletionBlock)completionBlock;

@end

NS_ASSUME_NONNULL_END
