//
//  NSDictionary+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/7/12.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSDictionary+AGViewModel.h"
#import "AGVMKit.h"

@implementation NSDictionary (AGViewModel)

- (nullable NSString *) ag_safeStringForKey:(NSString *)key
{
    return ag_newNSStringWithObj(self[key]);
}

- (nullable NSURL *) ag_safeURLForKey:(NSString *)key
{
    return ag_safeURL(self[key]);
}

- (nullable NSNumber *) ag_safeNumberForKey:(NSString *)key
{
    return ag_safeNumber(self[key]);
}

- (nullable NSArray *) ag_safeArrayForKey:(NSString *)key
{
    return ag_safeArray(self[key]);
}

- (nullable NSDictionary *) ag_safeDictionaryForKey:(NSString *)key
{
    return ag_safeDictionary(self[key]);
}

- (nullable AGViewModel *) ag_safeViewModelForKey:(NSString *)key
{
    return ag_safeObj(self[key], [AGViewModel class]);
}

- (nullable AGVMSection *) ag_safeVMSectionForKey:(NSString *)key
{
    return ag_safeObj(self[key], [AGVMSection class]);
}

- (nullable AGVMManager *) ag_safeVMManagerForKey:(NSString *)key
{
    return ag_safeObj(self[key], [AGVMManager class]);
}

@end
