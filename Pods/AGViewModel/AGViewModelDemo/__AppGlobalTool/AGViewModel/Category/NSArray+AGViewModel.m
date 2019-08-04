//
//  NSArray+AGViewModel.m
//  AGViewModelDemo
//
//  Created by JohnnyB0Y on 2019/7/13.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "NSArray+AGViewModel.h"
#import "AGVMKit.h"

@implementation NSArray (AGViewModel)

#pragma mark 安全取值
- (id)ag_safeObjectAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return self[idx];
}

- (NSString *) ag_safeStringAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_newNSStringWithObj(self[idx]);
}

- (NSURL *) ag_safeURLAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeURL(self[idx]);
}

- (NSArray *) ag_safeArrayAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeArray(self[idx]);
}

- (NSDictionary *) ag_safeDictionaryAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeDictionary(self[idx]);
}

- (AGViewModel *) ag_safeViewModelAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeObj(self[idx], [AGViewModel class]);
}

- (AGVMSection *) ag_safeVMSectionAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeObj(self[idx], [AGVMSection class]);
}

- (AGVMManager *) ag_safeVMManagerAtIndex:(NSInteger)idx
{
    if ( NO == AGIsIndexInRange(-1, idx, self.count) ) return nil;
    return ag_safeObj(self[idx], [AGVMManager class]);
}

@end
