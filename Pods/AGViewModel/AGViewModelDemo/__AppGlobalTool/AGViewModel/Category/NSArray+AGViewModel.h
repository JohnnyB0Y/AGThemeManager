//
//  NSArray+AGViewModel.h
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/7/13.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGViewModel, AGVMSection, AGVMManager;

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (AGViewModel)

#pragma mark 安全取值
- (nullable id) ag_safeObjectAtIndex:(NSInteger)idx;
- (nullable NSString *) ag_safeStringAtIndex:(NSInteger)idx;
- (nullable NSURL *) ag_safeURLAtIndex:(NSInteger)idx;
- (nullable NSArray *) ag_safeArrayAtIndex:(NSInteger)idx;
- (nullable NSDictionary *) ag_safeDictionaryAtIndex:(NSInteger)idx;
- (nullable AGViewModel *) ag_safeViewModelAtIndex:(NSInteger)idx;
- (nullable AGVMSection *) ag_safeVMSectionAtIndex:(NSInteger)idx;
- (nullable AGVMManager *) ag_safeVMManagerAtIndex:(NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
