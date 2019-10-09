//
//  AGBaseVerifier.h
//  AGVerifyManager
//
//  Created by JohnnyB0Y on 2019/8/7.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGVerifyManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface AGBaseVerifier : NSObject
<AGVerifyManagerVerifiable>

@property (class, readonly) AGBaseVerifier *defaultInstance;

/** 懒加载属性（是为了方便子类直接使用，而不用每次初始化） */
@property (nonatomic, strong, readonly, nullable) AGVerifyError *error;

//
// 子类重写，进行数据验证；（父类这里执行完会把error 置nil）
- (nullable AGVerifyError *) ag_verifyData:(id)data NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
