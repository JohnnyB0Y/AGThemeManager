//
//  AGThemePack.m
//  
//
//  Created by JohnnyB0Y on 2019/8/4.
//  Copyright © 2019 JohnnyB0Y. All rights reserved.
//

#import "AGThemePack.h"

@interface AGThemePack ()

@property (nonatomic, strong) NSMutableDictionary *dictM;

@end

@implementation AGThemePack

+ (instancetype)newWithPackName:(NSString *)name
{
    return [[self alloc] initWithPackName:name];
}

- (instancetype)initWithPackName:(NSString *)name
{
    self = [super init];
    
    if ( self ) {
        NSParameterAssert(name);
        _name = [name copy];
    }
    
    return self;
}

+ (instancetype)newWithContentOfFile:(NSString *)fileURL
{
    return [[self alloc] initWithContentOfFile:fileURL];
}

- (instancetype)initWithContentOfFile:(NSString *)fileURL
{
    self = [super init];
    return self;
}

+ (instancetype)newWithThemePackData:(id)data
{
    return [[self alloc] initWithThemePackData:data];
}

- (instancetype)initWithThemePackData:(id)data
{
    self = [super init];
    return self;
}

#pragma mark - ---------- Public Methods ----------
- (id) objectForKeyedSubscript:(NSString *)key
{
    NSParameterAssert(key);
    if ( key ) {
        return [_dictM objectForKey:key];
    }
    return nil;
}

- (void) setObject:(id)obj forKeyedSubscript:(NSString *)key
{
    NSParameterAssert(key);
    if ( key ) {
        [self.dictM setObject:obj forKey:key];
    }
}

#pragma mark - ----------- Getter Methods -----------
- (NSMutableDictionary *)dictM
{
    if ( nil == _dictM ) {
        _dictM = [NSMutableDictionary dictionary];
    }
    return _dictM;
}

@end
