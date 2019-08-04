//
//  NSDictionary+AGViewModel.h
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/7/12.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGViewModel, AGVMSection, AGVMManager;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AGViewModel)

#pragma mark 安全取值
- (nullable NSString *) ag_safeStringForKey:(NSString *)key;
- (nullable NSURL *) ag_safeURLForKey:(NSString *)key;
- (nullable NSArray *) ag_safeArrayForKey:(NSString *)key;
- (nullable NSDictionary *) ag_safeDictionaryForKey:(NSString *)key;
- (nullable AGViewModel *) ag_safeViewModelForKey:(NSString *)key;
- (nullable AGVMSection *) ag_safeVMSectionForKey:(NSString *)key;
- (nullable AGVMManager *) ag_safeVMManagerForKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
